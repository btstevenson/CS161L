----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:56:17 03/15/2016 
-- Design Name: 
-- Module Name:    if_id_register - Behavioral 
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ex_mem_register is
  generic (
    SIZE        : natural   := 32
  );
  port (
    clk      				    				  : in std_logic;
    rst      				   				  : in std_logic;
    write_en  									  : in std_logic;
    data_in_add_2_reg 						  : in std_logic_vector(SIZE-1 downto 0);
	 data_in_alu_zero_reg 					  : in std_logic_vector(SIZE-1 downto 0);
	 data_in_alu_result_reg 				  : in std_logic_vector(SIZE-1 downto 0);
	 data_in_read_data_2_reg 				  : in std_logic_vector(SIZE-1 downto 0);
	 data_in_mux_1_reg						  : in std_logic_vector(3 downto 0);
    data_out_add_2_reg 						  : out std_logic_vector(SIZE-1 downto 0);
	 data_out_alu_zero_reg 					  : out std_logic_vector(SIZE-1 downto 0);
	 data_out_alu_result_reg 				  : out std_logic_vector(SIZE-1 downto 0);
	 data_out_read_data_2_reg 				  : out std_logic_vector(SIZE-1 downto 0);
	 data_out_mux_1_reg						  : out std_logic_vector(3 downto 0)
  );
end ex_mem_register;

architecture Behavioral of ex_mem_register is 

component add_2_register is --not sure if this one is 32 bits
  generic (
    SIZE        : natural   := 32
  );
  port (
    clk       		    : in std_logic;
    rst       		    : in std_logic;
    write_en  		    : in std_logic;
    data_in   		    : in std_logic_vector(SIZE-1 downto 0);
    data_out  			 : out std_logic_vector(SIZE-1 downto 0)
  );

end component;

component ALU_zero_register is
  generic (
    SIZE        : natural   := 32
  );
  port (
    clk         : in std_logic;
    rst         : in std_logic;
    write_en    : in std_logic;
    data_in     : in std_logic_vector(SIZE-1 downto 0);
    data_out    : out std_logic_vector(SIZE-1 downto 0)
  );
end component;

component ALU_result_register is
  generic (
    SIZE        : natural   := 32
  );
  port (
    clk         : in std_logic;
    rst         : in std_logic;
    write_en    : in std_logic;
    data_in     : in std_logic_vector(SIZE-1 downto 0);
    data_out    : out std_logic_vector(SIZE-1 downto 0)
  );
end component;

component read_data_2_register is
  generic (
    SIZE        : natural   := 32
  );
  port (
    clk         : in std_logic;
    rst         : in std_logic;
    write_en    : in std_logic;
    data_in     : in std_logic_vector(SIZE-1 downto 0);
    data_out    : out std_logic_vector(SIZE-1 downto 0)
  );
end component;

component mux_1_register is
  generic (
    SIZE        : natural   := 4
  );
  port (
    clk         : in std_logic;
    rst         : in std_logic;
    write_en    : in std_logic;
    data_in     : in std_logic_vector(SIZE-1 downto 0);
    data_out    : out std_logic_vector(SIZE-1 downto 0)
  );
end component;

begin

   Add_2 : add_2_register PORT MAP(	clk => clk,
												rst => rst,
												write_en => write_en,
												data_in => data_in_add_2_reg,
												data_out => data_out_add_2_reg);
										
   ALU_zero : ALU_zero_register PORT MAP(	clk => clk,
														rst => rst,
														write_en => write_en,
														data_in => data_in_alu_zero_register,
														data_out => data_out_alu_zero_register);
										
   ALU_result : ALU_result_register PORT MAP(	clk => clk,
																rst => rst,
																write_en => write_en,
																data_in => data_in_alu_result_register,
																data_out => data_out_alu_result_register);
									
												
   Read_data_2 : read_data_2_register PORT MAP(	clk => clk,
																rst => rst,
																write_en => write_en,
																data_in => data_in_read_data_2_reg,
																data_out => data_out_read_data_2_reg);
												
   Mux_1 : mux_1_register PORT MAP(	clk => clk,
												rst => rst,
												write_en => write_en,
												data_in => data_in_mux_1_reg,
												data_out => data_out_mux_1_reg);
												

  process (clk, rst)
  begin
    if rst = '1' then
        data_out_add_2_reg <= (others => '0');
	     data_out_alu_zero_reg <= (others => '0'); 			
	     data_out_alu_result_reg <= (others => '0');	
	     data_out_read_data_2_reg <= (others => '0');			
	     data_out_mux_1_reg <= (others => '0');				
      
    elsif rising_edge(clk) then
      if write_en = '1' then
        data_out_add_2_reg <= data_in_add_2_reg;
	     data_out_alu_zero_reg <=  data_in_alu_zero_reg; 	
	     data_out_alu_result_reg <= data_in_alu_result_reg;			  
	     data_out_read_data_2_reg <= data_in_read_data_2_reg;					
	     data_out_mux_1_reg <= data_in_mux_1_reg;			
      end if;
      
    end if;
  end process;
  
end Behavioral;

-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
