library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity mux_4_1 is
--  Port ( );
end mux_4_1;

architecture Behavioral of mux_4_1 is
    signal sel     :  std_logic_vector(1 downto 0);
    signal inputs  :  std_logic_vector(3 downto 0);
    signal output  :  std_logic;
    signal count   :  std_logic_vector(5 downto 0);


component mux_4_1
    Port(
        sel     :  in std_logic_vector(1 downto 0);
        inputs  :  in std_logic_vector(3 downto 0);
        output  :  out std_logic
    );
end component;


begin
    inputs <= count(5 downto 2);
    sel <= count(1 downto 0);
    
    process
        begin 
            count <= (others => '0');
            for i in 0 to (2**6)-1 loop
                count <= count+1;
                wait for 1 ns;
            end loop;    
    end process;        


dut : mux_4_1
    Port map(
        sel,
        inputs,
        output
    );

end Behavioral;


