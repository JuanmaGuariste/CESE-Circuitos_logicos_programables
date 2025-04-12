library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Declaracion de entidad
entity contBCD_Lento is  
    generic (
        CICLOS   : natural := 125E6 
    );
    port(
        clk_i    : in std_logic;
        rst_i    : in std_logic;
        ena_i    : in std_logic;
        cuenta_o : out std_logic_vector(3 downto 0)
    );
end;

-- Declaracion cuerpo de arquitectura
architecture contBCD_Lento_arq of contBCD_Lento is
    -- Parte declarativa
    component contBCD is  
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

    signal ena_aux: std_logic;
    signal salGenEna: std_logic;

  begin
    -- Parte descriptiva
    ena_aux <= ena_i and salGenEna;
    contBCD_inst : contBCD
        generic map(
            N => 4
        )
        port map(
            clk_i    => clk_i,
            rst_i    => rst_i,
            ena_i    => ena_aux,
            cuenta_o => cuenta_o
        );

    genEna_inst : genEna
        generic map(
            N => CICLOS
        )
        port map(
            clk_i => clk_i,
            rst_i => rst_i,
            ena_i => '1',
            q_o   => salGenEna
        );

  end;
