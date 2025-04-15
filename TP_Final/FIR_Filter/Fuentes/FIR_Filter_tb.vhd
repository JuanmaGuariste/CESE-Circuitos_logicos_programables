library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity FIR_Filter_tb is
end entity;

architecture test of FIR_Filter_tb is

    constant clk_period : time := 10 ns;

    signal clk      : std_logic := '0';
    signal rst      : std_logic := '1';
    signal paso_sen_low  : unsigned(5 downto 0) := "000011";
    signal paso_sen_high : unsigned(5 downto 0) := "110000";
    signal sen_out_low  : unsigned(9 downto 0);
    signal sen_out_high : unsigned(9 downto 0);
    signal sen_low_c   : signed(15 downto 0);
    signal sen_high_c  : signed(15 downto 0);
    signal sen_sum_signed : signed(15 downto 0);
    signal sen_out_ext    : std_logic_vector(15 downto 0);
    signal fir_out        : std_logic_vector(31 downto 0);
    signal salGenEna : std_logic;

    component nco
        generic(
            DATA_W: natural := 11;
            ADDR_W: natural := 12;
            modulo: natural := 32767;
            PASO_W: natural := 6
        );
        port(
            clk: in std_logic;
            rst: in std_logic;
            paso: in unsigned(PASO_W-1 downto 0);
            salida_cos: out unsigned(DATA_W-2 downto 0);
            salida_sen: out unsigned(DATA_W-2 downto 0)
        );
    end component;

    component FIR_Filter
        generic(
            NUM_TAPS : natural := 33
        );
        port(
            clk_i     : in std_logic;
            rst_i     : in std_logic;
            ena_i     : in std_logic;
            data_i    : in std_logic_vector(15 downto 0);
            data_o    : out std_logic_vector(31 downto 0)
        );
    end component;

    component genEna is  
        generic (
            N      : natural := 1000
        );
        port(
            clk_i  : in std_logic;
            rst_i  : in std_logic;
            ena_i  : in std_logic;
            q_o    : out std_logic
        );
    end component;

begin
    -- Generador de clock
    clk <= not clk after clk_period/2;

    -- Reset
    rst <= '1', '0' after 100 ns;

    -- NCO de baja frecuencia
    uut_nco_low: nco
        port map(
            clk => clk,
            rst => rst,
            paso => paso_sen_low,
            salida_sen => sen_out_low,
            salida_cos => open
        );

    -- NCO de alta frecuencia
    uut_nco_high: nco
        port map(
            clk => clk,
            rst => rst,
            paso => paso_sen_high,
            salida_sen => sen_out_high,
            salida_cos => open
        );

    -- Se centra cada seno restando 512 (media de 10 bits sin signo)
    sen_low_c <= signed(resize(sen_out_low,16)) - to_signed(512,16);
    sen_high_c <= signed(resize(sen_out_high,16)) - to_signed(512,16);

    -- Suma de senoidales centradas en cero
    sen_sum_signed <= sen_low_c + sen_high_c;

    -- Conversión para el filtro FIR
    sen_out_ext <= std_logic_vector(sen_sum_signed);

    -- Instancia del filtro FIR
    uut_fir: FIR_Filter
        port map(
            clk_i => clk,
            rst_i => rst,
            ena_i => salGenEna,
            data_i => sen_out_ext,
            data_o => fir_out
        );
        
    -- Generador de habilitación
    uut_genEna: genEna
        generic map(
            N => 10
        )
        port map(
            clk_i => clk,
            rst_i => rst,
            ena_i => '1',
            q_o => salGenEna
        );

end architecture;
