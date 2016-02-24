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
	 signal instr_memory_out : std_logic_vector(31 downto 0);
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
	 signal register_read_data_1 : std_logic_vector(31 downto 0);
	 signal register_read_data_2 : std_logic_vector(31 downto 0);
	 signal sign_extender_output : std_logic_vector(31 downto 0);
	 --signal alu_control_input : std_logic_vector(5 downto 0); might not need should be instr_memory_out(5 downto 0)
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

	Instruction_Memory : memory port map(clk 						=> clk,
													 rst 						=> rst,
													 instr_read_address 	=> instr_address,
													 instr_instruction 	=> instr_memory_out,
													 data_mem_write 		=> '0',
													 data_address 			=> (others => '0'),
													 data_write_data 		=> (others => '0'),
													 data_read_data 		=> open);
													 
	Add_1 : adder port map(pc_address => pc_signal_next,
								  output 	 => add_1_output);
	
	Mux_1 : mux_2_1_5 port map(select_in => control_output_RegDst,
										data_0_in => instr_memory_out(20 downto 16),
										data_1_in => instr_memory_out(15 downto 11),
										data_out  => mux_1_output);
	
	Cntrl_Unit : control_unit port map(instr_op   => instr_memory_out(31 downto 26),
												  reg_dst    => control_output_RegDst,
												  branch     => control_output_Branch,
												  mem_read   => control_output_MemRead,
												  mem_to_reg => control_output_MemToReg,
												  alu_op		 => control_output_ALUOp,
												  mem_write	 => control_output_MemWrite,
												  alu_src	 => control_output_ALUSrc,
												  reg_write	 => control_output_RegWrite);
													 
	Registers : cpu_registers port map(clk 				=> clk,
												  rst					=> rst,
												  reg_write			=> control_output_RegWrite,
												  read_register_1 => instr_memory_out(25 downto 21),
												  read_register_2 => instr_memory_out(20 downto 16),
												  write_register	=> mux_1_output,
												  write_data		=> mux_4_output,
												  read_data_1		=> register_read_data_1,
												  read_data_2		=> register_read_data_2);
												  
	Sign_Extend : sign_extender port map(input 	=> instr_memory_out(15 downto 0),
													 output  => sign_extender_output);
													 
	ALU_Cntrl : alu_control port map(alu_op 				=> control_output_ALUOp,
												instruction_5_0 	=> instr_memory_out(5 downto 0),
												alu_out 				=> alu_control_output);
												
	Mux_2 : mux_2_1_32 port map(select_in => control_output_ALUSrc,
										 data_1_in => sign_extender_output,
										 data_0_in => register_read_data_2,
										 data_out  => mux_2_output);
										 
	Shift_2 : shifter port map(input  => sign_extender_output,
										output => shift_left_output);
										
	Add_2 : alu port map(alu_control_in => "0010",
								channel_a_in	=> add_1_output,
								channel_b_in 	=> shift_left_output,
								zero_out 		=> open,
								alu_result_out	=> add_2_output);
								
	ALU_1 : alu port map(alu_control_in => alu_control_output,
								channel_a_in 	=> register_read_data_1,
								channel_b_in	=> mux_2_output,
								zero_out			=> alu_zero_output,
								alu_result_out => alu_result_output);
	
	Data_Memory : memory port map(clk => clk,
											rst => rst,
											instr_read_address => (others => '0'),
											instr_instruction  => open,
											data_mem_write 	 => control_output_MemWrite,
											data_address		 => alu_result_output(7 downto 0),
											data_write_data	 => register_read_data_2,
											data_read_data		 => data_memory_output);
											
	and_gate_output <= std_logic(control_output_Branch and alu_zero_output);
	
	Mux_3 : mux_2_1_32 port map(select_in => and_gate_output,
										 data_0_in => add_1_output,
										 data_1_in => add_2_output,
										 data_out  => mux_3_output);
	
	Mux_4 : mux_2_1_32 port map(select_in => control_output_MemToReg,
										 data_0_in => alu_result_output,
										 data_1_in => data_memory_output,
										 data_out  => mux_4_output);
end Behavioral;


