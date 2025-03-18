library IEEE;
use IEEE.std_logic_1164.all;

-- Declaracion de entidad
entity neg_tb is   
end;

-- Declaracion cuerpo de arquitectura
architecture neg_tb_arq of neg_tb is
    -- Parte declarativa
    component neg is   
        port(
            a_i: in std_logic;
            b_o: out std_logic
        );
    end component;

    signal a_tb: std_logic := '0';
    signal b_tb: std_logic;
begin
    -- Parte descriptiva
    a_tb <= '1' after 100 ns, '0' after 150 ns, '1' after 400 ns;
    DUT: neg
    port map(
        a_i => a_tb,
        b_o => b_tb
    );
end;
