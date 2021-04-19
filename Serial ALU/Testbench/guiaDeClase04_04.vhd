
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity myUartRxTest is
	Generic (baudRate : integer := 9600;
			 	sysClk   : integer := 100000000;
				dataSize : integer := 8);
				
    Port ( clk : in   STD_LOGIC;
           rst : in   STD_LOGIC;
           led : out  STD_LOGIC_VECTOR (dataSize-1 downto 0);
           Rx  : in   STD_LOGIC);
end myUartRxTest;

architecture myUartRxTest_A of myUartRxTest is
	signal holdSig : STD_LOGIC_VECTOR(dataSize-1 downto 0);
	signal enaSig  : STD_LOGIC;
begin
		uaRx: entity work.myUartRx(myUartRx_A)
		generic Map (baudRate => baudRate,
						 sysClk   => sysClk,
						 dataSize => dataSize)
		port Map (clk    => clk,
					 rst    => rst,
					 dataRd => enaSig,
					 dataRx => holdSig,
					 Rx     => Rx);
					 
		hold: entity work.myFFDREN(myFFDREN_A)
		generic Map (N => dataSize)
		port Map (clk => clk,
					 rst => rst,
					 ena => enaSig,
					 D	  => holdSig,
					 Q   => led);
			
end myUartRxTest_A;

