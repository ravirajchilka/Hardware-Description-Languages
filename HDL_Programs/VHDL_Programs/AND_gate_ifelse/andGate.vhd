LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;


ENTITY AND_gate IS
  PORT (
    a : IN STD_LOGIC; -- 0, 1, z , U, x
    b : IN STD_LOGIC;
    c : OUT STD_LOGIC

  );
END AND_gate;

ARCHITECTURE Behavioral OF AND_gate IS
BEGIN
 -- c <= a AND b;

  --c <= '1' when ((a = '1') and (b = '1')) else '0';
  
   PROCESS(a,b)
   BEGIN
    if (a='0' and b='0') then
       c<= '0';
    elsif(a='0' and b='1') then
      c<='0';
    elsif(a='1' and b='0') then
      c<='0';
    elsif(a='1' and b='1') then
      c<='1';
    end if;       
  END PROCESS;
  
  
END Behavioral;