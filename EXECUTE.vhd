-- Execution Unit
-- Mainly works with rising edge clock

use work.all;
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all;

	
entity EU is
	generic (n: integer :=8);
	port( OPA, OPB: in std_logic_vector(n-1 downto 0);
              CTRL: in std_logic_vector(7 downto 0);
	      CLK: in std_logic;
	      OPB_LSB: out std_logic;
	      PROD: out std_logic_vector(2*n-1 downto 0) );
end EU;

architecture action_control of EU is
	signal LdbarOPA, LdShOPB, LdShACC: std_logic;
	signal RstOPA, RstOPB, RstACC: std_logic;
	signal EnableOPB, EnableACC: std_logic; 
	signal OutOPA, OutOPB: std_logic_vector(n-1 downto 0);
	signal OutAdder, OutACC: std_logic_vector(n downto 0); --Includes the Cout of the adder
	signal ACCtoOPB: std_logic;

begin
	ACCtoOPB <= OutACC(0);
	LdbarOPA<=CTRL(0); LdShOPB<=CTRL(1); LdShACC<=CTRL(2);
	RstOPA<=CTRL(3); RstOPB<=CTRL(4); RstACC<=CTRL(5);
	EnableOPB<=CTRL(6); EnableACC<=CTRL(7); 

 	OPAreg: entity work.Reg(my_arch)   generic map(n)   port map( OPA, LdbarOPA, RstOPA, OutOPA) ;
	OPBreg: entity work.ShReg(my_arch) generic map(n)   port map( OPB, ACCtoOPB, LdShOPB, EnableOPB, RstOPB, CLK, OutOPB) ;
	ACCreg: entity work.ShReg(my_arch) generic map(n+1) port map( OutAdder, '0', LdShACC, EnableACC, RstACC, CLK, OutACC) ;
	ADD: entity work.FullAdder(carry_select) generic map(n) port map( OutACC(n-1 downto 0), OPA, '0', OutAdder(n-1 downto 0), OutAdder(n)) ;

	OPB_LSB <= OutOPB(0);
	PROD <=  OutACC(n-1 downto 0) & OutOPB;

end action_control;

