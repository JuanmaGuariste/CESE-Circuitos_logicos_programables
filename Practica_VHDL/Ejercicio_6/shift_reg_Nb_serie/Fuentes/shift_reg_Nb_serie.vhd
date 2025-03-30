LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

-- Declaracion de entidad
ENTITY shift_reg_Nb_serie IS
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
END;

-- Declaracion cuerpo de arquitectura
ARCHITECTURE shift_reg_Nb_serie_arq OF shift_reg_Nb_serie IS
    -- Parte declarativa
    component ffd
        PORT (
            clk_i : IN STD_LOGIC;
            rst_i : IN STD_LOGIC;
            ena_i : IN STD_LOGIC;
            d_i   : IN STD_LOGIC;
            q_o   : OUT STD_LOGIC
        );
    end component;
    signal d: std_logic_vector(0 to N);
BEGIN
    -- Parte descriptiva
    shift_reg_i: for i in 0 to N-1 generate
        ffd_inst: ffd
        port map(
            clk_i  => clk_i,
            rst_i  => rst_i,
            ena_i => ena_i,
            d_i  => d(i),
            q_o => d(i+1)
        );
    end generate;
    d(0) <= d_i;
    q_o <= d(N);

END;