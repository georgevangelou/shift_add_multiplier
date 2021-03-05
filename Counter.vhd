-- Counter n-bits

use work.all;
library ieee;
	use ieee.std_logic_1164.all;

	
entity Counter is
	generic (n: integer :=3);
	port( Rst, Clk: in std_logic;
	      Finish: out std_logic );
end Counter;

architecture my_arch of Counter is
	signal Clk_0, last: std_logic;
	signal inner: std_logic_vector(n-1 downto 0);
begin
	Clk_0 <= Clk;
	TFF_0: entity work.FF(TFF) port map( '1', Rst, Clk_0, inner(0));
	generate_TFFs:
		for i in 1 to n-1 generate
			TFF_i: entity work.FF(TFF) port map( '1', Rst, inner(i-1), inner(i));
		end generate;
	last <= not inner(n-1);
	DetectEndDFF: entity work.FF(DFF) port map( '1', Rst, last, Finish);
end my_arch;

