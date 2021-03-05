-- Shift Register n-bits 

library ieee;
	use ieee.std_logic_1164.all;

entity ShReg is
	generic (n: integer :=8);
	port( In1:  in std_logic_vector(n-1 downto 0);
	      MSB: in std_logic;
	      Sh_Ld_bar, Enable, Rst, Clk_in: in std_logic; 
	      Out1: out std_logic_vector(n-1 downto 0) );
end ShReg;

architecture my_arch of ShReg is
	signal Clk: std_logic;
	signal mux_out: std_logic_vector(n-1 downto 0);
	signal ff_out:  std_logic_vector(n downto 0);
begin	
	Clk <= Clk_in and Enable;
	ff_out(n) <= MSB;
	generate_1:
		for i in 0 to n-1 generate
			mux_i: entity work.mux2to1(my_arch) port map( In1(i), ff_out(i+1), Sh_Ld_bar, mux_out(i));
			FF_i: entity work.FF(DFF) port map( mux_out(i), Rst, Clk, ff_out(i));
		end generate;
	Out1 <= ff_out(n-1 downto 0);

end my_arch;
