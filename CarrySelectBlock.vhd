-- Carry Select Block

use work.all;
library ieee;
	use ieee.std_logic_1164.all;

entity CSB is
	port( A, B:  in std_logic;
	      Cin:   in std_logic;
	      Sout:    out std_logic;
	      Cout: out std_logic );
end CSB;


architecture my_arch of CSB is
	signal Sout0: std_logic;
	signal Sout1: std_logic;
	signal Cout0: std_logic;
	signal Cout1: std_logic;
begin
	fa0: entity work.fa1(my_arch) port map(A, B, '0', Sout0, Cout0);
	fa1: entity work.fa1(my_arch) port map(A, B, '1', Sout1, Cout1);
	Sout <= Sout0 when Cin='0' else Sout1;
	Cout <= Cout0 when Cin='0' else Cout1;	
end my_arch;
