library ieee;
use ieee.std_logic_1164.all;

entity udemy_tb is
end entity;

architecture test of udemy_tb is

component dp_mem IS
	port (
	addra: IN std_logic_VECTOR(3 downto 0);
	addrb: IN std_logic_VECTOR(3 downto 0);
	clka: IN std_logic;
	clkb: IN std_logic;
	dina: IN std_logic_VECTOR(15 downto 0);
	dinb: IN std_logic_VECTOR(15 downto 0);
	douta: OUT std_logic_VECTOR(15 downto 0);
	doutb: OUT std_logic_VECTOR(15 downto 0);
	wea: IN std_logic;
	web: IN std_logic
	);
END component;

------------------SIGNALS-----------------
signal clka:	std_logic := '0';
signal clkb:	std_logic := '0';
signal wea:		std_logic := '0';
signal web:		std_logic := '0';
-----------------------------------------

-----------------VECTORS-----------------
signal addra:	std_logic_vector(3 downto 0);
signal addrb:	std_logic_vector(3 downto 0);
signal dina:	std_logic_vector(15 downto 0);
signal dinb:	std_logic_vector(15 downto 0);
-----------------------------------------


begin

clka <= not clka after 5 ns;  --100 MHz
clkb <= not clkb after 10 ns; --50 MHz

UUT1	: dp_mem
	port map(
	addra		=> addra	,
	addrb		=> addrb	,
	clka		=> clka	,
	clkb		=> clkb	,
	dina		=> dina	,
	dinb		=> dinb	,
	wea		=> wea	,		
	web		=> web			
);

Test_Process1: process
begin
	wea	<= '0'; 
	web	<= '0';
	
	addra <= (others=>'0');
	addrb <= (others=>'0');
	dina  <= (others=>'0');
	dinb  <= (others=>'0');
	

	wait until rising_edge(clka);
		
		addra	<= "0001";
		dina	<= x"ABCD";
		wea	<= '1';
		
	wait until rising_edge(clka);
		
		wea	<= '0';
		dina	<= x"0000";
	
	wait until rising_edge(clkb);
	
		addrb	<= "0001";
		
	wait;
end process;

end test;