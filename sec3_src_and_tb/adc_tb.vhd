library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned."+";
use ieee.std_logic_unsigned.conv_integer;

entity adc_tb is
end entity;

architecture test of adc_tb is

signal SCLK			: std_logic := '1';
signal CSN			: std_logic := '1';
signal SDATA		: std_logic;

component adc is
port (
	SCLK		: in std_logic;
	CSN		: in std_logic;
	SDATA		: out std_logic
);
end component;

signal counter		: integer range 0 to 16;

begin


UUT1: adc
		port map (
			SCLK		=> SCLK,
			CSN		=> CSN,
			SDATA		=> SDATA
		);
		
p_test: process
	
begin

	wait for 20ns;
	CSN		<= '0';
	wait for 320ns;
	CSN		<= '1';
	wait for 20 ns;
	
end process;

p_sclk: process

begin
	wait until CSN = '0';
	
	while counter < 15 loop
		wait for 10ns;
		SCLK		<= '0';
		wait for 10ns;
		SCLK		<= '1';
		counter	<= counter + 1;
	end loop;
	
end process;

end test;