library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity FIR_Filter_VIO is
    port(
        clk_i : in std_logic
    );
end entity;

architecture FIR_Filter_VIO_arq of FIR_Filter_VIO is
    signal sen_out_low         : unsigned(9 downto 0);          -- Señal para salida senoidal del NCO de baja frecuencia
    signal sen_out_high        : unsigned(9 downto 0);          -- Señal para salida senoidal del NCO de alta frecuencia
    signal sen_out_ext         : std_logic_vector(11 downto 0); -- Señal extendida donde se combinan las dos senoidales
    signal fir_out             : std_logic_vector(11 downto 0); -- Salida final del filtro FIR
    signal salGenEna           : std_logic;                     -- Señal de habilitación generada por genEna
    signal probe_paso_sen_low  : std_logic_vector(5 downto 0);  -- Paso NCO low
    signal probe_paso_sen_high : std_logic_vector(5 downto 0);  -- Paso NCO high
    signal probe_rst           : std_logic_vector(0 downto 0);  -- Reset global controlado desde VIO

    -- Componente para Virtual I/O (VIO) de debug y control desde Vivado
    component vio_0
    port (
            clk        : in std_logic;
            probe_out0 : out std_logic_vector(5 downto 0);
            probe_out1 : out std_logic_vector(5 downto 0);
            probe_out2 : out std_logic_vector(0 downto 0)
        );
        end component;

    -- Componente para Integrated Logic Analyzer (ILA) - capturar señales para debug
    component ila_0    
    port (
            clk    : in std_logic;  
            probe0 : in std_logic_vector(11 downto 0);
            probe1 : in std_logic_vector(11 downto 0)
        );
        end component;

    -- NCO: Oscilador controlado numéricamente para generar senoidales discretas
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

    -- Filtro FIR: filtra las senoidales combinadas generadas por los NCO
    component FIR_Filter
        generic(
            NUM_TAPS : natural := 33
        );
        port(
            clk_i  : in std_logic;
            rst_i  : in std_logic;
            ena_i  : in std_logic;
            data_i : in std_logic_vector(11 downto 0);
            data_o : out std_logic_vector(11 downto 0)
        );
    end component;

    -- Generador de enable: divide la frecuencia del clock para controlar cada cuánto procesa el FIR
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
    -- Combinación de las dos senoidales (baja y alta) una vez por cada habilitación generada
    process(clk_i)
    begin
        if rising_edge(clk_i) then
            if salGenEna = '1' then 
                -- Ajusta el tamaño de las señales y las suma
                sen_out_ext <= std_logic_vector(resize(sen_out_low,12) + resize(sen_out_high,12));        
            end if;
        end if;
    end process;

    -- Instancia del VIO
    inst_vio : vio_0
        port map (
            clk        => clk_i,
            probe_out0 => probe_paso_sen_low,
            probe_out1 => probe_paso_sen_high,
            probe_out2 => probe_rst
        );

    -- Instancia del ILA 
    inst_ila : ila_0
        port map (
            clk    => clk_i, 
            probe0 => sen_out_ext,
            probe1 => fir_out
        );

    -- NCO de baja frecuencia
    inst_nco_low: nco
        port map(
            clk        => clk_i,
            rst        => probe_rst(0),
            paso       => unsigned(probe_paso_sen_low),
            salida_sen => sen_out_low,
            salida_cos => open
        );

    -- NCO de alta frecuencia
    inst_nco_high: nco
        port map(
            clk        => clk_i,
            rst        => probe_rst(0),
            paso       => unsigned(probe_paso_sen_high),
            salida_sen => sen_out_high,
            salida_cos => open
        );

    -- Filtro FIR que procesa la señal compuesta generada por los NCO
    inst_fir: FIR_Filter
        port map(
            clk_i  => clk_i,
            rst_i  => probe_rst(0),
            ena_i  => salGenEna,
            data_i => sen_out_ext,
            data_o => fir_out
        );

    -- Generador de habilitación: crea un pulso cada N ciclos
    inst_genEna: genEna
        generic map(
            N => 10 -- Cada 10 ciclos de reloj se genera habilitación
        )
        port map(
            clk_i => clk_i,
            rst_i => probe_rst(0),
            ena_i => '1',
            q_o   => salGenEna
        );

end architecture;