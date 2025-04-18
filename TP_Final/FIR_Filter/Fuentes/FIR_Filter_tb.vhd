library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity FIR_Filter_tb is
end entity;

architecture FIR_Filter_arq of FIR_Filter_tb is
    constant clk_period : time := 8 ns;  -- 100 MHz clock
    constant DATA_W     : natural := 12;  -- Ancho de dato del FIR
    
    -- Señales de control
    signal clk          : std_logic := '0';
    signal rst          : std_logic := '1';
    signal salGenEna    : std_logic;
    
    -- Señales para generación de señales de prueba
    signal paso_sen_low   : unsigned(5 downto 0) := "000010";  -- Frecuencia baja
    signal paso_sen_high  : unsigned(5 downto 0) := "111110";  -- Frecuencia alta
    
    -- Señales de los NCOs (10 bits unsigned)
    signal sen_out_low    : unsigned(9 downto 0);
    signal sen_out_high   : unsigned(9 downto 0);    

    signal sen_out_ext    : std_logic_vector(11 downto 0);
    
    -- Salida del FIR (12 bits)
    signal fir_out        : std_logic_vector(11 downto 0);

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
            NUM_TAPS : natural := 33;
            DATA_W   : natural := 12
        );
        port(
            clk_i  : in std_logic;
            rst_i  : in std_logic;
            ena_i  : in std_logic;
            data_i : in std_logic_vector(DATA_W - 1 downto 0);
            data_o : out std_logic_vector(DATA_W - 1 downto 0)
        );
    end component;

    component genEna is  
        generic (
            N : natural := 10
        );
        port(
            clk_i : in std_logic;
            rst_i : in std_logic;
            ena_i : in std_logic;
            q_o   : out std_logic
        );
    end component;

begin
    -- Generador de reloj
    clk <= not clk after clk_period/2;

    -- Secuencia de reset
    rst <= '1', '0' after 100 ns;

    -- Instancia NCO para señal de baja frecuencia
    uut_nco_low: nco
        generic map(
            DATA_W => 11,
            ADDR_W => 12,
            modulo => 32767,
            PASO_W => 6
        ) 
        port map(
            clk => clk,
            rst => rst,
            paso => paso_sen_low,
            salida_sen => sen_out_low,
            salida_cos => open
        );

    -- Instancia NCO para señal de alta frecuencia
    uut_nco_high: nco
        generic map(
            DATA_W => 11,
            ADDR_W => 12,
            modulo => 32767,
            PASO_W => 6
        )
        port map(
            clk => clk,
            rst => rst,
            paso => paso_sen_high,
            salida_sen => sen_out_high,
            salida_cos => open
        );

        process(clk)
        begin
            if rising_edge(clk) then
                if salGenEna = '1' then 
                    -- Ajusta el tamaño de las señales y las suma
                    sen_out_ext <= std_logic_vector(resize(sen_out_low,12) + resize(sen_out_high,12));        
                end if;
            end if;
        end process;

    -- Instancia del filtro FIR
    uut_fir: FIR_Filter
        generic map(
            NUM_TAPS => 33,
            DATA_W => DATA_W
        )
        port map(
            clk_i => clk,
            rst_i => rst,
            ena_i => salGenEna,
            data_i => sen_out_ext,
            data_o => fir_out
        );
        
    -- Generador de habilitación (cada 10 ciclos de reloj)
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