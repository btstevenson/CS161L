--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:08:02 02/23/2016
-- Design Name:   
-- Module Name:   E:/School/UCR/CS161/Labs/Lab5/MIPS_Datapath/datapath_test_bench.vhd
-- Project Name:  MIPS_Datapath
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cs161_processor
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
 
ENTITY datapath_test_bench IS
END datapath_test_bench;
 
ARCHITECTURE behavior OF datapath_test_bench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cs161_processor
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         prog_count : OUT  std_logic_vector(31 downto 0);
         instr_opcode : OUT  std_logic_vector(5 downto 0);
         reg1_addr : OUT  std_logic_vector(4 downto 0);
         reg1_data : OUT  std_logic_vector(31 downto 0);
         reg2_addr : OUT  std_logic_vector(4 downto 0);
         reg2_data : OUT  std_logic_vector(31 downto 0);
         write_reg_addr : OUT  std_logic_vector(4 downto 0);
         write_reg_data : OUT  std_logic_vector(31 downto 0)
			--add1_output_debug : out std_logic_vector(31 downto 0);
			--shift2_debug : out std_logic_vector(31 downto 0);
			--add2_debug : out std_logic_vector(31 downto 0);
			--mux3_debug : out std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal prog_count : std_logic_vector(31 downto 0);
   signal instr_opcode : std_logic_vector(5 downto 0);
   signal reg1_addr : std_logic_vector(4 downto 0);
   signal reg1_data : std_logic_vector(31 downto 0);
   signal reg2_addr : std_logic_vector(4 downto 0);
   signal reg2_data : std_logic_vector(31 downto 0);
   signal write_reg_addr : std_logic_vector(4 downto 0);
   signal write_reg_data : std_logic_vector(31 downto 0);
	--signal add1_output_debug : std_logic_vector(31 downto 0);
	--signal shift2_debug : std_logic_vector(31 downto 0);
	--signal add2_debug : std_logic_vector(31 downto 0);
	--signal mux3_debug : std_logic_vector(31 downto 0);

   -- Clock period definitions
	--signal clock : std_logic;
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cs161_processor PORT MAP (
          clk => clk,
          rst => rst,
          prog_count => prog_count,
          instr_opcode => instr_opcode,
          reg1_addr => reg1_addr,
          reg1_data => reg1_data,
          reg2_addr => reg2_addr,
          reg2_data => reg2_data,
          write_reg_addr => write_reg_addr,
          write_reg_data => write_reg_data
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
		variable flag : boolean;
   begin
		rst <= '1';
		--while flag loop
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		rst <= '0';
		
      wait for clk_period*10;
		wait for 100 ns;
      -- insert stimulus here 
      wait;
		--end loop;
   end process;

END;
