-- MUX 2to1 1-bit

library ieee;
	use ieee.std_logic_1164.all;

	
entity mux2to1 is
	PORT( In1, In2:  in std_logic;
	        SEL:  in std_logic;
	      OUTPUT: out std_logic );
end mux2to1;

architecture my_arch of mux2to1 is
	begin
	OUTPUT<=In1 when SEL='0' else
		In2;
end my_arch;

