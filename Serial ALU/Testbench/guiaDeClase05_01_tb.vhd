LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY guiaDeClase05_01_tb IS
END guiaDeClase05_01_tb;
 
ARCHITECTURE behavior OF guiaDeClase05_01_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mySerialALU
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         tx : OUT  std_logic;
         rx : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal rx : std_logic := '0';

 	--Outputs
   signal tx : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mySerialALU PORT MAP (
          clk => clk,
          rst => rst,
          tx => tx,
          rx => rx
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period*0.6;
		clk <= '1';
		wait for clk_period*0.4;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
	
      ----------------------------------------------------------------------------------------
		-- Valores iniciales
      rst <= '0';					   -- reset uut
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		
		rst <= '1';					   -- enable uut
		wait for 40*clk_period;    -- tiempo bit
      
     	
      ----------------------------------------------------------------------------------------
		-- PRIMERA TRAMA
		rst <= '1';						-- enable module -- OpIn : Escritura en memoria
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		wait for 2*40*clk_period;
										
		rx <= '1';					   -- rx en IDLE -- inA
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		wait for 2*40*clk_period;
		
		rx <= '1';					   -- rx en IDLE -- inB
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		wait for 5*12*40*clk_period;
		
		----------------------------------------------
		-- SEGUNDA TRAMA
		rst <= '1';						-- enable module -- opIn : Negacin
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		wait for 2*40*clk_period;
										
		rx <= '1';					   -- rx en IDLE -- inA
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		wait for 2*40*clk_period;
		
		rx <= '1';					   -- rx en IDLE --inB
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		wait for 3*12*40*clk_period;
		
		----------------------------------------------
		-- TERCER TRAMA
		rst <= '1';						-- enable module -- opIn: Lectura de Memoria
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		wait for 2*40*clk_period;
		
		rst <= '1';						-- enable module -- inA
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		wait for 2*40*clk_period;
		
		rst <= '1';						-- enable module -- inB
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		
		wait for 5*12*40*clk_period;
		-- finaliza la simulacion



		----------------------------------------------
		-- CUARTA TRAMA
		rst <= '1';						-- enable module -- opIn: And bit a bit
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		wait for 2*40*clk_period;
		
		rst <= '1';						-- enable module -- inA
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		wait for 2*40*clk_period;
		
		rst <= '1';						-- enable module -- inB
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		
		wait for 5*12*40*clk_period;
		-- finaliza la simulacion
		
		----------------------------------------------
		-- QUINTA TRAMA
		rst <= '1';						-- enable module -- opIn: And bit a bit
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		wait for 2*40*clk_period;
		
		rst <= '1';						-- enable module -- inA
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		wait for 2*40*clk_period;
		
		rst <= '1';						-- enable module -- inB
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		
		wait for 5*12*40*clk_period;
		-- finaliza la simulacion
		
		
		----------------------------------------------
		-- SEXTA TRAMA
		rst <= '1';						-- enable module -- opIn: Incremento
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		wait for 2*40*clk_period;
		
		rst <= '1';						-- enable module -- inA
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		wait for 2*40*clk_period;
		
		rst <= '1';						-- enable module -- inB
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		
		wait for 5*12*40*clk_period;
		-- finaliza la simulacion
		
		
		----------------------------------------------
		-- SPTIMA TRAMA
		rst <= '1';						-- enable module -- opIn: Decremento
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		wait for 2*40*clk_period;
		
		rst <= '1';						-- enable module -- inA
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		wait for 2*40*clk_period;
		
		rst <= '1';						-- enable module -- inB
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop

		wait for 5*12*40*clk_period;
				-- finaliza la simulacion
		
		
		----------------------------------------------
		-- 0CTAVA TRAMA
		rst <= '1';						-- enable module -- opIn: Suma sin Overflow
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit stop
		wait for 2*40*clk_period;
		
		rst <= '1';						-- enable module -- inA
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		wait for 2*40*clk_period;
		
		rst <= '1';						-- enable module -- inB
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop

		wait for 5*12*40*clk_period;
				-- finaliza la simulacion

		----------------------------------------------
		-- NOVENA TRAMA
		rst <= '1';						-- enable module -- opIn: Suma con Overflow
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit stop
		wait for 2*40*clk_period;
		
		rst <= '1';						-- enable module -- inA
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		wait for 2*40*clk_period;
		
		rst <= '1';						-- enable module -- inB
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		
		wait for 5*12*40*clk_period;
		-- finaliza la simulacion


		----------------------------------------------
		-- DCIMA TRAMA
		rst <= '1';						-- enable module -- opIn: Resta sin Overflow
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit stop
		wait for 2*40*clk_period;
		
		rst <= '1';						-- enable module -- inA
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		wait for 2*40*clk_period;
		
		rst <= '1';						-- enable module -- inB
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		
		wait for 5*12*40*clk_period;
		-- finaliza la simulacion


		----------------------------------------------
		-- ONCEAVA TRAMA
		rst <= '1';						-- enable module -- opIn: Resta con Overflow
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit stop
		wait for 2*40*clk_period;
		
		rst <= '1';						-- enable module -- inA
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		wait for 2*40*clk_period;
		
		rst <= '1';						-- enable module -- inB
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		
		wait for 5*12*40*clk_period;
		-- finaliza la simulacion

		
		----------------------------------------------
		-- DOCEAVA TRAMA
		rst <= '1';						-- enable module -- opIn: Comando no implementado
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit stop
		wait for 2*40*clk_period;
		
		rst <= '1';						-- enable module -- inA
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		wait for 2*40*clk_period;
		
		rst <= '1';						-- enable module -- inB
		rx <= '1';					   -- rx en IDLE
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit start
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 7
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 6
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 5
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 4
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 3
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit 2
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 1
		wait for 40*clk_period;    -- tiempo bit
		rx <= '0';					   -- bit 0
		wait for 40*clk_period;    -- tiempo bit
		rx <= '1';					   -- bit stop
		
		wait for 5*12*40*clk_period;
		-- finaliza la simulacion


		assert false
		report "end"
		severity failure;

		wait;
		
	
   end process;

END;
