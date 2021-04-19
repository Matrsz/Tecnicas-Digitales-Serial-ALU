library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myFFDREN is
	 Generic (N : natural := 4);
    Port ( clk, rst, ena : in  STD_LOGIC;
           D : in  STD_LOGIC_VECTOR (N-1 downto 0);
           Q : out  STD_LOGIC_VECTOR (N-1 downto 0));
end myFFDREN;

architecture myFFDREN_A of myFFDREN is

begin
	nffdre:for i in 0 to N-1 generate
		ffdre:entity work.myFFDRE(myFFDRE_A)
			port MAP(clk => clk,
						ena => ena,
						rst => rst,
						D => D(i),
						Q => Q(i));
	end generate;
end myFFDREN_A;

