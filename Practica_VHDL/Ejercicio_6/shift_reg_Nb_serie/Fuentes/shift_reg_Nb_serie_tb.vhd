library IEEE;
use IEEE.std_logic_1164.all;

-- Declaracion de entidad
entity shift_reg_Nb_serie_tb is   
end;

-- Declaracion cuerpo de arquitectura
architecture shift_reg_Nb_serie_tb_arq of shift_reg_Nb_serie_tb is
    -- Parte declarativa
    component shift_reg_Nb_serie is   
        generic(
            N: natural := 4
        );
        PORT (
            clk_i : IN STD_LOGIC;
            rst_i : IN STD_LOGIC;
            ena_i : IN STD_LOGIC;
            d_i   : IN STD_LOGIC;
            q_o   : OUT STD_LOGIC
        );
    end component;

    constant N_tb: natural := 4;
    signal clk_tb : std_logic := '0';
    signal rst_tb : std_logic := '0';
    signal ena_tb: std_logic  := '1';
    signal d_tb : std_logic   := '0';
    signal q_tb : std_logic;
begin
    -- Parte descriptiva
    clk_tb <= not clk_tb after 10 ns;
    rst_tb <= '1' after 155 ns, '0' after 250 ns;
    d_tb <= '1' after 60 ns, '0' after 300 ns, '1' after 450 ns;
    ena_tb <= '0' after 350 ns, '1' after 500 ns;
    
    DUT: shift_reg_Nb_serie
    generic map(
        N => N_tb
    )
    port map(
        clk_i => clk_tb,
        rst_i => rst_tb,
        ena_i => ena_tb,
        d_i   => d_tb,
        q_o   => q_tb
    );
end;
