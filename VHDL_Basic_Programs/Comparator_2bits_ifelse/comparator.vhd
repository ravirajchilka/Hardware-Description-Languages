

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity comparator is
 generic (DW : integer := 2);
 Port ( 
    a : in std_logic_vector(DW-1 downto 0);
    b : in std_logic_vector(DW-1 downto 0);
    g : out std_logic
--    l : out std_logic;
--    e : out std_logic
 );
end comparator;

architecture Behavioral of comparator is
signal e : std_logic_vector(DW downto 0);
signal g_int : std_logic_vector(DW-1 downto 0);
signal g_acc : std_logic_vector(DW downto 0);


begin
   g <= g_acc(0); 
   
   
    process(a,b,e,g_int,g_acc)
        begin 
           e(DW) <= '1';
           g_acc(DW) <= '0';
           for i in DW-1 downto 0 loop
               g_acc(i) <= g_int(i) or g_acc(i+1) ;
               if (e(i+1) = '1') then
                if (a(i) = '1' and b(i) ='0') then
                    g_int(i) <= '1';
                    e(i) <= '0';
                elsif (a(i) = '0' and b(i) ='1') then
                   g_int(i) <= '0';
                   e(i) <= '0';
                else 
                   g_int(i) <= '0';
                   e(i) <= '1'; 
                end if;
               else
                g_int(i) <= '0'; 
                e(i) <= '0';
               end if; 
            
           end loop;
                
--               if (a(i-1) = '1' and b(i-1) ='0') then
--                  g <= '1';
--               elsif (a(i-1) = '0' and b(i-1) ='1') then
--                  g <= '0';
--               else
--                  if (a(1) = '1' and b(1) ='0') then
--                    g <= '1';
--                  elsif (a(1) = '0' and b(1) ='1') then
--                    g <= '0';
--                  else
--                     if (a(0) = '1' and b(0) ='0') then
--                       g <= '1';
--                     else  
--                       g <= '0';
--                     end if;                    
--                  end if;                  
--               end if;            
--            end if ;   
            
               
--            if (a="00") then
--                g <= '0';
--            elsif ((a = "11" or a = "10") and (b = "10" or b = "01")) then 
--                g <= '1';
--             elsif ((b = "11" or b = "10" or b = "01") and a = "00") then 
--                g <= '0';    
--            end if;
    end process;

end Behavioral;
