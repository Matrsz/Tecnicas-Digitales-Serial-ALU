----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:55:07 11/20/2018 
-- Design Name: 
-- Module Name:    myAdder - myAdder_A 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity myAdder is
	 Generic (N : natural := 8);
    Port ( A, B : in   STD_LOGIC_VECTOR (N-1 downto 0);
           S    : out  STD_LOGIC_VECTOR (N-1 downto 0);
           SnA  : in   STD_LOGIC;
           over : out  STD_LOGIC);
end myAdder;

architecture myAdder_A of myAdder is
	signal Ssig 	  : STD_LOGIC_VECTOR(N-1 downto 0);
	signal overCheck : STD_LOGIC_VECTOR(3 downto 0);
begin
	
	-- Selector de operación --
	Ssig <= std_logic_vector(unsigned(A) + unsigned(B)) when SnA = '0' else std_logic_vector(unsigned(A) - unsigned(B));
	S <= Ssig;
	
	-- Control de Overflow --
	overCheck <= SnA & A(N-1) & B(N-1) & Ssig(N-1);
	with overCheck select over <= '1' when "0001",
											'1' when "0110",
											'1' when "1011",
											'1' when "1100",
											'0' when others;
end myAdder_A;

