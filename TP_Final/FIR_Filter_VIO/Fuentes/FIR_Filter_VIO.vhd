library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity FIR_Filter_VIO is
    port(
        clk_i : in std_logic
    );
end entity;

architecture FIR_Filter_VIO_arq of FIR_Filter_VIO is


    signal paso_sen_low  : unsigned(5 downto 0);
    signal paso_sen_high : unsigned(5 downto 0);

    signal sen_out_low  : unsigned(9 downto 0);
    signal sen_out_high : unsigned(9 downto 0);
    signal sen_low_c    : signed(15 downto 0);
    signal sen_high_c   : signed(15 downto 0);
    signal sen_sum_signed : signed(15 downto 0);
    signal sen_out_ext    : std_logic_vector(15 downto 0);
    signal fir_out        : std_logic_vector(31 downto 0);
    signal salGenEna      : std_logic;

    -- Señales para el VIO
    signal probe_paso_sen_low  : std_logic_vector(5 downto 0);
    signal probe_paso_sen_high : std_logic_vector(5 downto 0);
    signal probe_rst           : std_logic_vector(0 downto 0);

    COMPONENT vio_0
        PORT (
            clk        : IN STD_LOGIC;
            probe_out0 : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
            probe_out1 : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
            probe_out2 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
        );
    END COMPONENT;

    component nco
        generic(
            DATA_W : natural := 11;
            ADDR_W : natural := 12;
            modulo : natural := 32767;
            PASO_W : natural := 6
        );
        port(
            clk        : in std_logic;
            rst        : in std_logic;
            paso       : in unsigned(PASO_W-1 downto 0);
            salida_cos : out unsigned(DATA_W-2 downto 0);
            salida_sen : out unsigned(DATA_W-2 downto 0)
        );
    end component;

    component FIR_Filter
        generic(
            NUM_TAPS : natural := 33
        );
        port(
            clk_i  : in std_logic;
            rst_i  : in std_logic;
            ena_i  : in std_logic;
            data_i : in std_logic_vector(15 downto 0);
            data_o : out std_logic_vector(31 downto 0)
        );
    end component;

    component genEna is  
        generic (
            N : natural := 1000
        );
        port(
            clk_i : in std_logic;
            rst_i : in std_logic;
            ena_i : in std_logic;
            q_o   : out std_logic
        );
    end component;

begin

    -- VIO instanciado
    inst_vio : vio_0
        port map (
            clk        => clk_i,
            probe_out0 => probe_paso_sen_low,
            probe_out1 => probe_paso_sen_high,
            probe_out2 => probe_rst
        );

    -- Conversión del paso de std_logic_vector a unsigned
    paso_sen_low  <= unsigned(probe_paso_sen_low);
    paso_sen_high <= unsigned(probe_paso_sen_high);

    -- NCOs
    inst_nco_low: nco
        port map(
            clk        => clk_i,
            rst        => probe_rst(0),
            paso       => paso_sen_low,
            salida_sen => sen_out_low,
            salida_cos => open
        );

    inst_nco_high: nco
        port map(
            clk        => clk_i,
            rst        => probe_rst(0),
            paso       => paso_sen_high,
            salida_sen => sen_out_high,
            salida_cos => open
        );

    -- Resteo de media (512) para centrar
    sen_low_c  <= signed(resize(sen_out_low,16)) - to_signed(512,16);
    sen_high_c <= signed(resize(sen_out_high,16)) - to_signed(512,16);

    -- Suma de senoidales centradas
    sen_sum_signed <= sen_low_c + sen_high_c;

    -- Conversión para el filtro
    sen_out_ext <= std_logic_vector(sen_sum_signed);

    -- Filtro FIR
    inst_fir: FIR_Filter
        port map(
            clk_i  => clk_i,
            rst_i  => probe_rst(0),
            ena_i  => salGenEna,
            data_i => sen_out_ext,
            data_o => fir_out
        );

    -- Generador de habilitación
    inst_genEna: genEna
        generic map(
            N => 10
        )
        port map(
            clk_i => clk_i,
            rst_i => probe_rst(0),
            ena_i => '1',
            q_o   => salGenEna
        );

end architecture;
