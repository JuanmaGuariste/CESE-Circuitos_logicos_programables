library IEEE;
use IEEE.std_logic_1164.all;

-- Declaracion de entidad
entity mux1b is   
    port(
        a_i   : in std_logic;
        b_i   : in std_logic;
        sel_i : in std_logic;
        s_o   : out std_logic
    );
end;

-- Declaracion cuerpo de arquitectura
architecture mux1b_arq of mux1b is
    -- Parte declarativa
begin
    -- Parte descriptiva
    s_o <= (a_i and sel_i) or (b_i and (not sel_i));
end;
