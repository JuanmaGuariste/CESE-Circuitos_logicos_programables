library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Declaracion de entidad
entity contNb_tb is   
end;

-- Declaracion cuerpo de arquitectura
architecture contNb_tb_arq of contNb_tb is
    -- Parte declarativa
    component contNb is  
        generic (
            N      : natural := 4
        );
        port(
            clk_i    : in std_logic;
            rst_i    : in std_logic;
            ena_i    : in std_logic;
            cuenta_o : out std_logic_vector(N-1 downto 0)
        );
    end component;

    constant N_tb: natural :=  4;

    signal clk_tb    : std_logic := '0';
    signal rst_tb    : std_logic := '1';
    signal ena_tb    : std_logic := '1';
    signal cuenta_tb : std_logic_vector(N_tb-1 downto 0);

begin
    -- Parte descriptiva
    clk_tb <=  not clk_tb after 10 ns;
    rst_tb <= '0' after 40 ns, '1' after 530 ns, '0' after 550 ns;
    ena_tb <= '0' after 250 ns, '1' after 350 ns;

    DUT: contNb  
    generic map (
        N => N_tb
    )
    port map(
        clk_i    => clk_tb,
        rst_i    => rst_tb,
        ena_i    => ena_tb,
        cuenta_o => cuenta_tb
    );
end;
