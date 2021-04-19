library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myFFDRE is
    Port ( clk, rst, ena, D : in  STD_LOGIC;
           Q : out  STD_LOGIC);
end myFFDRE;

architecture myFFDRE_A of myFFDRE is
	signal Qsig, Dsig : STD_LOGIC;
begin
	Dsig <= D when ena = '1' else Qsig;
	ffdr:entity work.myFFDR(myFFDR_A) 
		port MAP(clk => clk,
					rst => rst,
					D => Dsig,
					Q => Qsig);
	Q <= Qsig;
		
end myFFDRE_A;

