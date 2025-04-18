library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

entity FIR_Filter is
    generic (
        NUM_TAPS : natural := 33;  -- Orden 32 (N+1 taps)
        DATA_W   : natural := 12   -- Ancho de palabra de datos
    );
    port(
        clk_i   : in  std_logic;
        rst_i   : in  std_logic;
        ena_i   : in  std_logic;
        data_i  : in  std_logic_vector(DATA_W - 1 downto 0);
        data_o  : out std_logic_vector(DATA_W - 1 downto 0)
    );
end entity;

architecture FIR_Filter_arq of FIR_Filter is
    type coef_array_t is array(0 to NUM_TAPS - 1) of signed(DATA_W - 1 downto 0);
    type sample_array_t is array(0 to NUM_TAPS - 1) of signed(DATA_W - 1 downto 0);

    -- Coeficientes del filtro FIR con ventana de Hamming (fc = 0.1, orden 32)
    -- Escalados a 12 bits con factor de 2047
    constant h : coef_array_t := (
        to_signed(-9, DATA_W),   to_signed(-16, DATA_W),  to_signed(-24, DATA_W),
        to_signed(-28, DATA_W),  to_signed(-22, DATA_W),  to_signed(-1, DATA_W),
        to_signed(37, DATA_W),   to_signed(89, DATA_W),   to_signed(147, DATA_W),
        to_signed(201, DATA_W),  to_signed(239, DATA_W),  to_signed(251, DATA_W),
        to_signed(231, DATA_W),  to_signed(180, DATA_W),  to_signed(104, DATA_W),
        to_signed(14, DATA_W),   to_signed(-76, DATA_W),  to_signed(-150, DATA_W),
        to_signed(-196, DATA_W), to_signed(-204, DATA_W), to_signed(-172, DATA_W),
        to_signed(-106, DATA_W), to_signed(-19, DATA_W),  to_signed(70, DATA_W),
        to_signed(142, DATA_W),  to_signed(180, DATA_W),  to_signed(180, DATA_W),
        to_signed(142, DATA_W),  to_signed(70, DATA_W),   to_signed(-19, DATA_W),
        to_signed(-106, DATA_W), to_signed(-172, DATA_W), to_signed(-204, DATA_W)
    );

    signal x_reg : sample_array_t := (others => (others => '0'));

begin
    process(clk_i)
        variable acc : signed(2*DATA_W + integer(ceil(log2(real(NUM_TAPS))))-1 downto 0);
        variable acc_rescaled : signed(DATA_W-1 downto 0);
    begin
        if rising_edge(clk_i) then
            if rst_i = '1' then
                x_reg  <= (others => (others => '0'));
                data_o <= (others => '0');
            elsif ena_i = '1' then
                -- Desplazar muestras
                for i in NUM_TAPS - 1 downto 1 loop
                    x_reg(i) <= x_reg(i - 1);
                end loop;
                x_reg(0) <= signed(data_i);

                -- Multiplicación y acumulación
                acc := (others => '0');
                for i in 0 to NUM_TAPS - 1 loop
                    acc := acc + h(i) * x_reg(i);
                end loop;

                -- Normalización con redondeo
                data_o <= std_logic_vector(resize(shift_right(acc + 1024, 11), DATA_W));
                --acc_rescaled := resize(shift_right(acc + to_signed(1024, acc'length), 11), DATA_W);
                --data_o <= std_logic_vector(acc_rescaled);      
            end if;
        end if;
    end process;
end architecture;