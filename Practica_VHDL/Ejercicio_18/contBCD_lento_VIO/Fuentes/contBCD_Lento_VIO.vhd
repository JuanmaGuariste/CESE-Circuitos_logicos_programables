library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- Declaracion de entidad
entity contBCD_Lento_VIO is  
    port(
        clk_i    : in std_logic
    );
end;

-- Declaracion cuerpo de arquitectura
architecture contBCD_Lento_VIO_arq of contBCD_Lento_VIO is

    -- Parte declarativa
    
    COMPONENT vio_0 
      PORT (
        clk : IN STD_LOGIC;
        probe_in0 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        probe_out0 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
        probe_out1 : OUT STD_LOGIC_VECTOR(0 DOWNTO 0)
      );
    END COMPONENT;
    
    component contBCD_Lento is  
        generic (
            CICLOS   : natural := 4 
        );
        port(
            clk_i    : in std_logic;
            rst_i    : in std_logic;
            ena_i    : in std_logic;
            cuenta_o : out std_logic_vector(3 downto 0)
        );
    end component;

    signal probe_rst, probe_ena: std_logic_vector(0 downto 0);
    signal probe_cuenta: std_logic_vector(3 downto 0);

  begin
    -- Parte descriptiva
   contBCD_Lento_inst: contBCD_Lento
    generic map (
           CICLOS => 125E6
       )
    port map (
        clk_i     => clk_i,
        rst_i     => probe_rst(0),
        ena_i     => probe_ena(0),
        cuenta_o  => probe_cuenta
    );
    
    vio_inst : vio_0
      PORT MAP (
        clk => clk_i,
        probe_in0 => probe_cuenta,
        probe_out0 => probe_rst,
        probe_out1 => probe_ena
      );
      
  end;
