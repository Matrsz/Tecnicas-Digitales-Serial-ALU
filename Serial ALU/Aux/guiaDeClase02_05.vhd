Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


Entity myEdgeDetector is
    Port ( clk, rst, X : in  STD_LOGIC;
           asc, desc : out  STD_LOGIC);
end myEdgeDetector;

Architecture myEdgeDetector_A of myEdgeDetector is
	Type Tstate is (D, C, B, A);
	signal Qnext, Qnow : Tstate;
	
begin
	sinc: process(clk, rst) begin
		if rst = '1' then
			Qnow <= D;
		elsif rising_Edge(clk) then
			Qnow <= Qnext;
		end if;
	end process;
	
	qnex: process(Qnow, X) begin
		Qnext <= Qnow;
		case Qnow is
			when D => if X = '1' then 
			             Qnext <= C;
						 end if;
			when B => if X = '0' then 
			             Qnext <= A;
						 end if;
			when A => if X = '1' then
							 Qnext <= C;
						 else 
							 Qnext <= D;
					    end if;
			when C => if X = '0' then
							 Qnext <= A;
						 else 
							 Qnext <= B;
					    end if;
		end case;
	end process;

	asc <= '1' when Qnow = C else '0';
	desc <= '1' when Qnow = A else '0';
	
end myEdgeDetector_A;

