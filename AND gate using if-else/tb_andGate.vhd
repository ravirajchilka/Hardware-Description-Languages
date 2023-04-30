----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2023 14:30:15
-- Design Name: 
-- Module Name: tb_add_gate - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY tb_AND_gate IS
  --  Port ( );
END tb_AND_gate;

ARCHITECTURE Behavioral OF tb_AND_gate IS
  SIGNAL a : STD_LOGIC;
  SIGNAL b : STD_LOGIC;
  SIGNAL c : STD_LOGIC;

  COMPONENT and_gate IS
    PORT (
      a : IN STD_LOGIC; -- 0, 1, z , U, x
      b : IN STD_LOGIC;
      c : OUT STD_LOGIC

    );
  END COMPONENT;

BEGIN

 
  PROCESS BEGIN
    a <= '0';
    b <= '0';
    WAIT FOR 1 ns;
    b <= '1';
    WAIT FOR 1 ns;
    a <= '1';
    WAIT FOR 1 ns;
    b <= '0';
    WAIT FOR 1 ns;
  END PROCESS;

  i_and_gate : and_gate
  PORT MAP(
    a => a,
    b => b,
    c => c

  );
END Behavioral;