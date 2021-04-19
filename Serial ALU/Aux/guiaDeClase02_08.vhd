----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:15:49 10/26/2018 
-- Design Name: 
-- Module Name:    myShiftRegLRP - myShiftRegLRP_A 
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

entity myShiftRegLRP is
	 Generic (N : Natural := 4);
    Port ( clk : in STD_LOGIC; 
			  rst : in STD_LOGIC := '0'; 
			  ena : in STD_LOGIC := '1';			 
			  dir : in STD_LOGIC := '0';
			  pll : in STD_LOGIC := '0'; 
			  dl 	: in STD_LOGIC := '0';
			  dr 	: in STD_LOGIC := '0';
           D 	: in  STD_LOGIC_VECTOR (N-1 downto 0) := (others => '0');
           Q 	: out  STD_LOGIC_VECTOR (N-1 downto 0));
end myShiftRegLRP;

architecture myShiftRegLRP_A of myShiftRegLRP is
	signal Qnext, Qnow : STD_LOGIC_VECTOR (N-1 downto 0);
	
begin	
	sync: entity work.myFFDREN(myFFDREN_A)
		generic Map(N => N)
		port Map(clk => clk,
					rst => rst,
					ena => ena,
					D 	 => Qnext,
					Q   => Qnow);
		
	Qnext <= D when pll = '1' else Dl & Qnow(N-1 downto 1) when dir = '0' else Qnow(N-2 downto 0) & Dr;
	Q <= Qnow;
end myShiftRegLRP_A;

