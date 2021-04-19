library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity myAlu is
    Port ( opIn 		 : in   STD_LOGIC_VECTOR(7 downto 0);
           inA, inB 	 : in   STD_LOGIC_VECTOR(7 downto 0);
           outA, outB : out  STD_LOGIC_VECTOR(7 downto 0));
end myAlu;

architecture myAlu_A of myAlu is
	signal AddorSub     : STD_LOGIC_VECTOR(7  downto 0);
	signal overSig		  : STD_LOGIC_VECTOR(7  downto 0);
	signal incr, decr	  : STD_LOGIC_VECTOR(15 downto 0);
	signal rotB			  : STD_LOGIC_VECTOR(7  downto 0);
	signal SnA, over	  : STD_LOGIC;
begin
	-- Selector de operaciones multiplexado por instrucción --
	with opIn select outA <= not(inA) 			 when x"00",
									 AddorSub			 when x"01",
									 AddorSub			 when x"02",
									 inA and inB 		 when x"03",
									 inA or inB  		 when x"04",
									 incr(15 downto 8) when x"05",
									 decr(15 downto 8) when x"06",				 
									 inA					 when others;
									 
	with opIn select outB <= not(inB) 			 when x"00",
									 overSig				 when x"01",
									 overSig		 		 when x"02",
									 x"00"		 		 when x"03",
									 x"00"	   		 when x"04",
									 incr(7  downto 0) when x"05",
									 decr(7  downto 0) when x"06",
									 rotB 				 when x"09",
									 inB					 when others;
	
	-- Operaciones de incremento y decremento--
	incr <= std_logic_vector(unsigned(inA & inB)+1);
	decr <= std_logic_vector(unsigned(inA & inB)-1);
	
	-- Operaciones de suma y resta --
	Adder: entity work.myAdder(myAdder_A)
		port Map (A => inA,
					 B => inB,
					 S => AddorSub,
					 SnA => SnA,
					 over => over);				 
	SnA 	  <= '1'   when opIn = x"02" else '0';
	overSig <= x"FF" when over = '1'   else x"00";
	
	Rotator: entity work.myRotator(myRotator_A)
	port Map (N   => inA,
				 X   => inB,
				 Y   => rotB);
end myAlu_A;

