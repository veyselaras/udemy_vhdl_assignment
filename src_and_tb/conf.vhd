configuration main of udemy_tb is
	for test 
		for UUT1: dp_mem
			use entity work.dp_mem(dp_mem_a);
		end for;
	end for;
end main;

configuration rtl_arc of udemy_tb is
	for test 
		for UUT1: dp_mem
			use entity work.dp_mem(rtl);
		end for;
	end for;
end rtl_arc;