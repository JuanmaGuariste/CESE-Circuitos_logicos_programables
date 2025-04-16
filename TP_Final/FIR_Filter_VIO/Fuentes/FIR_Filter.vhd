library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity FIR_Filter is
    generic (
        NUM_TAPS : natural := 33  -- Número total de coeficientes
    );
    port(
        clk_i   : in std_logic;
        rst_i   : in std_logic;
        ena_i   : in std_logic;
        data_i  : in std_logic_vector(15 downto 0);
        data_o  : out std_logic_vector(31 downto 0)
    );
end;

architecture FIR_Filter_arq of FIR_Filter is
    type coef_array_t is array(0 to NUM_TAPS-1) of signed(15 downto 0);
    type sample_array_t is array(0 to NUM_TAPS-1) of signed(15 downto 0);

    constant h : coef_array_t := (
        to_signed(5, 16),
        to_signed(9, 16),
        to_signed(14, 16),
        to_signed(21, 16),
        to_signed(30, 16),
        to_signed(42, 16),
        to_signed(58, 16),
        to_signed(78, 16),
        to_signed(102, 16),
        to_signed(131, 16),
        to_signed(165, 16),
        to_signed(204, 16),
        to_signed(248, 16),
        to_signed(295, 16),
        to_signed(345, 16),
        to_signed(397, 16),
        to_signed(450, 16),
        to_signed(503, 16),
        to_signed(555, 16),
        to_signed(606, 16),
        to_signed(654, 16),
        to_signed(699, 16),
        to_signed(741, 16),
        to_signed(778, 16),
        to_signed(811, 16),
        to_signed(838, 16),
        to_signed(861, 16),
        to_signed(878, 16),
        to_signed(889, 16),
        to_signed(894, 16),
        to_signed(894, 16),
        to_signed(889, 16),
        to_signed(878, 16)
    );

    signal x_reg : sample_array_t := (others => (others => '0'));

begin
    process(clk_i)
        variable acc_var     : signed(63 downto 0);
        variable mult_result : signed(63 downto 0);
    begin
        if rising_edge(clk_i) then
            if rst_i = '1' then
                x_reg <= (others => (others => '0'));
                data_o <= (others => '0');
            elsif ena_i = '1' then
                -- Shift register de muestras
                for i in NUM_TAPS-1 downto 1 loop
                    x_reg(i) <= x_reg(i-1);
                end loop;
                x_reg(0) <= signed(data_i);
                -- Acumulador
                acc_var := (others => '0');
                for i in 0 to NUM_TAPS-1 loop
                    mult_result := resize(h(i), 32) * resize(x_reg(i), 32);
                    acc_var := acc_var + mult_result;
                end loop;
                -- Q15 shift
                data_o <= std_logic_vector(resize(shift_right(acc_var, 15), 32));
            end if;
        end if;
    end process;
end architecture;
