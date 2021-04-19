----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:04:17 12/06/2018 
-- Design Name: 
-- Module Name:    myRotator - myRotator_A 
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

entity myRotator is
    Port ( N : in  STD_LOGIC_VECTOR (7 downto 0);
           X : in  STD_LOGIC_VECTOR (7 downto 0);
           Y : out STD_LOGIC_VECTOR (7 downto 0));
end myRotator;

architecture myRotator_A of myRotator is

begin
	with N select Y <= X(0)          & X(6 downto 0) when "11111111",
							 X(1 downto 0) & X(5 downto 0) when "11111110",
					       X(2 downto 0) & X(4 downto 0) when "11111101",
					       X(3 downto 0) & X(3 downto 0) when "11111100",
					       X(4 downto 0) & X(2 downto 0) when "11111011",
					       X(5 downto 0) & X(1 downto 0) when "11111010",
					       X(6 downto 0) & X(0)          when "11111001",
					       X(0)          & X(6 downto 0) when "00000001",
							 X(1 downto 0) & X(5 downto 0) when "00000010",
					       X(2 downto 0) & X(4 downto 0) when "00000011",
					       X(3 downto 0) & X(3 downto 0) when "00000100",
					       X(4 downto 0) & X(2 downto 0) when "00000101",
					       X(5 downto 0) & X(1 downto 0) when "00000110",
					       X(6 downto 0) & X(0)          when "00000111",
							 X										 when others;
end myRotator_A;

