library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mySerialALU is
	Generic (baudRate : integer := 1250000;
			 	sysClk   : integer := 50000000);
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           Rx  : in  STD_LOGIC;
           Tx  : out STD_LOGIC);
end mySerialALU;

architecture mySerialALU_A of mySerialALU is
	signal dataRx   	: STD_LOGIC_VECTOR(7 downto 0);
	signal dataRxIn	: STD_LOGIC_VECTOR(7 downto 0);
	signal opIn 	 	: STD_LOGIC_VECTOR(7 downto 0);
	signal inA, inB 	: STD_LOGIC_VECTOR(7 downto 0);
	
	signal outA, outB : STD_LOGIC_VECTOR(7 downto 0);	
	signal dataTx   	: STD_LOGIC_VECTOR(7 downto 0);
	signal dataTxOut 	: STD_LOGIC_VECTOR(7 downto 0);
	
	signal memA, memB : STD_LOGIC_VECTOR(7 downto 0);
	signal memWr	   : STD_LOGIC;
	
	signal aluA, aluB : STD_LOGIC_VECTOR(7 downto 0);
	
	signal waitE, waitS		: STD_LOGIC;
	signal waitEna          : STD_LOGIC;
	
	signal dataRd, dataWr   : STD_LOGIC;
	signal readySig, TxEnd  : STD_LOGIC;
	signal ena1, ena2, ena3 : STD_LOGIC;
	signal rstIn			   : STD_LOGIC;
	
	type Tstate is (Idle, Rx1, Rx2, Rx3, Tx1, Wait1, Tx2, Wait2, Tx3, Wait3);
	signal Qnow, Qnext : Tstate := Idle;
	
