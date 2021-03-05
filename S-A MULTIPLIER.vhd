-- Shift/Add Multiplier

use work.all;
library ieee;
	use ieee.std_logic_1164.all;


entity SAM is
	generic (n: integer :=8);
	port( Input1, Input2: in std_logic_vector(n-1 downto 0);
		Start, CLK: in std_logic;
		Product: out std_logic_vector(2*n-1 downto 0);
                EndofMult: out std_logic );
	
end SAM;

architecture EvangelouRoussos of SAM is
	signal ExecCLK: std_logic := '0';
	signal OPB_LSB: std_logic;
	signal CONTROLS: std_logic_vector(7 downto 0);

begin
	ourController: entity work.CU(mind_control)    generic map(n) port map( Start, CLK, OPB_LSB, CONTROLS, ExecCLK ,EndofMult);
	ourExecutioner: entity work.EU(action_control) generic map(n) port map( Input1, Input2, CONTROLS, ExecCLK, OPB_LSB, Product);
end EvangelouRoussos;
