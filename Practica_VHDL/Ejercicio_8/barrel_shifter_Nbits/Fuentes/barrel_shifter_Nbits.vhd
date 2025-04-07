LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

-- Declaracion de entidad
ENTITY barrel_shifter_Nbits IS
    generic(
        N : natural := 8; 
        M : natural := 3 
    );
    PORT (
        a_i   : IN  std_logic_vector(N-1 DOWNTO 0);
        des_i : IN  std_logic_vector(M-1 downto 0);
        s_o   : OUT std_logic_vector(N-1 DOWNTO 0)
    );
END;

-- Declaracion cuerpo de arquitectura
ARCHITECTURE barrel_shifter_Nbits_arq OF barrel_shifter_Nbits IS
    -- Parte declarativa

BEGIN
    -- Parte descriptiva
    PROCESS(a_i, des_i)
    BEGIN
        -- Shift lógico a la izquierda
        s_o <= std_logic_vector( SHIFT_LEFT( unsigned(a_i), to_integer(unsigned(des_i)) ));
    END PROCESS;
END;