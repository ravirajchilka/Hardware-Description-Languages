library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparator is
    Port (
        a : in std_logic_vector (1 downto 0);
        b : in std_logic_vector (1 downto 0); 
        g : out std_logic;
        l : out std_logic;
        e : out std_logic
    );
end comparator;

architecture Behavioral of comparator is

begin
    g <= (a(1) and (not b(1))) or (a(0)and(not(b(1))and not b(0))) or
    (a(1)and a(0)and (not b(0)));
    
    e <= (a(0) xnor b(0)) and (a(1) xnor b(1));   

    l <= (not a(1) and b(1)) or ((not a(1)and not a(0)) and b(0))
     or (not a(0) and b(1) and b(0));

end Behavioral;
