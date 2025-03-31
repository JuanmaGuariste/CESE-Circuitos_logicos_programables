library IEEE;
use IEEE.std_logic_1164.all;

-- Declaracion de entidad
entity sum_rest_Nb_tb is   
end;

-- Declaracion cuerpo de arquitectura
architecture sum_rest_Nb_tb_arq of sum_rest_Nb_tb is
    -- Parte declarativa
    component sum_rest_Nb is  
        generic(
            N: natural := 4
        );
        port(
            a_i  : in std_logic_vector(N-1 downto 0);
            b_i  : in std_logic_vector(N-1 downto 0);
            op_i : in std_logic; -- Señal de control: 0 -> Suma, 1 -> Resta
            s_o  : out std_logic_vector(N-1 downto 0);
            co_o : out std_logic
        );
    end component;

    constant N_tb: natural := 4;
    signal a_tb : std_logic_vector(N_tb-1 downto 0) := "0111";
    signal b_tb : std_logic_vector(N_tb-1 downto 0) := "0101";
    signal op_tb: std_logic := '0';
    signal s_tb : std_logic_vector(N_tb-1 downto 0);
    signal co_tb : std_logic;
begin
    -- Parte descriptiva
    a_tb  <= "0100" after 60 ns, "1000" after 200 ns;
    b_tb  <= "0001" after 60 ns, "0100" after 200 ns;
    op_tb <=  not op_tb after 50 ns;
    
    DUT: sum_rest_Nb
    generic map(
        N => N_tb
    )
    port map(
        a_i  => a_tb,
        b_i  => b_tb,
        op_i => op_tb,
        s_o  => s_tb,
        co_o => co_tb
    );
end;