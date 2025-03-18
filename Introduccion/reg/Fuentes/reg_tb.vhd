library IEEE;
use IEEE.std_logic_1164.all;

-- Declaracion de entidad
entity reg_tb is   
end;

-- Declaracion cuerpo de arquitectura
architecture reg_tb_arq of reg_tb is
    -- Parte declarativa
    component reg is   
        PORT (
            clk_i : IN STD_LOGIC;
            rst_i : IN STD_LOGIC;
            ena_i : IN STD_LOGIC;
            d_i   : IN STD_LOGIC_vector(3 downto 0);
            q_o   : OUT STD_LOGIC_vector(3 downto 0);
        );
    end component;

    signal clk_tb : std_logic := '0';
    signal rst_tb : std_logic := '0';
    signal ena_tb: std_logic := '1';
    signal d_tb : std_logic := '0';
    signal q_tb : std_logic;
begin
    -- Parte descriptiva
    -- a_tb  <= '1' after 50 ns, '0' after 130 ns;
    -- b_tb  <= '1' after 80 ns, '0' after 110 ns;
    -- ci_tb <= '1' after 90 ns, '0' after 150 ns;

    clk_tb <= not clk_tb after 10 ns;
    rst_tb <= '1' after 155 ns;
    ena_tb <= '0' after 105 ns, '1' after 120 ns;
    d_tb <= '1' after 60 ns, '0' after 100 ns, '1' after 145 ns;

    
    DUT: reg
    generic map(
        N => 4
    )
    port map(
        clk_i  => clk_tb,
        rst_i  => rst_tb,
        ena_i => ena_tb,
        d_i  => d_tb,
        q_o => q_tb
    );
end;
