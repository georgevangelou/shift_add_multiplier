-- Control Unit
-- Mainly works with falling edge clock

use work.all;
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.math_real.all;

	
entity CU is
	generic (n: integer :=8);
	port( START, CLKin, OPB_LSB: in std_logic;
		CTRL: out std_logic_vector(7 downto 0);
		CLKout, FINISH: out std_logic );
end CU;

architecture mind_control of CU is
	-- STATE SIGNALS
	signal Running_state, Calculating_state: std_logic := '0';
	signal InitReset_state, InitLoad_state, Adding_state, AddDone_state: std_logic := '0';
	signal ShiftOPB_state, ShiftACC_state, Done_state: std_logic := '0';
	-- CONTROL SIGNALS
	signal LdbarOPA, LdShOPB, LdShACC: std_logic := '0';
	signal RstOPA, RstOPB, RstACC: std_logic := '0';
	signal EnableOPB, EnableACC: std_logic := '0'; 
	signal CounterRst, CounterClk: std_logic := '0';

begin
	-- STATE_0.0 is Idle
	-- STATE_1.0 is InitReset
	-- STATE_2.0 is InitLoad
	-- STATE_3.1 is Adding 
	-- STATE_3.2 is AddDone
	-- STATE_3.3 is ShiftOPB
	-- STATE_3.4 is ShiftACC
	-- STATE_4.0 is Done

	process(START, CLKin, InitReset_state, InitLoad_state, Done_state, Calculating_state,  
		Adding_state, AddDone_state, ShiftOPB_state, ShiftACC_state ) 
		begin
		if (rising_edge(START)) then
			InitReset_state<='1'; --NextState
		end if;
		if (falling_edge(CLKin)) then
			  if (InitReset_state='1') then
				RstOPA<='1'; RstOPB<='1'; RstACC<='1'; CounterRst<='1'; --Reset all registers
				LdbarOPA<='1'; EnableOPB<='0'; EnableACC<='0'; 
				InitReset_state<='0'; InitLoad_state<='1'; --NextState 
			elsif (InitLoad_state='1') then
				Running_state<='1'; --Enable EU clock
				EnableOPB<='1'; 
				RstOPA<='0'; RstOPB<='0'; RstACC<='0'; CounterRst<='0'; --Disable Resets
				LdbarOPA<='0'; LdShOPB<='0'; --OPA and OPB are loaded in the next rising clock 
				InitLoad_state<='0'; Calculating_state<='1'; Adding_state<='1'; --NextState  
			elsif (Done_state='1') then
				Running_state<='0'; Calculating_state<='0';  Adding_state<='0'; --NextState
			elsif (Calculating_state='1') then
				LdbarOPA<='1'; --Freeze OPA	
			       	   if (Adding_state='1') then --Adder uses 1.5 clock cycle
					CounterClk<='1'; 
					EnableOPB<='0'; EnableACC<='0'; --Disable/Freeze OPB, ACC while adding
					Adding_state<='0'; AddDone_state<='1';
				elsif (AddDone_state='1') then
					if (OPB_LSB='1') then
						EnableACC<='1'; LdShACC<='0';  --Load ACC	
					else
						EnableACC<='0'; --Disable/Freeze ACC
					end if;				
					AddDone_state<='0'; ShiftOPB_state<='1'; --NextState
				elsif (ShiftOPB_state='1') then
					EnableOPB<='1'; EnableACC<='0'; --Enable OPB, Disable/Freeze ACC
					LdShOPB<='1';  --Shift OPB
					ShiftOPB_state<='0'; ShiftACC_state<='1'; --NextState
				elsif (ShiftACC_state='1') then
					CounterClk<='0'; --Give falling clock edge to counter
					EnableOPB<='0'; --Disable/Freeze OPB
					EnableACC<='1'; LdShACC<='1';  --Shift ACC
					ShiftACC_state<='0'; Adding_state<='1'; --NextState
				end if;
			end if;
		end if;
	end process;
	Counter_1: entity work.Counter(my_arch) generic map(integer(ceil(log2(real(n))))) port map( CounterRst, CounterClk, Done_state);
	CTRL(0)<=LdbarOPA; CTRL(1)<=LdShOPB; CTRL(2)<=LdShACC;
	CTRL(3)<=RstOPA; CTRL(4)<=RstOPB; CTRL(5)<=RstACC;
	CTRL(6)<=EnableOPB; CTRL(7)<=EnableACC;
	CLKout <= CLKin and Running_state;
	FINISH <= Done_state;
end mind_control;
