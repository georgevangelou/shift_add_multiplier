--Test Bench of Shift/Add Multiplier

use work.all;
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;
	
entity Testbench is
	generic (n: integer := 32);
	port( Input1, Input2: in std_logic_vector(n-1 downto 0);
		Start: in std_logic;
		Product: out std_logic_vector(2*n-1 downto 0);
                EndofMult: out std_logic );
end Testbench;

architecture our_test of Testbench is
	constant ClkFreq: integer := 10e6;
	constant ClkPer: time := 1000 ms / ClkFreq;
	signal CLK: std_logic := '0';
begin
	CLK <= not CLK after ClkPer / 2;
	ourSAM: entity work.SAM(EvangelouRoussos) 
			generic map(n)
			port map( Input1, Input2, Start, CLK, Product, EndofMult) ;
	
end our_test;