begin

	--	Inversión de señales dataTx y dataRx si myUart transmite y recibe LSB primero --
	--RxIn: entity work.myReverse(myReverse_A)
	--	generic Map (N => 8)
	--	port Map (dataIn  => dataRxIn,
	--				 dataOut => dataRx);
	TxOut: entity work.myReverse(myReverse_A)
		generic Map (N => 8)
		port Map (dataIn  => dataTx,
					 dataOut => dataTxOut);
	
	-- dataTx y dataRx si myUart transmite y recibe MSB primero 
	dataRx 	 <= dataRxIn;
	-- dataTxOut <= dataTx;
	
	-- Instancia de UART --
	UART: entity work.myUart(myUart_A)
		generic Map (baudRate => baudRate,
						 sysClk   => sysClk,
						 dataSize => 8)
		port Map (clk    => clk,
					 rst 	  => rstIn,
					 dataWr => dataWr,
					 dataTx => dataTxOut,
					 ready  => readySig,
					 Tx	  => Tx,
					 dataRd => dataRd,
					 dataRx => dataRxIn,
					 Rx 	  => Rx);
	rstIn <= not(rst);
	
	-- Instancia de ALU que realiza todas las operaciones de tipo aritmético --
	ALU: entity work.myAlu(myAlu_A)
		port Map (inA  => inA,
					 inB  => inB,
					 opIn => opIn,
					 outA => aluA,
					 outB => aluB);
	
	-- 8 y 8 FFD son registro de memoria, escritura habilitada con pulso de lectura en instrucción 07 --
	MemoryA: entity work.myFFDREN(myFFDREN_A)
		generic Map( N => 8)
		port Map ( clk => clk,
					  rst => rstIn,
					  ena => memWr,
					  D 	=> inA, 
					  Q 	=> memA);
	MemoryB: entity work.myFFDREN(myFFDREN_A)
		generic Map( N => 8)
		port Map ( clk => clk,
					  rst => rstIn,
					  ena => memWr,
					  D 	=> inB, 
					  Q 	=> memB);
	memWr <= '1' when opIn = x"07" and Qnow = Rx3 else '0';
	
	-- Seleccin de trama a Tx y Enrutamiento de ALU o registro de memoria según comando --
	with Qnext select dataTx <= opIn  when Tx1,
										 outA  when Tx2,
										 outB  when Tx3,
										 x"FF" when others;
										 
	with opIn  select outB   <= memB  when x"08",
										 aluB  when others;
	with opIn  select outA   <= memA  when x"08",
										 aluA  when others;
										 
	-- Detector de finalizacin de Tx ---
	endTxDet: entity work.myEdgeDetector(myEdgeDetector_A)
		port Map (clk 		  => clk,
					 rst 		  => rstIn,
					 X 		  => readySig,
					 desc	     => open,
					 asc		  => TxEnd);
					 
	-- Instruccin de Tx --
	dataWr <= '1' when (Qnow = Wait1 or  Qnow = Wait2 or Qnow = Wait3) and waitE = '1' else '0';
	
	--Retención de dataIn -- 
	HoldO: entity work.myFFDREN(myFFDREN_A)
		generic Map( N => 8)
		port Map ( clk => clk,
					  rst => rstIn,
					  ena => ena1,
					  Q 	=> opIn,
					  D 	=> dataRx);
	HoldA: entity work.myFFDREN(myFFDREN_A)
		generic Map( N => 8)
		port Map ( clk => clk,
					  rst => rstIn,
					  ena => ena2,
					  Q 	=> inA,
					  D 	=> dataRx);
	HoldB: entity work.myFFDREN(myFFDREN_A)
		generic Map( N => 8)
		port Map ( clk => clk,
					  rst => rstIn,
					  ena => ena3,
					  Q 	=> inB,
					  D 	=> dataRx);
	ena1 <= dataRd when Qnow = Idle else '0';
	ena2 <= dataRd when Qnow = Rx1  else '0';
	ena3 <= dataRd when Qnow = Rx2  else '0';
	
	-- Proceso de estado siguiente --
	QnextProc : process (clk, Qnow, dataRd, TxEnd) begin
		Qnext <= Qnow;
		case Qnow is
			when Idle  => if dataRd = '1' then Qnext <= Rx1;
							  end if;	
			when Rx1   => if dataRd = '1' then Qnext <= Rx2;
							  end if;
			when Rx2   => if dataRd = '1' then Qnext <= Rx3;
							  end if;
			when Rx3   => Qnext <= Wait1;
			
			when Wait1 => if waitE = '1' 	  then Qnext <= Tx1;
							  end if;
			when Tx1   => if ReadySig = '1' then Qnext <= Wait2;
							  end if;
			when Wait2 => if waitE = '1' 	  then Qnext <= Tx2;
							  end if;
			when Tx2   => if ReadySig = '1' then Qnext <= Wait3;
							  end if;
			when Wait3 => if WaitE = '1' 	  then Qnext <= Tx3;
							  end if;
			when Tx3   => if ReadySig = '1' then Qnext <= Idle;
							  end if;
		end case;
	end process;
	
	-- Bits de espera entre Tx --
	waitS <= '1' when (Qnow = Rx3 and Qnext = Wait1) or (Qnow = Rx1 and Qnext = wait2) or (Qnow = Tx2 and Qnext = wait3) else '0';
	bitTimer: entity work.myNCnt(myNCnt_A)
		generic Map(M 		  => 2*sysClk/baudRate)
		port Map (clk 		  => clk,
				    rst 		  => waitS,
					 ena       => waitEna,
					 salidaM   => waitE,
					 salidaM_2 => open);
	waitEna <= '1' when Qnow = Wait1 or Qnow = Wait2 or Qnow = Wait3 else '0';
	
	-- Proceso sincrónico con estado por defecto Idle --
	sync: process(clk) begin
		if rising_Edge(clk) then
			if rstIn = '1' then
				Qnow <= Idle;
			else
				Qnow <= Qnext;
			end if;
		end if;
	end process;
	
end mySerialALU_A;