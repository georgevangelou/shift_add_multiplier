-- Full Adder n-bits

use work.all;
library ieee;
	use ieee.std_logic_1164.all;

	
entity FullAdder is
	generic (n: integer :=8);
	port( In1:  in std_logic_vector(n-1 downto 0);
	      In2:  in std_logic_vector(n-1 downto 0);
	      Cin:  in std_logic;
	      Sout:  out std_logic_vector(n-1 downto 0);
	      Cout: out std_logic );
end FullAdder;


architecture ripple_carry of FullAdder is
	signal Carry: std_logic_vector(n downto 1);
begin
	fa_0: entity work.fa1(my_arch) port map (In1(0),In2(0),Cin, Sout(0), Carry(1));
	generate_adders:
		for i in 1 to n-1 generate
			fa_i: entity work.fa1(my_arch) port map (In1(i),In2(i),Carry(i), Sout(i), Carry(i+1));
		end generate;
	Cout <= Carry(n);
end ripple_carry;


architecture carry_select of FullAdder is
	signal Cinner: std_logic_vector(n downto 1);

begin
	block_0: entity work.CSB(my_arch) port map(In1(0), In2(0), Cin, Sout(0), Cinner(1));
	generate_adders:
		for i in 1 to n-1 generate
			block_i: entity work.CSB(my_arch) port map(In1(i), In2(i), Cinner(i), Sout(i), Cinner(i+1));
		end generate;
	Cout <= Cinner(n);
	
end carry_select;

