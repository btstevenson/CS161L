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

entity if_id_register is
  generic (
    SIZE        : natural   := 32
  );
  port (
    clk      				    		 	  : in std_logic;
    rst      				     			  : in std_logic;
    write_en  					  			  : in std_logic;
    data_in_add_1_reg 				  	  : in std_logic_vector(SIZE-1 downto 0);
	 data_in_inst_mem_reg  				  : in std_logic_vector(SIZE-1 downto 0);
    data_out_add_1_reg   		    	  : out std_logic_vector(SIZE-1 downto 0);
	 data_out_inst_mem_reg    			  : out std_logic_vector(SIZE-1 downto 0)
  );
end if_id_register;

architecture Behavioral of if_id_register is 

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

component instruction_memory_register is
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

begin

  Add_1 : add_1_register PORT MAP(	clk => clk,
												rst => rst,
												write_en => write_en,
												data_in => data_in_add_1_reg,
												data_out => data_out_add_1_reg);
					
  Inst_Mem : instruction_memory_register PORT MAP(		clk => clk,
																		rst => rst,
																		write_en => write_en,
																		data_in => data_in_inst_mem_reg,
																		data_out => data_out_inst_mem_reg);

  process (clk, rst)
  begin
    if rst = '1' then
      data_out_add_1_reg <= (others => '0');
		data_out_inst_mem_reg <= (others => '0');
      
    elsif rising_edge(clk) then
      if write_en = '1' then
        data_out_add_1_reg <= data_in_add_1_reg;
		  data_out_inst_mem_reg <= data_in_inst_mem_reg;
      end if;
      
    end if;
  end process;
  
end Behavioral;

-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
