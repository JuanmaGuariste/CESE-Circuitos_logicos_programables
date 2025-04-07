library IEEE;
use IEEE.std_logic_1164.all;

-- Declaracion de entidad
entity barrel_shifter_Nbits_tb is   
end;

-- Declaracion cuerpo de arquitectura
architecture barrel_shifter_Nbits_tb_arq of barrel_shifter_Nbits_tb is
    -- Parte declarativa
    component barrel_shifter_Nbits IS
        generic(
            N : natural := 8; 
            M : natural := 3 
        );
        PORT (
            a_i   : IN  std_logic_vector(N-1 DOWNTO 0);
            des_i : IN  std_logic_vector(M-1 downto 0);
            s_o   : OUT std_logic_vector(N-1 DOWNTO 0)
        );
    end component;

    constant N_tb: natural := 8;
    constant M_tb: natural := 3;

    signal ent_tb: std_logic_vector (N_tb-1 downto 0) := "00000100";
    signal des_tb: std_logic_vector (M_tb-1 downto 0) := "000";
    signal sal_tb: std_logic_vector (N_tb-1 downto 0);

begin
    -- Parte descriptiva
    des_tb <= "001" after 50 ns, "010" after 100 ns, "011" after 150 ns, "100" after 200 ns;
    DUT: barrel_shifter_Nbits 
          generic map(
            N => N_tb,
            M => M_tb
          )
          port map(
            a_i => ent_tb,
            des_i => des_tb,
            s_o => sal_tb
          );
end;
