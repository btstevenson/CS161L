----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:36:10 02/18/2016 
-- Design Name: 
-- Module Name:    cs161_processor - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use work.cpu_component_library.all;

entity cs161_processor is
  port (
    clk            : in std_logic;
    rst            : in std_logic;
    
    -- Debug Signals
    prog_count     : out std_logic_vector(31 downto 0);
    instr_opcode   : out std_logic_vector(5 downto 0);
    reg1_addr      : out std_logic_vector(4 downto 0);
    reg1_data      : out std_logic_vector(31 downto 0);
    reg2_addr      : out std_logic_vector(4 downto 0);
    reg2_data      : out std_logic_vector(31 downto 0);
    write_reg_addr : out std_logic_vector(4 downto 0);
    write_reg_data : out std_logic_vector(31 downto 0)
    );
end cs161_processor;

architecture Behavioral of cs161_processor is

    signal pc_signal_next : std_logic_vector(31 downto 0) := (others => '0') ;
	 signal pc_signal_prev : std_logic_vector(31 downto 0) := (others => '0') ;
	 signal instr_address : std_logic_vector(7 downto 0);
	 signal instruction_memory_out : std_logic_vector(31 downto 0);
	 signal control_input : std_logic_vector(5 downto 0);
	 signal register_input_1 : std_logic_vector(4 downto 0);
	 signal register_input_2 : std_logic_vector(4 downto 0);
	 signal mux_1_input : std_logic_vector(4 downto 0);
	 signal sign_extend_input : std_logic_vector(15 downto 0);
	 signal mux_1_output : std_logic_vector(4 downto 0);
	 signal control_output_RegDst : std_logic;
	 signal control_output_Branch : std_logic;
	 signal control_output_MemRead : std_logic;
	 signal control_output_MemtoReg : std_logic;
	 signal control_output_ALUOp : std_logic_vector(1 downto 0);
	 signal control_output_MemWrite : std_logic;
	 signal control_output_ALUSrc : std_logic;
	 signal control_output_RegWrite : std_logic;
	 signal resigter_read_data_1 : std_logic_vector(31 downto 0);
	 signal resigter_read_data_2 : std_logic_vector(31 downto 0);
	 signal sign_extender_output : std_logic_vector(31 downto 0);
	 signal alu_control_input : std_logic_vector(5 downto 0);
	 signal add_1_output : std_logic_vector(31 downto 0);
	 signal shift_left_output : std_logic_vector(31 downto 0);
	 signal mux_2_output : std_logic_vector(31 downto 0);
	 signal alu_control_output : std_logic_vector(3 downto 0);
	 signal add_2_output : std_logic_vector(31 downto 0);
	 signal and_gate_output : std_logic;
	 signal alu_zero_output : std_logic;
	 signal alu_result_output : std_logic_vector(31 downto 0);
	 signal data_memory_output : std_logic_vector(31 downto 0);
	 signal mux_3_output : std_logic_vector(31 downto 0);
	 signal mux_4_output : std_logic_vector(31 downto 0);
	 
	 
	 
begin

	instr_address <= pc_signal_next ( 9 downto 2 );

	Instruction_Memory : memory port map(clk => clk,
													 rst => rst,
													 instr_read_address => instr_address,
													 instr_instruction => instruction_memory_out,
													 data_mem_write => '0',
													 data_address => (others => '0'),
													 data_write_data => (others => '0'),
													 data_read_data => open);

end Behavioral;


