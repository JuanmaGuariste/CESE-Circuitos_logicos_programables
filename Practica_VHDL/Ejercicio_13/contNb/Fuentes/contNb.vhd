library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Declaracion de entidad
entity contNb is  
    generic (
        N      : natural := 4
    );
    port(
        clk_i    : in std_logic;
        rst_i    : in std_logic;
        ena_i    : in std_logic;
        cuenta_o : out std_logic_vector(N-1 downto 0)
    );
end;

-- Declaracion cuerpo de arquitectura
architecture contNb_arq of contNb is
    -- Parte declarativa
    signal cuenta : std_logic_vector(N-1 downto 0);
begin
    -- Parte descriptiva
    process(clk_i) begin
        if rising_edge(clk_i) then
          if rst_i = '1' then 
          cuenta <= (others => '0');
          elsif ena_i = '1' then
            cuenta <= std_logic_vector( unsigned(cuenta) + to_unsigned(1,N) );
            cuenta_o <= cuenta;
          end if;
        end if;
      end process;
end;
