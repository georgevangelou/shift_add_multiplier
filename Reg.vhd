-- Register n-bits 

use work.all;library ieee;	use ieee.std_logic_1164.all;entity Reg is	generic (n: integer :=8);	port( In1: in std_logic_vector(n-1 downto 0);	  Ld_bar, Rst: in std_logic;      	     Out1: out std_logic_vector(n-1 downto 0) );end Reg;architecture my_arch of Reg is
	signal Ld: std_logic;begin
	Ld <= not Ld_bar;	generate_FFs:		for i in 0 to n-1 generate			FF_i: entity work.FF(DFF) port map( In1(i), Rst, Ld, Out1(i));		end generate;end my_arch;
