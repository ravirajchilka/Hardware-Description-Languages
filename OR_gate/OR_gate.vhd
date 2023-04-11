----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2023 06:33:00 PM
-- Design Name: 
-- Module Name: OR_gate - Behavioral
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
use IEEE.std_logic_1164.ALL;

entity OR_gate is 

    Port(
        a: in std_logic;
        b: in std_logic;
        c: out std_logic
    );
end OR_gate;

architecture Behavioral of OR_gate is 
    begin 
        c <= a or b;

end Behavioral;




