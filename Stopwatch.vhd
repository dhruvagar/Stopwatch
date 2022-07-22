----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:25:36 04/09/2021 
-- Design Name: 
-- Module Name:    Stopwatch - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Stopwatch is
    Port ( clk : in  STD_LOGIC;
			  pause : in STD_LOGIC;
           rst : in  STD_LOGIC;
           en : out STD_LOGIC_VECTOR (7 downto 0);
           SSD : out  STD_LOGIC_VECTOR (7 downto 0));
end Stopwatch;

architecture Behavioral of Stopwatch is

component Clk_100Hz 
    Port ( clk : in  STD_LOGIC;
           q : out  STD_LOGIC);
end component;

component SevenSegmentDecoder 
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           X : out  STD_LOGIC_VECTOR (6 downto 0));
end component;

signal clk100Hz : STD_LOGIC;
signal S0,S1,S2,S3,S4,S5,S6,S7 :  STD_LOGIC_VECTOR (3 downto 0);
signal counter :  STD_LOGIC_VECTOR (15 downto 0):= (others=>'0');
signal SSD0,SSD1,SSD2,SSD3,SSD4,SSD5,SSD6,SSD7 :  STD_LOGIC_VECTOR (6 downto 0);

begin

X1: SevenSegmentDecoder port map (S0,SSD0);
X2: SevenSegmentDecoder port map (S1,SSD1);
X3: SevenSegmentDecoder port map (S2,SSD2);
X4: SevenSegmentDecoder port map (S3,SSD3);
X5: SevenSegmentDecoder port map (S4,SSD4);
X6: SevenSegmentDecoder port map (S5,SSD5);
X7: SevenSegmentDecoder port map (S6,SSD6);
X8: SevenSegmentDecoder port map (S7,SSD7);
X9: Clk_100Hz port map (clk,clk100Hz);

--counter
process(rst,clk100Hz,pause)  
begin

if rst='1' then
S0 <= (others=>'0');
S1 <= (others=>'0');
S2 <= (others=>'0');
S3 <= (others=>'0');
S4 <= (others=>'0');
S5 <= (others=>'0');
S6 <= (others=>'0');
S7 <= (others=>'0');

elsif (rising_edge(clk100Hz) and rst='0' and pause='0') then
S0 <= S0+1;
		if S0= "1001" then
		S0 <= (others=>'0');
		S1 <= S1+1;
		
		if S1= "1001" then
		S1 <= (others=>'0');
		S2 <= S2+1;
		
		if S2= "1001" then
		S2 <= (others=>'0');
		S3 <= S3+1;
		
		if S3= "0101" then
		S3 <= (others=>'0');
		S4 <= S4+1;
		
		if S4= "1001" then
		S4 <= (others=>'0');
		S5 <= S5+1;
		
		if S5= "0101" then
		S5 <= (others=>'0');
		S6 <= S6+1;
		
		if S6= "1001" then
		S6 <= (others=>'0');
		S7 <= S7+1;
		
		if S7= "1001" then
		S7 <= (others=>'0');
		end if;
		end if;
		end if;
		end if;
		end if;
		end if;
		end if;
		end if;

elsif (rising_edge(clk100Hz) and rst='0' and pause='1') then
S0 <= S0;
S1 <= S1;
S2 <= S2;
S3 <= S3;
S4 <= S4;
S5 <= S5;
S6 <= S6;
S7 <= S7;

end if;
end process;




--enable shifitng 
process(clk,rst,counter)
begin
if (rising_edge(clk)) then
counter <= counter+1;

end if;

case counter(15 downto 13) is 
when "000" => en <= "11111110"; SSD<= SSD0 & '1';
when "001" => en <= "11111101"; SSD<= SSD1 & '1';
when "010" => en <= "11111011"; SSD<= SSD2 & '0';
when "011" => en <= "11110111"; SSD<= SSD3 & '1';
when "100" => en <= "11101111"; SSD<= SSD4 & '0';
when "101" => en <= "11011111"; SSD<= SSD5 & '1';
when "110" => en <= "10111111"; SSD<= SSD6 & '0';
when "111" => en <= "01111111"; SSD<= SSD7 & '1';
when others => en <= "11111111";
end case;

end process;

end Behavioral;
