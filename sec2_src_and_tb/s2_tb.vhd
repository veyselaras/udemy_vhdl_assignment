library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity s2_tb is
end entity;


architecture test of s2_tb is


-----------------------------------------------------
--				FUNCTION FOR STRING TO BINARY				--
-----------------------------------------------------

function STR_TO_BIN( hex_str		: string(4 downto 1))
			return std_logic_vector is
variable bin_val	: std_logic_vector(15 downto 0);

begin
	
	for I in 4 downto 1 loop
		case hex_str(I) is
			when '0'		=> bin_val((I*4-1) downto (I*4-4)) := "0000";
			when '1'		=> bin_val((I*4-1) downto (I*4-4)) := "0001";
			when '2'		=> bin_val((I*4-1) downto (I*4-4)) := "0010";
			when '3'		=> bin_val((I*4-1) downto (I*4-4)) := "0011";
			when '4'		=> bin_val((I*4-1) downto (I*4-4)) := "0100";
			when '5'		=> bin_val((I*4-1) downto (I*4-4)) := "0101";
			when '6'		=> bin_val((I*4-1) downto (I*4-4)) := "0110";
			when '7'		=> bin_val((I*4-1) downto (I*4-4)) := "0111";
			when '8'		=> bin_val((I*4-1) downto (I*4-4)) := "1000";
			when '9'		=> bin_val((I*4-1) downto (I*4-4)) := "1001";
			when 'A'		=> bin_val((I*4-1) downto (I*4-4)) := "1010";
			when 'B'		=> bin_val((I*4-1) downto (I*4-4)) := "1011";
			when 'C'		=> bin_val((I*4-1) downto (I*4-4)) := "1100";
			when 'D'		=> bin_val((I*4-1) downto (I*4-4)) := "1101";
			when 'E'		=> bin_val((I*4-1) downto (I*4-4)) := "1110";
			when 'F'		=> bin_val((I*4-1) downto (I*4-4)) := "1111";
			when others => bin_val((I*4-1) downto (I*4-4)) := "0000";
		end case;
	end loop;
	return bin_val;
end;
--*************************************************--

-----------------------------------------------------
--				FUNCTION FOR STRING TO BINARY				--
-----------------------------------------------------

function STR_TO_ADDR( addr_str	: character)
			return std_logic_vector is
variable addr_bin_val	: std_logic_vector(3 downto 0);

begin

	case addr_str is
		when '0'		=> addr_bin_val := "0000";
      when '1'		=> addr_bin_val := "0001";
		when '2'		=> addr_bin_val := "0010";
      when '3'		=> addr_bin_val := "0011";
      when '4'		=> addr_bin_val := "0100";
      when '5'		=> addr_bin_val := "0101";
      when '6'		=> addr_bin_val := "0110";
      when '7'		=> addr_bin_val := "0111";
      when '8'		=> addr_bin_val := "1000";
      when '9'		=> addr_bin_val := "1001";
      when 'A'		=> addr_bin_val := "1010";
      when 'B'		=> addr_bin_val := "1011";
      when 'C'		=> addr_bin_val := "1100";
      when 'D'		=> addr_bin_val := "1101";
      when 'E'		=> addr_bin_val := "1110";
      when 'F'		=> addr_bin_val := "1111";
      when others => addr_bin_val := "0000";
	end case;
	return addr_bin_val;
end;
--*************************************************--

-----------------------------------------------------
--					COMPONENT DECLARATION					--
-----------------------------------------------------
component dp_mem IS
	port (
	addra	: IN std_logic_VECTOR(3 downto 0);
	addrb	: IN std_logic_VECTOR(3 downto 0);
	clka	: IN std_logic;
	clkb	: IN std_logic;
	dina	: IN std_logic_VECTOR(15 downto 0);
	dinb	: IN std_logic_VECTOR(15 downto 0);
	douta	: OUT std_logic_VECTOR(15 downto 0) := (others => '0');
	doutb	: OUT std_logic_VECTOR(15 downto 0) := (others => '0');
	wea	: IN std_logic;
	web	: IN std_logic
	);
END component;
--*************************************************--


-----------------------------------------------------
--					INSTANTIATION SIGNALS					--
-----------------------------------------------------

signal addra	:std_logic_VECTOR(3 downto 0); 
signal addrb	:std_logic_VECTOR(3 downto 0);
signal clka		:std_logic	:= '0';
signal clkb		:std_logic	:= '0';
signal dina		:std_logic_VECTOR(15 downto 0);
signal dinb		:std_logic_VECTOR(15 downto 0);
signal douta	:std_logic_VECTOR(15 downto 0);
signal doutb	:std_logic_VECTOR(15 downto 0);
signal wea		:std_logic;
signal web		:std_logic;
--*************************************************--

signal ccontrol		:std_logic;

begin
-----------------------------------------------------
--					CLOCKS										--
-----------------------------------------------------
clka <= not clka after 5 ns;  --100 MHz
clkb <= not clkb after 10 ns; --50 MHz
--*************************************************--

-----------------------------------------------------
--					DESIGN UNDER test							--
-----------------------------------------------------
DUT1: dp_mem
	port MAP(
	addra	=>addra	,
	addrb	=>addrb	,
	clka	=>clka	,
	clkb	=>clkb	,
	dina	=>dina	,
	dinb	=>dinb	,
	douta	=>douta	,
	doutb	=>doutb	,
	wea	=>wea	   ,
	web	=>web	
	);
--*************************************************--

-----------------------------------------------------
--					TEST PROCESS								--
-----------------------------------------------------
test_p: process

file data_file			: text;
variable L_IN			: line;

variable INSTRUCTION	: string(1 to 5);
variable SPACE			: character;
variable ADDRESS		: character;
variable DATA			: string(1 to 4);

begin

	addra	<= (others => '0');
	addrb	<= (others => '0');
   dina	<= (others => '0');
   dinb	<= (others => '0');
	wea	<= '0';
	web	<= '0';
	file_open(data_file, "C:\VHDL_course\instructions.txt", READ_MODE);
	
	wait until clka'event and clka = '1';
	wait until clka'event and clka = '1';
	wait until clka'event and clka = '1';
	
	while (INSTRUCTION /= "END  ") loop
		ccontrol <= '1';
		readline(data_file, L_IN);
		read(L_IN, INSTRUCTION);
		read(L_IN, SPACE);
		read(L_IN, ADDRESS);
		read(L_IN, SPACE);
		read(L_IN, DATA);
	
		case (INSTRUCTION) is
			when "WRITE" =>
				dina	<= STR_TO_BIN(DATA);
				wea	<= '1';
				addra	<= STR_TO_ADDR(ADDRESS);
				wait until clka'event and clka = '1';
				dina	<= (others => '0');
				wea	<= '0';
				addra	<= (others => '0');
				wait until clka'event and clka = '1';
				
			when "READ " =>
				addrb	<= STR_TO_ADDR(ADDRESS);
				wait until clkb'event and clkb = '1';
				wait until clkb'event and clkb = '1';
				assert(doutb = STR_TO_BIN(DATA))
					report "Error in Read" severity error;
			
			when "END  " =>
				assert FALSE
					report "Simulation Success" severity failure;
			
			when others	 =>
				assert FALSE
					report "False Instruction";
			
		end case;
	end loop;	
end process;
--*************************************************--


end test;


