library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myReverse is
	 Generic ( N: integer := 8);
    Port ( dataIn : in  STD_LOGIC_VECTOR (N-1 downto 0);
           dataOut : out  STD_LOGIC_VECTOR (N-1 downto 0));
end myReverse;

architecture myReverse_A of myReverse is

begin

	reverse : for i in 0 to N-1 generate
		dataOut (i) <= dataIn (N - 1 - i);
	end generate;

end myReverse_A;

