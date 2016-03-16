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

entity id_ex_register is
  generic (
    SIZE        : natural   := 32
  );
  port (
    clk      				    						  : in std_logic;
    rst      				    						  : in std_logic;
    write_en  					 						  : in std_logic;
    data_in_add_1_reg 								  : in std_logic_vector(SIZE-1 downto 0);
	 data_in_read_data_1_reg 						  : in std_logic_vector(SIZE-1 downto 0);
	 data_in_read_data_2_reg 						  : in std_logic_vector(SIZE-1 downto 0);
	 data_in_sign_extension_reg 					  : in std_logic_vector(SIZE-1 downto 0);
	 data_in_instr_20_downto_16_reg				  : in std_logic_vector(3 downto 0);
	 data_in_instr_15_downto_11_reg				  : in std_logic_vector(3 downto 0);
    data_out_add_1_reg 				  				  : out std_logic_vector(SIZE-1 downto 0);
	 data_out_read_data_1_reg 						  : out std_logic_vector(SIZE-1 downto 0);
	 data_out_read_data_2_reg 						  : out std_logic_vector(SIZE-1 downto 0);
	 data_out_sign_extension_reg 					  : out std_logic_vector(SIZE-1 downto 0);
	 data_out_instr_20_downto_16_reg				  : out std_logic_vector(3 downto 0);
	 data_out_instr_15_downto_11_reg				  : out std_logic_vector(3 downto 0)
  );
end id_ex_register;

architecture Behavioral of id_ex_register is 

component add_1_register is --not sure if this one is 32 bits
  generic (
    SIZE        : natural   := 32
  );
  port (
    clk       		    : in std_logic;
    rst       		    : in std_logic;
    write_en  		    : in std_logic;
    data_in    		 : in std_logic_vector(SIZE-1 downto 0);
    data_out   		 : out std_logic_vector(SIZE-1 downto 0)
  );

end component;

component read_data_1_register is
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

component sign_extension_register is
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

component instruction_20_downto_16_register is
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

component instruction_15_downto_11_register is
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

   Add_1 : add_1_register PORT MAP(	clk => clk,
												rst => rst,
												write_en => write_en,
												data_in => data_in_add_1_reg,
												data_out => data_out_add_1_reg);
										
   Read_data_1 : read_data_1_register PORT MAP(	clk => clk,
																rst => rst,
																write_en => write_en,
																data_in => data_in_read_data_1_reg,
																data_out => data_out_read_data_1_reg);
												
   Read_data_2 : read_data_2_register PORT MAP(	clk => clk,
																rst => rst,
																write_en => write_en,
																data_in => data_in_read_data_2_reg,
																data_out => data_out_read_data_2_reg);
												
   Sign_extender : sign_extention_register PORT MAP(	clk => clk,
																		rst => rst,
																		write_en => write_en,
																		data_in => data_in_sign_extension_reg,
																		data_out => data_out_sign_extension_reg);
												
   Inst_20_16 : instruction_20_downto_16_register PORT MAP(	clk => clk,
																				rst => rst,
																				write_en => write_en,
																				data_in => data_in_instr_20_downto_16_reg,
																				data_out => data_out_instr_20_downto_16_reg);
																
   Inst_15_11 : instruction_15_downto_11_register PORT MAP(	clk => clk,
																				rst => rst,
																				write_en => write_en,
																				data_in => data_in_instr_15_downto_11_reg,
																				data_out => data_out_instr_15_downto_11_reg);

  process (clk, rst)
  begin
    if rst = '1' then
		  data_out_add_1_reg <= (others => '0');
	     data_out_read_data_1_reg <= (others => '0'); 		
	     data_out_read_data_2_reg <= (others => '0');				
	     data_out_sign_extension_reg <= (others => '0');				
	     data_out_instr_20_downto_16_reg <= (others => '0');			
	     data_out_instr_15_downto_11_reg <= (others => '0');		
      
    elsif rising_edge(clk) then
      if write_en = '1' then
        data_out_add_1_reg <= data_in_add_1_reg;
	     data_out_read_data_1_reg <=  data_in_read_data_1_reg; 		
	     data_out_read_data_2_reg <= data_in_read_data_2_reg;				
	     data_out_sign_extension_reg <= data_in_sign_extension_reg;				
	     data_out_instr_20_downto_16_reg <= data_in_instr_20_downto_16_reg;			
	     data_out_instr_15_downto_11_reg <= data_in_instr_15_downto_11_reg;
      end if;
      
    end if;
  end process;
  
end Behavioral;

-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
