library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity altUartRx is
	Generic (baudRate : integer := 9600;
				sysClk 	: integer := 50000000;
				dataSize : integer := 8);
	Port (clk 	 : in std_logic;
			rst 	 : in std_logic;
			dataRd : out std_logic; 
			dataRx : out std_logic_vector (7 downto 0);
			Rx 	 : in std_logic);
end altUartRx;

architecture altUartRx_A of altUartRx is
	type Tstate is (Idle, Start, Bit0, Bit1, Bit2, Bit3, Bit4, Bit5, Bit6, Bit7, Stop, Print);
	signal regNow, regNext 	: std_logic_vector(7 downto 0);
	signal startSig, rstSig : std_logic;
	signal Tsig, regSig     : std_logic; 
	signal bitNow 				: std_logic;
	signal Qnext, Qnow 		: Tstate;
begin
	bitTimer: entity work.myNCnt(myNCnt_A)
	GENERIC MAP(M => sysClk/baudRate)
	PORT MAP( clk => clk,
				 rst => startSig,
				 ena => '1',
				 salidaM_2 => regSig,
				 salidaM => Tsig);
	
	sync: process(clk) begin
		if rising_edge(clk) then
			if rstSig = '0' then
				regNow <= regNext;
				Qnow   <= Qnext;
			else 
				regNow <= (others => '1');
				Qnow   <= Idle;
			end if;
		end if;
	end process;
	
	QnextProc: process(clk, regNow, Qnow, startSig, Rx, Tsig, regSig, bitNow) begin 
		Qnext   <= Qnow;
		regNext <= regNow;
		case Qnow is
			when Idle  => if startSig = '1' then
									Qnext   <= Start;
							  end if;
			when Start => if Tsig = '1' then
									Qnext <= Bit0;
							 end if;
			when Bit0  => if regSig = '1' then 
									bitNow <= Rx;
							  elsif Tsig = '1' then
									Qnext <= Bit1;
									regNext <= regNow(6 downto 0) & bitNow;
						 	  end if;
			when Bit1  => if regSig = '1' then 
									bitNow <= Rx;
							  elsif Tsig = '1' then
									Qnext <= Bit2;
									regNext <= regNow(6 downto 0) & bitNow;
							  end if;
			when Bit2  => if regSig = '1' then 
									bitNow <= Rx;
							  elsif Tsig = '1' then
									Qnext <= Bit3;
									regNext <= regNow(6 downto 0) & bitNow;
							  end if;
			when Bit3  => if regSig = '1' then 
									bitNow <= Rx;
							  elsif Tsig = '1' then
									Qnext <= Bit4;
									regNext <= regNow(6 downto 0) & bitNow;
							  end if;
			when Bit4  => if regSig = '1' then 
									bitNow <= Rx;
							  elsif Tsig = '1' then
									Qnext <= Bit5;
									regNext <= regNow(6 downto 0) & bitNow;
							  end if;					
			when Bit5  => if regSig = '1' then 
									bitNow <= Rx;
							  elsif Tsig = '1' then
									Qnext <= Bit6;
									regNext <= regNow(6 downto 0) & bitNow;
							  end if;						
			when Bit6  => if regSig = '1' then 
									bitNow <= Rx;
							  elsif Tsig = '1' then
									Qnext <= Bit7;
									regNext <= regNow(6 downto 0) & bitNow;
							  end if;
			when Bit7  => if regSig = '1' then 
									bitNow <= Rx;
							  elsif Tsig = '1' then
									Qnext <= Stop;
									regNext <= regNow(6 downto 0) & bitNow;
							  end if;
			when Stop  => if Tsig = '1' then 
									Qnext <= Print;
								  end if;
			when Print => Qnext <= Idle;
		end case;
	end process;
	
	dataRd 	<= '1'    when Qnow = Print else '0';
	dataRx 	<= regNow when Qnow = Print else (others => '0');
	
	startSig <= '1' 	 when Qnow = Idle and Rx = '0' else '0';
	rstSig   <= rst;
end altUartRx_A;

