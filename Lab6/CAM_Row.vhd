library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity CAM_Row is
	Generic (CAM_WIDTH : integer := 8) ;
	Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           we : in  STD_LOGIC;
           search_word : in  STD_LOGIC_VECTOR (CAM_WIDTH-1 downto 0);
           dont_care_mask : in  STD_LOGIC_VECTOR (CAM_WIDTH-1 downto 0);
           row_match : out  STD_LOGIC);
end CAM_Row;

architecture Behavioral of CAM_Row is


component BCAM_Cell is 
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           we : in  STD_LOGIC;
           cell_search_bit : in  STD_LOGIC;
			  cell_dont_care_bit : in  STD_LOGIC;
			  cell_match_bit_in : in  STD_LOGIC ;
           cell_match_bit_out : out  STD_LOGIC);
end component ;

component STCAM_Cell is 
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           we : in  STD_LOGIC;
           cell_search_bit : in  STD_LOGIC;
           cell_dont_care_bit : in  STD_LOGIC;
			  cell_match_bit_in : in  STD_LOGIC ;
           cell_match_bit_out : out  STD_LOGIC);
end component ;

component TCAM_Cell is 
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           we : in  STD_LOGIC;
           cell_search_bit : in  STD_LOGIC;
           cell_dont_care_bit : in  STD_LOGIC;
			  cell_match_bit_in : in  STD_LOGIC ;
           cell_match_bit_out : out  STD_LOGIC);
end component ;

Signal cell_match_bit_internal : STD_LOGIC_VECTOR(CAM_WIDTH downto 0);


begin
-- Connect the CAM cells here

	cell_match_bit_internal(0) <= '1';
	
	BCells: for N in 0 to CAM_WIDTH-1 generate
		first_gen : if N = 0 generate
			B0: BCAM_Cell port map(
				clk => clk,
				rst => rst,
				we  => we,
				cell_search_bit => search_word(N),
				cell_dont_care_bit => '0',
				cell_match_bit_in => cell_match_bit_internal(N),
				cell_match_bit_out => cell_match_bit_internal(N+1)
			);
		end generate first_gen;
		rest_gen : if N > 0 generate
			B1: BCAM_Cell port map(
				clk => '0',
				rst => rst,
				we => we,
				cell_search_bit => search_word(N),
				cell_dont_care_bit => '0',
				cell_match_bit_in => cell_match_bit_internal(N),
				cell_match_bit_out => cell_match_bit_internal(N+1)
			);
		end generate rest_gen;
	end generate BCells;


	STCells: for N in 0 to CAM_WIDTH-1 generate
		first_gen: if N = 0 generate
			ST0 : STCAM_Cell port map(
				clk => clk,
				rst => rst,
				we => we,
				cell_dont_care_bit => dont_care_mask(N),
				cell_search_bit => search_word(N),
				cell_match_bit_in => cell_match_bit_internal(N),
				cell_match_bit_out => cell_match_bit_internal(N+1)
			);
		end generate first_gen;
		rest_gen : if N > 0 generate
			ST1 : STCAM_Cell port map(
				clk => '0',
				rst => rst,
				we => we,
				cell_dont_care_bit => dont_care_mask(N),
				cell_search_bit => search_word(N),
				cell_match_bit_in => cell_match_bit_internal(N),
				cell_match_bit_out => cell_match_bit_internal(N+1)
			);
		end generate rest_gen;
	end generate STCells;
	
	TCells: for N in 0 to CAM_WIDTH-1 generate
		first_gen : if N = 0 generate
			T0 : TCAM_Cell port map(
				clk => clk,
				rst => rst,
				we => we,
				cell_dont_care_bit => dont_care_mask(N),
				cell_search_bit => search_word(N),
				cell_match_bit_in => cell_match_bit_internal(N),
				cell_match_bit_out => cell_match_bit_internal(N+1)
			);
		end generate first_gen;
		rest_gen : if N > 0 generate
			T1 : TCAM_Cell port map(
				clk => '0',
				rst => rst,
				we => we,
				cell_dont_care_bit => dont_care_mask(N),
				cell_search_bit => search_word(N),
				cell_match_bit_in => cell_match_bit_internal(N),
				cell_match_bit_out => cell_match_bit_internal(N+1)
			);
		end generate rest_gen;
	end generate TCells;

	row_match <= cell_match_bit_internal(CAM_WIDTH);
	
end Behavioral;