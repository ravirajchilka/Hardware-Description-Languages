library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_AND_gate is

end tb_AND_gate;    

architecture Behavioral of tb_AND_gate is
    signal a: std_logic := '0';
    signal b: std_logic := '0';
    signal c: std_logic;

component AND_gate is 
    Port(
        a: in std_logic; -- 0,1,z,U,x possible values
        b: in std_logic;
        c: out std_logic;
    );
end component;
    
begin
    process begin 
        a <= '0';
        b <= '0';
        wait for 1 ns;
        b <= '1';
        wait for 1ns;
        a <= '1';
        wait for 1ns;
        b <= '0';
        wait for 1ns;
    end process;   
    
i_AND_gate: AND_gate 
    Port map(
        a => a;
        b => b;
        c => c;
    );

end Behavioral;
