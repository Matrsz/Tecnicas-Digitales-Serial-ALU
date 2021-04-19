library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.MATH_REAL.ALL;

entity myNCnt is
	 Generic ( M : integer := 32);
    Port ( clk, rst, ena : in  STD_LOGIC;
           salidaM, salidaM_2 : out  STD_LOGIC);
end myNCnt;

architecture myNCnt_A of myNCnt is
	constant N : integer := integer(ceil(log2(real(M+1))));
	signal Qnow, Qnext : std_logic_vector(N-1 downto 0) := std_logic_vector(to_unsigned(0, N));
	signal salidaMsig : std_logic;
begin

	sync: entity work.myFFDREN(myFFDREN_A)
		generic Map(N => N)
		port Map(clk => clk,
					rst => rst,
					ena => ena,
					D => Qnext,
					Q => Qnow);
	
	salidaM_2 <= '1' when unsigned(Qnow) = to_unsigned(M/2, N) else '0';
	salidaMsig <= '1' when unsigned(Qnow) = to_unsigned(M, N) else '0';
	salidaM <= salidaMsig;
	
	Qnext <= std_logic_vector(to_unsigned(1, N)) when salidaMsig = '1' 
				else  std_logic_vector(unsigned(Qnow)+1);
end myNCnt_A;
