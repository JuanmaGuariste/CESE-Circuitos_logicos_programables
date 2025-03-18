library IEEE;
use IEEE.std_logic_1164.all;

-- Declaracion de entidad
entity mux1b_tb is   
end;

-- Declaracion cuerpo de arquitectura
architecture mux1b_tb_arq of mux1b_tb is
    -- Parte declarativa
    component mux1b is   
        port(
            a_i   : in std_logic;
            b_i   : in std_logic;
            sel_i : in std_logic;
            s_o   : out std_logic
        );
    end component;

    signal a_tb   : std_logic := '0';
    signal b_tb   : std_logic := '0';
    signal sel_tb : std_logic := '0';
    signal s_tb   : std_logic;
begin
    -- Parte descriptiva
    a_tb   <= not a_tb after 10 ns;
    b_tb   <= not b_tb after 20 ns;
    sel_tb <= not sel_tb after 40 ns;
    
    DUT: mux1b
    port map(
        a_i   => a_tb,
        b_i   => b_tb,
        sel_i => sel_tb,
        s_o   => s_tb
    );
end;
