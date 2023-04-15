library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_comparator is
--  Port ( );
end tb_comparator;

architecture Behavioral of tb_comparator is
    signal a : std_logic_vector (1 downto 0);
    signal b :  std_logic_vector (1 downto 0); 
    signal g :  std_logic;
    signal l :  std_logic;
    signal e :  std_logic;
    signal count : std_logic_vector (3 downto 0);
  
component comparator is 
    Port(
        a :  std_logic_vector (1 downto 0);
        b :  std_logic_vector (1 downto 0); 
        g :  std_logic;
        l :  std_logic;
        e :  std_logic
     );
end component;    

begin    
inst: comparator  
    Port map(
      a => a,
      b => b,
      g => g,
      l => l,
      e => e
     );

process    
    begin
       -- for i in 0 to 15 loop
         --   a <= a+1;
         count <= (others => '0');
         wait for 1 ns;
         for i in 0 to 15 loop
            count <= count + 1;
            wait for 1 ns;
         end loop;  

end process;

    a <= count(3 downto 2);
    b <= count(1 downto 0);

end Behavioral;
