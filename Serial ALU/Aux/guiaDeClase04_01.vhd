library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity myUartTx is
	Generic (baudRate : integer := 9600;
				sysClk   : integer := 100000000;
				dataSize : integer := 8);
				
	Port (clk 	 : in std_logic;
			rst 	 : in std_logic;
			dataWr : in std_logic;
			dataTx : in std_logic_vector (dataSize - 1 downto 0);
			ready  : out std_logic := '1';
			tx 	 : out std_logic := '1');
end myUartTx;


architecture myUartTx_A of myUartTx is
	type Tstate is (Idle, TxState);
	
	signal endSig, setSig : std_logic;
	signal TSig, enaSig   : std_logic;
	signal Qsig, pllSig 	 : std_logic_vector(dataSize+1 downto 0);
	signal Qnext, Qnow 	 : Tstate := Idle;

begin
	-- Divisor de frecuencia envía un pulso de habilitación cada 104us, Inicializado con dataWr--
	freqDiv: entity work.myNCnt(myNCnt_A)
		generic Map (M 	  => sysClk/baudRate)
		port Map (clk 		  => clk,
					 rst 		  => setSig,
					 ena 		  => '1',
					 salidaM   => TSig,
					 salidaM_2 => open);
	
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
	
	-- Registro de desplazamiento de datos a transmitir, con leading 0 y trailing 1 --
	shiftR: entity work.myShiftRegLRP(myShiftRegLRP_A)
		generic Map(N => dataSize+2)
		port Map(clk  => clk,
					rst  => rst,
					ena  => enaSig,
					D 	  => pllSig,
					pll  => setSig,
					Q    => Qsig);
	pllSig <= '1' & dataTx & '0';
	
	-- Contador de bits transmitidos sincronizado con shift Reg --
	bitTimer: entity work.myNCnt(myNCnt_A)
		generic Map(M 		  => dataSize + 1)
		port Map (clk 		  => clk,
				    rst 		  => setSig,
					 ena       => enaSig,
					 salidaM   => endSig,
					 salidaM_2 => open);
	
	-- Process de estado siguiente --
	qnex: process(Qnow, Tsig, setSig, endSig) begin
		Qnext <= Qnow;
		case Qnow is
			when Idle 	 => if setSig = '1' then Qnext <= TxState;
								 end if;
			when TxState => if endSig = '1' and Tsig = '1' then Qnext <= Idle;
								 end if;
		end case;
	end process;
	
	-- Salidas y señales de control --
	
	setSig <= dataWr  when Qnow = Idle else '0';
	enaSig <= dataWr  when Qnow = Idle else Tsig;
	ready  <= '1'     when Qnow = Idle else '0';
	Tx     <= '1'     when Qnow = Idle else Qsig(0);
	
end myUartTx_A;