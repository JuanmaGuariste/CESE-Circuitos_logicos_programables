library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Declaracion de entidad
entity contNb_MOD_tb is   
end;

-- Declaracion cuerpo de arquitectura
architecture contNb_MOD_tb_arq of contNb_MOD_tb is
    -- Parte declarativa
    component contNb_MOD is  
        generic (
            N      : natural := 4;
            MODULE : natural := 9
        );
        port(
            clk_i    : in std_logic;
            rst_i    : in std_logic;
            ena_i    : in std_logic;
            cuenta_o : out std_logic_vector(N-1 downto 0);
            max_o    : out std_logic
        );
    end component;

    constant N_tb: natural :=  10;
    constant MODULE_tb: natural := 15;

    signal clk_tb    : std_logic := '0';
    signal rst_tb    : std_logic := '1';
    signal ena_tb    : std_logic := '1';
    signal cuenta_tb : std_logic_vector(N_tb-1 downto 0);
    signal max_tb    : std_logic;

begin
    -- Parte descriptiva
    clk_tb <=  not clk_tb after 10 ns;
    rst_tb <= '0' after 40 ns;
    ena_tb <= '0' after 250 ns, '1' after 350 ns;

    DUT: contNb_MOD  
    generic map (
        N => N_tb,
        MODULE => MODULE_tb
    )
    port map(
        clk_i    => clk_tb,
        rst_i    => rst_tb,
        ena_i    => ena_tb,
        cuenta_o => cuenta_tb,
        max_o    => max_tb
    );
end;
