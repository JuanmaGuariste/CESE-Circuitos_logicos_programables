library IEEE;
use IEEE.std_logic_1164.all;

-- Declaracion de entidad
entity sum1b_tb is   
end;

-- Declaracion cuerpo de arquitectura
architecture sum1b_tb_arq of sum1b_tb is
    -- Parte declarativa
    component sum1b is   
        port(
            a_i: in std_logic;
            b_i: in std_logic;
            ci_i: in std_logic;
            s_o: out std_logic;
            co_o: out std_logic
        );
    end component;

    signal a_tb : std_logic := '0';
    signal b_tb : std_logic := '0';
    signal ci_tb: std_logic := '0';
    signal s_tb : std_logic;
    signal co_tb : std_logic;
begin
    -- Parte descriptiva
    -- a_tb  <= '1' after 50 ns, '0' after 130 ns;
    -- b_tb  <= '1' after 80 ns, '0' after 110 ns;
    -- ci_tb <= '1' after 90 ns, '0' after 150 ns;

    a_tb <= not a_tb after 10 ns;
    b_tb <= not b_tb after 20 ns;
    ci_tb <= not ci_tb after 40 ns;
    
    DUT: sum1b
    port map(
        a_i  => a_tb,
        b_i  => b_tb,
        ci_i => ci_tb,
        s_o  => s_tb,
        co_o => co_tb
    );
end;
