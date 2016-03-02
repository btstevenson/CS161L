--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:46:50 03/01/2016
-- Design Name:   
-- Module Name:   D:/Xlinx/14.6/ISE_DS/lab6/CAM_Wrapper_tb.vhd
-- Project Name:  lab6
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CAM_Wrapper
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
 
ENTITY CAM_Wrapper_tb IS
END CAM_Wrapper_tb;
 
ARCHITECTURE behavior OF CAM_Wrapper_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CAM_Wrapper
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         we_decoded_row_address : IN  std_logic_vector(7 downto 0);
         search_word : IN  std_logic_vector(7 downto 0);
         dont_care_mask : IN  std_logic_vector(7 downto 0);
         decoded_match_address : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal we_decoded_row_address : std_logic_vector(7 downto 0) := (others => '0');
   signal search_word : std_logic_vector(7 downto 0) := (others => '0');
   signal dont_care_mask : std_logic_vector(7 downto 0) := (others => '0');
	signal R : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal decoded_match_address : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CAM_Wrapper PORT MAP (
          clk => clk,
          rst => rst,
          we_decoded_row_address => we_decoded_row_address,
          search_word => search_word,
          dont_care_mask => dont_care_mask,
          decoded_match_address => decoded_match_address
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
   begin		
		rst <= '1';
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		--CELL_CHOICE := 0;
		we_decoded_row_address <= "00000001";
		search_word <= "10101010";
		dont_care_mask <= "00000000";
		R <= "00000001";
		ASSERT decoded_match_address = R report "Test case failed: " severity Warning;
	 
		rst <= '0';
      wait for clk_period*10;
		

      wait;
   end process;

END;
