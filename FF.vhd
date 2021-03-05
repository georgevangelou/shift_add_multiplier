-- Flip Flop 1-bit 

library ieee;
	use ieee.std_logic_1164.all;

	
entity FF is
	port( In1, Rst, Clk: in std_logic;
	      Out1: out std_logic);
end FF;

architecture DFF of FF is
begin
	process(Rst, Clk) begin
		if (Rst='1') then
			Out1 <= '0';
		elsif (rising_edge(Clk)) then
			Out1 <= In1;
		end if;
	end process;

end DFF;

architecture TFF of FF is
	signal temp: std_logic := '0';
begin
	process(Rst, Clk) begin
		if (Rst='1') then
			temp <= '0';
	        elsif (falling_edge(Clk)) then
                	temp <= In1 xor temp;
	       	end if; 
	end process;
	Out1 <= temp;
end TFF;
