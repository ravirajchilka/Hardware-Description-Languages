library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity tb_comparator is
--  Port ( );
end tb_comparator;

architecture Behavioral of tb_comparator is
    signal a :  std_logic_vector(1 downto 0);
    signal b :  std_logic_vector(1 downto 0);
    signal g :  std_logic;
    signal count : std_logic_vector(3 downto 0);   

component comparator is 
    Port (
     a : in std_logic_vector(1 downto 0);
     b : in std_logic_vector(1 downto 0);
     g : out std_logic
    );
end component;


begin
    b <= count(1 downto 0);
    a <= count(3 downto 2);

    process
        begin 
         count <= (others=>'0');
         wait for 1 ns;
            for i in 0 to 15 loop
                count<= count+1;
                wait for 1 ns;
            end loop;   
    end process;
    
inst: comparator
    Port map(
        a,
        b,
        g
    );
    
end Behavioral;
