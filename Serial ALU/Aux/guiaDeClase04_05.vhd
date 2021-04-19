----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:32:26 11/10/2018 
-- Design Name: 
-- Module Name:    myUart - myUart_A 
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

entity myUart is
	Generic (baudRate : integer := 9600;
			 	sysClk   : integer := 100000000;
				dataSize : integer := 8);
				
	Port (clk	 : in std_logic;
			rst	 : in std_logic;
			dataWr : in std_logic;
			dataTx : in std_logic_vector (dataSize - 1 downto 0);
			ready	 : out std_logic;
			Tx		 : out std_logic;
			dataRd : out std_logic;
			dataRx : out std_logic_vector (dataSize - 1 downto 0);
			Rx		 : in std_logic);
end myUart;

architecture myUart_A of myUart is

begin
	uaTx: entity work.altUartTx(altUartTx_A)
		generic Map (baudRate => baudRate,
						 sysClk   => sysClk,
						 dataSize => dataSize)
		port Map (clk 	  => clk,
					 rst 	  => rst,
					 dataWr => dataWr,
					 dataTx => dataTx,
					 ready  => ready,
					 Tx     => Tx);
	
	uaRx: entity work.altUartRx(altUartRx_A)
		generic Map (baudRate => baudRate,
						 sysClk   => sysClk,
						 dataSize => dataSize)
		port Map (clk    => clk,
					 rst    => rst,
					 dataRd => dataRd,
					 dataRx => dataRx,
					 Rx     => Rx);
end myUart_A;

