library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_4_1 is
    Port(
       inputs   :  in std_logic_vector(3 downto 0);
       sel      :  in std_logic_vector(1 downto 0);
       outp     :  out std_logic
    );
end mux_4_1;


architecture Behavioral of mux_4_1 is

component decoder_2_4 
    Port(
        s0  : in std_logic;
        s1  : in std_logic; 
        d0  : out std_logic;
        d1  : out std_logic; 
        d2  : out std_logic; 
        d3  : out std_logic
    );
end component;


    signal d0   :   std_logic;
    signal d1   :   std_logic;
    signal d2   :   std_logic; 
    signal d3   :   std_logic;   


begin
    outp <= (inputs(0) and d0) or (inputs(1) and d1) or (inputs(2) and d2) or 
            (inputs(3) and d3);


dut: decoder_2_4 
    Port map(
        s0 => sel(0),
        s1 => sel(1),
        d0 => d0,
        d1 => d1,
        d2 => d2,
        d3 => d3
    );


end Behavioral;
