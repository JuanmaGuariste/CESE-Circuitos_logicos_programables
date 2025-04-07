library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Declaracion de entidad
entity genEna_tb is   
end;

-- Declaracion cuerpo de arquitectura
architecture genEna_tb_arq of genEna_tb is
    -- Parte declarativa
    component genEna is  
        generic (
            N      : natural := 4
        );
        port(
            clk_i  : in std_logic;
            rst_i  : in std_logic;
            ena_i  : in std_logic;
            q_o    : out std_logic
        );
    end component;
    constant N_tb : natural := 4;
    signal rst_tb : std_logic := '1';
    signal clk_tb : std_logic := '0';
    signal ena_tb : std_logic := '1';
    signal q_tb   : std_logic;

begin
    -- Parte descriptiva

    clk_tb <= not clk_tb after 10 ns;
    rst_tb <= '0' after 40 ns, '1' after 600 ns, '0' after 650 ns;
    ena_tb <= '0' after 250 ns, '1' after 350 ns; 

    DUT: genEna  
    generic map (
        N => N_tb
    )
    port map(
        rst_i => rst_tb,
        clk_i => clk_tb,
        ena_i => ena_tb,
        q_o   => q_tb
    );
end;
