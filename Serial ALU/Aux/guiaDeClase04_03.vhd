library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myUartRx is
	Generic ( baudRate : integer := 9600;
				 sysClk   : integer := 100000000;
				 dataSize : integer := 8);
				 
	Port ( clk 	  : in std_logic;
			 rst    : in std_logic;
			 dataRd : out std_logic;
			 dataRx : out std_logic_vector (dataSize - 1 downto 0);
			 Rx  	  : in std_logic);
end myUartRx;

architecture myUartRx_A of myUartRx is
	type Tstate is (Idle, RxState, Stop);
	
	signal Tsig, T_2sig, enaSig		: std_logic;
	signal edgeSig, startSig, endSig : std_logic;
	signal Qsig                      : std_logic_vector(dataSize-1 downto 0);
	signal Qnext, Qnow 	   			: Tstate;

begin
	-- Divisor de frecuencia envía pulsos de T y de T_2, Inicializado con startSig--
	freqDiv: entity work.myNCnt(myNCnt_A)
		generic Map (M 	  => sysClk/baudRate)
		port Map (clk 		  => clk,
					 rst 		  => startSig,
					 ena 		  => '1',
					 salidaM   => TSig,
					 salidaM_2 => T_2Sig);
	
	-- Proceso sincrónico con estado por defecto Idle --
	sync: process(clk) begin
		if rising_Edge(clk) then
			if rst = '1' then
				Qnow <= Idle;
			else
				Qnow <= Qnext;
			end if;
		end if;
	end process;
	
	-- Registro de desplazamiento de datos recibidos --
	shiftR: entity work.myShiftRegLRP(myShiftRegLRP_A)
		generic Map(N => dataSize)
		port Map(clk  => clk,
					rst  => rst,
					ena  => enaSig,
					Dl   => Rx,
					Q    => Qsig);
	
	-- Detector de Flanco Descendente detecta Inicio de Rx--
	edgeDet: entity work.myEdgeDetector(myEdgeDetector_A)
		port Map(clk  => clk,
					rst  => rst,
					X 	  => Rx,
					asc  => open,
					desc => edgeSig);
	
	bitTimer: entity work.myNCnt(myNCnt_A)
		generic Map(M 		  => dataSize + 1)
		port Map (clk 		  => clk,
				    rst 		  => startSig,
					 ena       => Tsig,
					 salidaM   => endSig,
					 salidaM_2 => open);
	
	qnex: process(Qnow, startSig, endSig, Tsig) begin
		Qnext <= Qnow;
		case Qnow is
			when Idle 	 => if startSig = '1' then Qnext <= RxState;
								 end if;
			when RxState => if endSig = '1'   then Qnext <= Stop;
								 end if;
			when Stop    => Qnext <= Idle;
		end case;
	end process;
	
	startSig <= edgeSig 						  when Qnow = Idle    else '0';
	enaSig   <= T_2Sig  						  when Qnow = RxState else '0';
	dataRd   <= '1'     						  when Qnow = Stop    else '0';
	dataRx   <= Qsig(dataSize-1 downto 0) when Qnow = Stop    else (others => '0');

end myUartRx_A;

