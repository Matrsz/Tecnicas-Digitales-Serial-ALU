----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:54:45 11/15/2018 
-- Design Name: 
-- Module Name:    guiaDeClase04_02 - guiaDeClase04_02 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity myUartTxTest is
	Generic (baudRate : integer := 9600;
			 	sysClk   : integer := 100000000;
				dataSize : integer := 8);
				
	Port (clk : in  std_logic;
			rst : in  std_logic;
			sw  : in  std_logic_vector(3 downto 0);
			Tx  : out std_logic);
end myUartTxTest;

architecture myUartTxTest_A of myUartTxTest is
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
	
	uaTx: entity work.myUartTx(myUartTx_A)
		generic Map (baudRate => baudRate,
						 sysClk   => sysClk,
						 dataSize => dataSize)
		port Map (clk 	  => clk,
					 rst 	  => rst,
					 dataWr => wrSig,
					 dataTx => txSig,
					 ready  => open,
					 Tx     => Tx);

end myUartTxTest_A;

