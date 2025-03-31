library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Declaracion de entidad
entity cont4b_tb is   
end;

-- Declaracion cuerpo de arquitectura
architecture cont4b_tb_arq of cont4b_tb is
    -- Parte declarativa
    component cont4b is  
        port(
            clk_i    : in std_logic;
            rst_i    : in std_logic;
            ena_i    : in std_logic;
            cuenta_o : out std_logic_vector(3 downto 0);
            max_o    : out std_logic
        );
    end component;

    --constant N_tb: natural :=  4;
    signal clk_tb    : std_logic := '0';
    signal rst_tb    : std_logic := '1';
    signal ena_tb    : std_logic := '1';
    signal cuenta_tb : std_logic_vector(3 downto 0);
    signal max_tb    : std_logic;

begin
    -- Parte descriptiva
    clk_tb <=  not clk_tb after 10 ns;
    rst_tb <= '0' after 40 ns;
    ena_tb <= '0' after 250 ns, '1' after 350 ns;

    DUT: cont4b  
    port map(
        clk_i    => clk_tb,
        rst_i    => rst_tb,
        ena_i    => ena_tb,
        cuenta_o => cuenta_tb,
        max_o    => max_tb
    );
end;
