library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity myUartTest is
	Generic (baudRate : integer := 9600;
			 	sysClk   : integer := 100000000;
				dataSize : integer := 8);
				
    Port ( clk : in   STD_LOGIC;
           rst : in   STD_LOGIC;
           sw  : in   STD_LOGIC_VECTOR (3 downto 0);
           Tx  : out  STD_LOGIC;
           Rx  : in   STD_LOGIC;
           led : out  STD_LOGIC_VECTOR (7 downto 0));
end myUartTest;

architecture myUartTest_A of myUartTest is
	signal txSig        : std_logic_vector(7 downto 0);
	signal edgeR, edgeF : std_logic_vector(3 downto 0);
	signal wrSig        : std_logic;
begin
	txSig <= sw & "0101";
	
	edgeDet: for i in 0 to 3 generate
		det: entity work.myEdgeDetector
			port Map(clk  => clk,
			         rst  => rst,
						X    => sw(i),
						asc  => edgeR(i),
						desc => edgeF(i));
	end generate;
	wrSig <= '0' when edgeR <= "0000" and edgeF <= "0000" else '1';
	
	uart: entity work.myUart(myUart_A)
		generic Map (baudRate => baudRate,
						 sysClk   => sysClk,
						 dataSize => dataSize)		
		port Map (clk    => clk, 
					 rst    => rst,
					 dataWr => wrSig,
					 dataTx => txSig,
					 ready  => open,
					 Tx     => Tx,
					 dataRd => open,
					 dataRx => led,
					 Rx     => Rx);
	
end myUartTest_A;

