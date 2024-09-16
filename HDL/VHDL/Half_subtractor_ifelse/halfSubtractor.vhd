library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--use UNISIM.VComponents.all;

entity halfSubtractor is

    Port(
        signal a: in std_logic;
        signal b: in  std_logic;
        signal diff : out std_logic;
        signal brw  : out std_logic
    );

end halfSubtractor;

architecture Behavioral of halfSubtractor is

begin
    process(a,b) 
        begin
            if((a='0' and b = '0') or (a='1' and b='1')) then
                diff <= '0';
                brw <= '0';
             elsif((a='0' and b = '1')) then
                diff <= '1';
                brw <= '1';
              elsif((a='1' and b = '0')) then
                diff <= '1';
                brw <= '0';   
                end if;
    end process;        
end Behavioral;
