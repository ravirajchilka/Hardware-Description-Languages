library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;


entity decoder_2_4 is
--  Port ( );
end decoder_2_4;

architecture Behavioral of decoder_2_4 is
    signal s0   :   std_logic;
    signal s1   :   std_logic;
    signal d0   :   std_logic;
    signal d1   :   std_logic;
    signal d2   :   std_logic; 
    signal d3   :   std_logic;   
    signal count:   std_logic_vector(1 downto 0);


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


begin
    s0 <= count(0);
    s1 <= count(1);

    process
        begin         
            count <= (others => '0');
            wait for 1 ns;
            for i in 0 to 3 loop
                count <= count+1;
                wait for 1 ns;    
            end loop;    
    end process;


dut: decoder_2_4 
    Port map(
        s0,
        s1,
        d0,
        d1,
        d2,
        d3
    );


end Behavioral;







