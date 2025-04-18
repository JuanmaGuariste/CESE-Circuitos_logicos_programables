library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

entity FIR_Filter is
    generic (
        NUM_TAPS : natural := 33; -- Orden 32 (N+1 taps)
        DATA_W   : natural := 12  -- Ancho de palabra de datos
    );
    port(
        clk_i  : in  std_logic;
        rst_i  : in  std_logic;
        ena_i  : in  std_logic;
        data_i : in  std_logic_vector(DATA_W - 1 downto 0);
        data_o : out std_logic_vector(DATA_W - 1 downto 0)
    );
end entity;

architecture FIR_Filter_arq of FIR_Filter is
    -- Arreglo para los coeficientes FIR y para las muestras de entrada (registro de desplazamiento).
    type coef_array_t is array(0 to NUM_TAPS - 1) of signed(DATA_W - 1 downto 0);
    type sample_array_t is array(0 to NUM_TAPS - 1) of signed(DATA_W - 1 downto 0);

    -- Coeficientes del filtro FIR con ventana de Hamming (fcorte = 300kHz, fs = 12.5MHz, orden 32)
    -- Escalados para punto fijo Q1.11 (multiplicados por 2^11) y truncados a 12 bits.
  
    constant h : coef_array_t := (
        to_signed(1,  DATA_W), to_signed(2,  DATA_W), to_signed(3,  DATA_W),
        to_signed(6,  DATA_W), to_signed(10, DATA_W), to_signed(16, DATA_W),
        to_signed(23, DATA_W), to_signed(33, DATA_W), to_signed(43, DATA_W),
        to_signed(55, DATA_W), to_signed(68, DATA_W), to_signed(80, DATA_W),
        to_signed(91, DATA_W), to_signed(101, DATA_W), to_signed(108, DATA_W),
        to_signed(113, DATA_W), to_signed(115, DATA_W), to_signed(113, DATA_W),
        to_signed(108, DATA_W), to_signed(101, DATA_W), to_signed(91, DATA_W),
        to_signed(80, DATA_W), to_signed(68, DATA_W), to_signed(55, DATA_W),
        to_signed(43, DATA_W), to_signed(33, DATA_W), to_signed(23, DATA_W),
        to_signed(16, DATA_W), to_signed(10, DATA_W), to_signed(6, DATA_W),
        to_signed(3, DATA_W), to_signed(2, DATA_W), to_signed(1, DATA_W)
);    

    -- Registro de desplazamiento para almacenar las últimas NUM_TAPS muestras
    signal x_reg : sample_array_t := (others => (others => '0'));

begin
    process(clk_i)
        variable acc : signed(2*DATA_W + integer(ceil(log2(real(NUM_TAPS)))) - 1 downto 0);
    begin
        if rising_edge(clk_i) then
            if rst_i = '1' then
                x_reg  <= (others => (others => '0'));
                data_o <= (others => '0');
            elsif ena_i = '1' then
                -- Desplazar las muestras en el registro (nueva muestra en x_reg(0))
                for i in NUM_TAPS - 1 downto 1 loop
                    x_reg(i) <= x_reg(i - 1);
                end loop;
                x_reg(0) <= signed(data_i);
                -- Inicializar acumulador
                acc := (others => '0');
                 -- Filtro FIR: suma de productos muestra x coeficiente
                for i in 0 to NUM_TAPS - 1 loop
                    acc := acc + h(i) * x_reg(i);
                end loop;
                -- Normalización: dividir por 2^11 (punto fijo Q1.11) usando shift.
                -- Ajuste de escala para obtener el valor final a devolver.
                data_o <= std_logic_vector(resize(shift_right(acc, 11), DATA_W));          
            end if;
        end if;
    end process;
end architecture;
