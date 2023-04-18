library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

architecture Behavioral of tb_mux_2_1 is
    signal in1      : std_logic;
    signal in2      : std_logic;
    signal sel      : std_logic;
    signal output   : std_logic;
    signal count    : std_logic_vector(2 downto 0);

component mux_2_1 is 
    Port(
        in1     : in std_logic;
        in2     : in std_logic;
        sel     : in std_logic;
        output  : out std_logic
    );
end component;

begin
    inst: mux_2_1
        Port map(
            in1 => in1,
            in2 => in2,
            sel => sel,
            output => output
        );
     process
        begin
            count <= "000";
            wait for 1 ns;
            for i in 0 to 7 loop
                count <= count+1;
                wait for 1 ns;
            end loop;    
     end process;  
     
    in1 <= count(2);
    in2 <= count(1);
    sel <= count(0);    
     
       

end Behavioral;
