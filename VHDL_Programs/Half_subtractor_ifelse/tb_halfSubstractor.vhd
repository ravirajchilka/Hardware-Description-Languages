

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity tb_halfSubstractor is
--  Port ( );
end tb_halfSubstractor;

architecture Behavioral of tb_halfSubstractor is
    signal a : std_logic;
    signal b : std_logic;
    signal diff: std_logic;
    signal brw: std_logic;
    signal count : std_logic_vector(3 downto 0);
    
component halfSubtractor is 
    Port(
        signal a: in std_logic;
        signal b: in  std_logic;
        signal diff : out std_logic;
        signal brw  : out std_logic
    );
end component;

begin
    a <= count(0);
    b <= count(1);
    process
        begin 
            count <= (others => '0'); 
            wait for 1 ns;
            for i in 0 to 3 loop
                count <= count + 1;
                wait for 1 ns;
            end loop;    
    end process;
    
 inst: halfSubtractor
    Port map(
       a,
       b,
       diff,
       brw
    );   

end Behavioral;
