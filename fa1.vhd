-- Full Adder 1-bit

library ieee;
	use ieee.std_logic_1164.all;

	
entity fa1 is
	PORT( In1:  in std_logic;
	      In2:  in std_logic;
	      Cin:  in std_logic;
	      S: out std_logic;
	      Cout: out std_logic );
end fa1;

architecture my_arch of fa1 is
	signal inner: std_logic;
	begin
		inner <= In1 xor In2;
		S <= inner xor Cin;
		Cout <= (In1 and In2) or (inner and Cin);
end my_arch;
