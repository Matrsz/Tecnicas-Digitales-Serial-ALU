library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity altUartTx is
	Generic (baudRate : integer := 9600;
				sysClk 	: integer := 50000000;
				dataSize : integer := 8);
	Port ( clk 	  : in std_logic;
			 rst 	  : in std_logic;
			 dataWr : in std_logic;
			 dataTx : in std_logic_vector (7 downto 0);
			 ready  : out std_logic;
			 tx 	  : out std_logic);
end altUartTx;

architecture altUartTx_A of altUartTx is
	type Tstate is (Idle, Start, Bit0, Bit1, Bit2, Bit3, Bit4, Bit5, Bit6, Bit7, Stop);
	signal regNext, regNow   		: std_logic_vector(7 downto 0);
	signal Qnext  , Qnow     		: Tstate;
	signal Tsig, startSig, rstSig : std_logic;
begin

	bitTimer: entity work.myNCnt(myNCnt_A)
	GENERIC MAP(M => sysClk/baudRate)
	PORT MAP( clk		  => clk,
				 rst 		  => startSig,
				 ena 		  => '1',
				 salidaM_2 => open,
				 salidaM   => Tsig);
	
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
	
	QnextProc: process(clk, regNow, Qnow, startSig, dataTx, Tsig) begin 
		Qnext   <= Qnow;
		regNext <= regNow;
		case Qnow is
			when Idle  => if startSig = '1' then
									regNext <= dataTx;
									Qnext   <= Start;
							  end if;
			when Start => if Tsig = '1' then
									Qnext	  <= Bit0;
							  end if;
			when Bit0  => if Tsig = '1' then
									Qnext   <= Bit1;
									regNext <= '1' & regNow(7 downto 1);
						 	  end if;
			when Bit1  => if Tsig = '1' then
									Qnext   <= Bit2;
									regNext <= '1' & regNow(7 downto 1);
							  end if;
			when Bit2  => if Tsig = '1' then
									Qnext   <= Bit3;
									regNext <= '1' & regNow(7 downto 1);
						 	  end if;
			when Bit3  => if Tsig = '1' then
									Qnext   <= Bit4;
									regNext <= '1' & regNow(7 downto 1);
							  end if;
			when Bit4  => if Tsig = '1' then
									Qnext   <= Bit5;
									regNext <= '1' & regNow(7 downto 1);
							  end if;					
			when Bit5  => if Tsig = '1' then
									Qnext   <= Bit6;
									regNext <= '1' & regNow(7 downto 1);
							  end if;						
			when Bit6  => if Tsig = '1' then 
									Qnext   <= Bit7;
									regNext <= '1' & regNow(7 downto 1);
							  end if;
			when Bit7  => if Tsig = '1' then 
									Qnext   <= Stop;
							  end if;
			when Stop  => if Tsig = '1' then 
									Qnext   <= Idle;
								  end if;
		end case;
	end process;

	ready <= '1' when Qnow = Idle else '0';
	
	with Qnow select Tx <= '1' 		when Idle,
								  '0' 		when Start,
								  '1' 		when Stop,
								  regNow(0) when Others;
	
	startSig <= '1' when Qnow = Idle and dataWr = '1' else '0';
	rstSig 	<= rst;
end altUartTx_A;

