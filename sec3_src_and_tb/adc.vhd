library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned."+";
use ieee.std_logic_unsigned.conv_integer;

entity adc is
port (
	SCLK		: in std_logic;
	CSN		: in std_logic;
	SDATA		: out std_logic
);
end entity;

architecture behavioral of adc is

signal result	: std_logic_vector(15 downto 0):= "0000110100111100";
signal counter	: integer range 0 to 15 := 0;

begin

p_main: process(CSN, SCLK)

begin
	
	if falling_edge(csn) then
		counter	<= 15;
	end if;
	
	if CSN = '0' and falling_edge(SCLK) then
		 if counter > 0 then
			counter	<= counter - 1;
			SDATA		<= result(counter);
		end if;
	end if;

end process;
	

end behavioral;