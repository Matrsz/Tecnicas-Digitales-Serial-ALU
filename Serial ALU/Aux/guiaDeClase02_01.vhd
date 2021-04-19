library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myFFDR is
    Port ( clk, rst, D : in  STD_LOGIC;
           Q : out  STD_LOGIC);
end myFFDR;

architecture myFFDR_A of myFFDR is

begin
	ffdrProc:Process(clk, rst)
	begin		
		if rising_Edge(clk) then
			Q <= D and not(rst);
		end if;
	end process;
end myFFDR_A;

