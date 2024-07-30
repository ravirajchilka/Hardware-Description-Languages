library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity decoder_2_4 is
    Port(
        s0  : in std_logic;
        s1  : in std_logic; 
        d0  : out std_logic;
        d1  : out std_logic; 
        d2  : out std_logic; 
        d3  : out std_logic
    );
end decoder_2_4;


architecture Behavioral of decoder_2_4 is

begin
    d0 <= not s0 and not s1;
    d1 <= s0 and not s1;
    d2 <= not s0 and s1;
    d3 <= s0 and s1;
    
    
end Behavioral;


