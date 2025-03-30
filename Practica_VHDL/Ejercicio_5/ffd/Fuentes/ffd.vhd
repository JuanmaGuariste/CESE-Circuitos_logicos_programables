LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

-- Declaracion de entidad
ENTITY ffd IS
    PORT (
        clk_i : IN STD_LOGIC;
        rst_i : IN STD_LOGIC;
        ena_i : IN STD_LOGIC;
        d_i   : IN STD_LOGIC;
        q_o   : OUT STD_LOGIC
    );
END;

-- Declaracion cuerpo de arquitectura
ARCHITECTURE ffd_arq OF ffd IS
    -- Parte declarativa
BEGIN
    -- Parte descriptiva
    process(clk_i)
    begin
        if rising_edge(clk_i) then
            if rst_i = '1' then
                q_o <= '0';
            elsif ena_i = '1' then
                q_o <= d_i;
        --  else
        --       q_o <= q_o; --No es necesario esta linea ya que por defecto eso es lo que ocurre (la salida mantiene su estado)
            end if;
        end if;
    end process;

END;