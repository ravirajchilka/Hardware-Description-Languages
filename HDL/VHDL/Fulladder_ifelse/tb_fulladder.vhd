library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_fulladder is
--  Port ( );
end tb_fulladder;

architecture Behavioral of tb_fulladder is
    signal inputs : std_logic_vector(2 downto 0);
    signal sum :    std_logic;
    signal cout :   std_logic;
    signal count : std_logic_vector(2 downto 0);
   
component fulladder is 
    Port(
        inputs:in std_logic_vector(2 downto 0);
        sum : out std_logic;
        cout: out std_logic
    );
end component;    

begin
--    inputs(0) <= count(0);
--    inputs(1) <= count(1);
--    inputs(2) <= count(2);
    inputs <= count(2 downto 0);

    process
        begin 
            count <= (others => '0');
            wait for 1 ns;
            for i in 0 to 7 loop
                count <= count+1;
                wait for 1 ns;
            end loop;
    end process;        

inst: fulladder
    Port map(
        inputs,
        sum,
        cout
    );

end Behavioral;
