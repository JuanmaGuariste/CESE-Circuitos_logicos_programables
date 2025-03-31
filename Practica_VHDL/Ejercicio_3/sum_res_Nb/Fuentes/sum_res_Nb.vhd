library IEEE;
use IEEE.std_logic_1164.all;

-- Declaracion de entidad
entity sum_rest_Nb  is  
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
end;

-- Declaracion cuerpo de arquitectura
architecture sum_rest_Nb_arq of sum_rest_Nb is
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

    signal carry: std_logic_vector(N downto 0);
    signal b_aux: std_logic_vector(N-1 downto 0); --> B modificado según la operación

begin
    -- Parte descriptiva
    carry(0) <= op_i;  --> Se usa como bit de acarreo inicial para la resta
    co_o <= carry(N);   

    sum1b_gen: for i in 0 to N-1 generate
        b_aux(i) <= b_i(i) xor op_i;
        sum1b_i: sum1b
            port map(
                a_i  => a_i(i),
                b_i  => b_aux(i),
                ci_i => carry(i),
                s_o  => s_o(i),
                co_o  => carry(i+1)
            );
    end generate;
end;
