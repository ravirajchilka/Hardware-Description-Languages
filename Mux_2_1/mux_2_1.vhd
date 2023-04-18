
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2_1 is 
    Port(
        in1 : in std_logic;
        in2 : in std_logic;
        sel : in std_logic;
        output : out std_logic
    );

end mux_2_1;

architecture Behaviour of mux_2_1 is
begin 

    output <= (in1 and not sel) or (in2 and sel);

end Behaviour;