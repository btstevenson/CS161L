--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:40:34 01/14/2016
-- Design Name:   
-- Module Name:   /home/csmajs/bstev002/Desktop/Files/ALU_LAB_1/my_alu_testbench.vhd
-- Project Name:  ALU_LAB_1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: my_alu
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY my_alu_testbench IS
END my_alu_testbench;
 
ARCHITECTURE behavior OF my_alu_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT my_alu
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         opcode : IN  std_logic_vector(2 downto 0);
         result : OUT  std_logic_vector(7 downto 0);
         carryout : OUT  std_logic;
         overflow : OUT  std_logic;
         zero : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');
   signal opcode : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal result : std_logic_vector(7 downto 0);
   signal carryout : std_logic;
   signal overflow : std_logic;
   signal zero : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
	signal clock : std_logic;
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: my_alu PORT MAP (
          A => A,
          B => B,
          opcode => opcode,
          result => result,
          carryout => carryout,
          overflow => overflow,
          zero => zero
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clock_period*10;

      -- insert stimulus here
			--test cases
			
			--unsigned add case 1
			A <= "10000010";
			B <= "10000010";
			opcode <= "000";
			wait for clock_period;
			Assert (result = "00000100")
				Report "result incorrect for unsigned add case1"
				Severity ERROR;
			Assert (carryout = '1')
				Report "Carryout for unsigned add not detected: case1"
				Severity ERROR;
			Assert (overflow = '1')
				Report "Overflow for unsigned add not detected: case1"
				Severity ERROR;
				
			--unsigned add case 2	
			A <= "00000000";
			B <= "00000000";
			opcode <= "000";
			wait for clock_period;
			Assert (carryout = '0')
				Report "Carryout for unsigned add detected: case2"
				Severity ERROR;
			Assert (overflow = '0')
				Report "Overflow for unsigned add detected: case2"
				Severity ERROR;
			Assert (zero = '1')
				Report "Zero for unsigned add not detected: case2"
				Severity ERROR;
				
			--unsigned add case 3
			A <= "00100100";
			B <= "01000100";
			opcode <= "000";
			wait for clock_period;
			Assert (result = "01101000")
				Report "result incorrect for unsigned add case3"
				Severity ERROR;
			Assert (carryout = '0')
				Report "Carryout for unsigned add detected: case3"
				Severity ERROR;
			Assert (overflow = '0')
				Report "Overflow for unsigned add detected: case3"
				Severity ERROR;
			Assert (zero = '0')
				Report "Zero for unsigned add detected: case3"
				Severity ERROR;
			
			--signed add case 1
			A <= "00000010";
			B <= "11111110";
			opcode <= "001";
			wait for clock_period;
			Assert (carryout = '1')
				Report "Carryout for signed add not detected: case1"
				Severity ERROR;
			Assert (zero = '1')
				Report "zero for signed add not detected: case1"
				Severity ERROR;
			Assert (overflow = '0')
				Report "overflow for signed add detected: case1"
				Severity ERROR;
			--signed add case 2
			A <= "10000001";
			B <= "10000001";
			opcode <= "001";
			wait for clock_period;
			Assert (carryout = '1')
				Report "Carryout for signed add not detected: case2"
				Severity ERROR;
			Assert (overflow = '1')
				Report "Overflow for signed add not detected: case2"
				Severity ERROR;
			Assert (zero = '0')
				Report "zero for signed add detected: case2"
				Severity ERROR;
			Assert (result = "00000010")
				Report "result is incorrect for signed add: case2"
				Severity ERROR;
			--signed add case 3
			A <= "11100011";
			B <= "01010101";
			opcode <= "001";
			wait for clock_period;
			Assert (carryout = '1')
				Report"Carryout for signed add not detected: case3"
				Severity ERROR;
				
			--unsigned sub case 1
			A <= "00000010";
			B <= "00000010";
			opcode <= "010";
			wait for clock_period;
			Assert (zero = '1')
				Report "zero for unsigned sub not detected: case1"
				Severity ERROR;
			Assert (carryout = '0')
				Report "Carryout for unsigned sub not detected: case1"
				Severity ERROR;
			
			--unsigned sub case 2
			A <= "01000000";
			B <= "10000000";
			opcode <= "010";
			wait for clock_period;
			Assert (overflow = '1')
				Report "Overflow for unsigned sub not detected: case2"
				Severity ERROR;
			Assert (carryout = '0')
				Report "Carryout for unsigned sub detected: case2"
				Severity ERROR;
			Assert (result = "11000000")
				Report "result is incorrect for unsigned sub: case2"
				Severity ERROR;
			--unsigned sub case 3
			A <= "10000000";
			B <= "11000000";
			opcode <= "010";
			wait for clock_period;
			Assert (overflow = '1')
				Report "Overflow for unsigned sub not detected: case3"
				Severity ERROR;
			Assert (carryout = '0')
				Report "Carryout for unsigned sub detected: case3"
				Severity ERROR;
			Assert (result = "11000000")
				Report "result is incorrect for unsigned sub: case3"
				Severity ERROR;
				
			--signed sub case 1
			A <= "11111111";
			B <= "00111111";
			opcode <= "011";
			wait for clock_period;
			Assert (result = "11000000")
				Report "result is incorrect for signed sub: case1"
				Severity ERROR;
			Assert (overflow = '0')
				Report "Overflow for signed sub detected: case1"
				Severity ERROR;
			
			--signed sub case 2
			A <= "10000001";
			B <= "01111111";
			opcode <= "011";
			wait for clock_period;
			Assert (result = "00000010")
				Report "result is incorrect for signed sub: case2"
				Severity ERROR;
			Assert (overflow = '1')
				Report "Overflow not detected for signed sub: case2"
				Severity ERROR;
			Assert (carryout = '0')
				Report "Carryout not detected for signed sub: case2"
				Severity ERROR;
				
			--signed sub case 3
			A <= "00000010";
			B <= "11111100";
			opcode <= "011";
			wait for clock_period;
			Assert (result = "00000110")
				Report "result is incorrect for signed sub: case3"
				Severity ERROR;
			Assert (carryout = '0')
				Report "Carryout detected for signed sub: case3"
				Severity ERROR;
			Assert (overflow = '0')
				Report "Overflow detected for signed sub: case3"
				Severity ERROR;
			
			--signed sub case 4
			A <= "00000010";
			B <= "00000010";
			opcode <= "011";
			wait for clock_period;
			Assert (result = "00000000")
				Report "result is incorrect for signed sub: case4"
				Severity ERROR;
			Assert (zero = '1')
				Report "zero not detected for signed sub: case4"
				Severity ERROR;
			Assert (carryout = '0')
				Report "carryout not detected for signed sub: case4"
				Severity ERROR;
			
			A <= "00000001";
			B <= "00000000";
			opcode <= "100";
			wait for clock_period;
			Assert (result = "00000000")
				Report "Logic AND case1 fail"
				Severity ERROR;
			
			A <= "00000001";
			B <= "00000001";
			opcode <= "100";
			wait for clock_period;
			Assert (result = "00000001")
				Report "Logic AND case2 fail"
				Severity ERROR;
			
			A <= "00001000";
			B <= "00001000";
			opcode <= "101";
			wait for clock_period;
			Assert (result = "00001000")
				Report "Logic OR case1 fail"
				Severity ERROR;
			
			A <= "00000001";
			B <= "00010001";
			opcode <= "101";
			wait for clock_period;
			Assert (result = "00010001")
				Report "Logic OR case2 fail"
				Severity ERROR;
				
			A <= "00000100";
			B <= "00000000";
			opcode <= "110";
			wait for clock_period;
			Assert (result = "00000100")
				Report "Logic XOR case1 fail"
				Severity ERROR;
			
			A <= "00100000";
			B <= "00100000";
			opcode <= "110";
			wait for clock_period;
			Assert (result = "00000000")
				Report "Logic XOR case2 fail"
				Severity ERROR;
			
			A <= "00001100";
			opcode <= "111";
			wait for clock_period;
			Assert (result = "00000110")
				Report "Divide by 2 case1 fail"
				Severity ERROR;
			
			A <= "00010001";
			opcode <= "111";
			wait for clock_period;
			Assert (result = "00001000")
				Report "Divide by 2 case2 fail"
				Severity ERROR;

      wait;
   end process;

END;