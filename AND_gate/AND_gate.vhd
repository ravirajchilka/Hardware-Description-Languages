library library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity AND_gate is 
    Port(
        a: in std_logic;  -- 0,1,z,U,x possible values
        b: in std_logic;
        c: out std_logic;
    );

end AND_gate;

architecture Behavioral of AND_gate is
    begin
        -- Digtal logic goes here
        c <= a and b;
        -- c <= '1' when ((a = '1') and (b='1')) else '0';

end Behavioral;    



