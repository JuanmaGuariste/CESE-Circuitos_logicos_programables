library IEEE;
use IEEE.std_logic_1164.all;

-- Declaracion de entidad
entity cont4b is  
    port(
        clk_i    : in std_logic;
        rst_i    : in std_logic;
        ena_i    : in std_logic;
        cuenta_o : out std_logic_vector(3 downto 0)
    );
end;

-- Declaracion cuerpo de arquitectura
architecture cont4b_arq of cont4b is
    -- Parte declarativa
    signal salAnd : std_logic_vector(2 downto 0);
    signal d      : std_logic_vector(3 downto 0);
    signal q      : std_logic_vector(3 downto 0);
    component reg is
        generic(
            N: natural := 4
        );
        PORT (
            clk_i : IN STD_LOGIC;
            rst_i : IN STD_LOGIC;
            ena_i : IN STD_LOGIC;
            d_i   : IN STD_LOGIC_vector(N-1 downto 0);
            q_o   : OUT STD_LOGIC_vector(N-1 downto 0)
        );
    end component;
begin
    -- Parte descriptiva
    reg_inst: reg 
        generic map(
            N => 4
        )
        port map(
            clk_i => clk_i,
            rst_i => rst_i,
            ena_i => ena_i,
            d_i   => d,
            q_o   => q
        );

        cuenta_o  <= q;
        d(0)      <= ena_i xor q(0);
        salAnd(0) <= ena_i and q(0);
        d(1)      <= salAnd(0)  xor q(1);
        salAnd(1) <= salAnd(0)  and q(1); 
        d(2)      <= salAnd(1)  xor q(2);
        salAnd(2) <= salAnd(1)  and q(2);
        d(3)      <= salAnd(2)  xor q(3);
end;
