----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2023 06:38:26 PM
-- Design Name: 
-- Module Name: tb_OR_gate - Behavioral
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
use IEEE.std_logic_1164.all;

entity tb_OR_gate is

end tb_OR_gate;

architecture Behavioral of tb_OR_gate is
    signal a: std_logic := '0';
    signal b: std_logic := '1';
    signal c: std_logic;

component OR_gate is 
    Port(
        a: in std_logic;
        b: in std_logic;
        c: out std_logic
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
        a <= '0';
        wait for 1 ns;
        b <= '0';
        a <= '1';
    end process;    

i_OR_gate : OR_gate
    Port map(
        a => a,
        b => b,
        c => c
    );


end Behavioral;










