architecture RTL of dp_mem is

type mem_type is array(15 downto 0) of std_logic_vector(15 downto 0);

signal RAM: mem_type;
signal temp_addra, temp_addrb: std_logic_vector(3 downto 0);

begin

temp_addra	<= addra;
temp_addrb	<= addrb;

wea_process: process(clka)
begin

	if rising_edge(clka) then
		if wea = '1' then
			RAM(conv_integer(temp_addra))	<= dina;
		end if;
	end if;
	
end process;

rea_process: process(clka)
begin

	if rising_edge(clka) then
		douta		<= RAM(conv_integer(temp_addra));
	end if;
	
end process;

reb_process: process(clkb)
begin

	if rising_edge(clkb) then
		doutb		<= RAM(conv_integer(temp_addrb));
	end if;
	
end process;

end architecture;