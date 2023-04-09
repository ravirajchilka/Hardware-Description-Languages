----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2023 14:16:39
-- Design Name: 
-- Module Name: and_gate - Behavioral
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

ENTITY AND_gate IS
  PORT (
    a : IN STD_LOGIC; -- 0, 1, z , U, x
    b : IN STD_LOGIC;
    c : OUT STD_LOGIC

  );
END AND_gate;

ARCHITECTURE Behavioral OF AND_gate IS
BEGIN
  c <= a AND b;

  --c <= '1' when ((a = '1') and (b = '1')) else '0';
END Behavioral;