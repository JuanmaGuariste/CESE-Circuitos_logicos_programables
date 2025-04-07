library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Declaracion de entidad
entity contNb_MOD is  
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
end;

-- Declaracion cuerpo de arquitectura
architecture contNb_MOD_arq of contNb_MOD is
    -- Parte declarativa
    signal salAnd, salOr, salComp: std_logic;
    signal salReg, salSUm: std_logic_vector(N-1 downto 0);
    component reg is
        generic(
            N: natural := N
        );
        PORT (
            clk_i : IN STD_LOGIC;
            rst_i : IN STD_LOGIC;
            ena_i : IN STD_LOGIC;
            d_i   : IN STD_LOGIC_vector(N-1 downto 0);
            q_o   : OUT STD_LOGIC_vector(N-1 downto 0)
        );
    end component;
begin
    -- Parte descriptiva
    reg_inst: reg 
        generic map(
            N => N
        )
        port map(
            clk_i => clk_i,
            rst_i => salOr,
            ena_i => ena_i,
            d_i   => salSUm,
            q_o   => salReg
        );

        cuenta_o <= salReg;
        max_o <= salCOmp;

        salOr  <= rst_i or salAnd;
        salAnd <= ena_i and salComp;
        salSum <= std_logic_vector(unsigned(salReg) + to_unsigned(1, N)); 
        salComp <= '1' when salReg = std_logic_vector(to_unsigned(MODULE-1, N)) else '0';
end;
