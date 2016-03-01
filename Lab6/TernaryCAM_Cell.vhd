library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity TCAM_Cell is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           we : in  STD_LOGIC;
           cell_search_bit : in  STD_LOGIC;
           cell_dont_care_bit : in  STD_LOGIC;
   	   cell_match_bit_in : in  STD_LOGIC ;
           cell_match_bit_out : out  STD_LOGIC);
end TCAM_Cell;

architecture Behavioral of TCAM_Cell is

begin
	
	process(we,clk,cell_match_bit_in)
		variable store_search_bit : STD_LOGIC;
		variable if_match : STD_LOGIC;
		begin
			
		if we = '1' then
			store_search_bit := cell_search_bit;
		end if;
		
		if cell_search_bit = store_search_bit then
			if_match := '1';
		else 
			if_match := '0';
		end if;
		--matching logic
		if cell_dont_care_bit = '1' then
			cell_match_bit_out <= cell_match_bit_in;
			
		elsif if_match = cell_match_bit_in then
			cell_match_bit_out <= '1';
		else
			cell_match_bit_out <= '0';
		end if;
	end process;


end Behavioral ;