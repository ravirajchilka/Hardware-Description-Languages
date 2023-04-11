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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_AND_gate is
--  Port ( );
end tb_AND_gate;

architecture Behavioral of tb_AND_gate is
signal a : std_logic := '0';
signal b : std_logic := '0';
signal c : std_logic;

component and_gate is  
 Port ( 
  a : in std_logic; -- 0, 1, z , U, x
  b : in std_logic;
  c : out std_logic
  
  );
end component;

begin

   process begin
     a <= '0';
     b <= '0';
     wait for 1 ns;
     b <= '1';
     wait for 1 ns;
     a <= '1';
     wait for 1 ns;
     b <= '0';
     wait for 1 ns;
   end process;
   
   i_and_gate : and_gate   
 Port map ( 
  a => a,
  b => b,
  c => c
  
  );
   

end Behavioral;
