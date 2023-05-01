library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity fulladder is
Port ( 
    inputs:in std_logic_vector(2 downto 0);
    sum : out std_logic;
    cout: out std_logic
);
end fulladder;

architecture Behavioral of fulladder is

begin
    process(inputs)
        begin
            if(inputs = "001"  or inputs = "010" or inputs = "100"
             or inputs = "111") then
                sum <= '1';
            else
                sum <= '0';     
            end if;
            
            if(inputs = "011" or inputs = "101" or inputs = "110"
             or inputs = "111") then
                cout <= '1';
            else
                cout <= '0';
            end if;    
    end process;
end Behavioral;
