library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity CAM_Array is
	Generic (CAM_WIDTH : integer := 8 ;
				CAM_DEPTH : integer := 4 ) ;
	Port (  clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  we_decoded_row_address : in STD_LOGIC_VECTOR(CAM_DEPTH-1 downto 0) ;
           search_word : in  STD_LOGIC_VECTOR (CAM_WIDTH-1 downto 0);
           dont_care_mask : in  STD_LOGIC_VECTOR (CAM_WIDTH-1 downto 0);
           decoded_match_address : out  STD_LOGIC_VECTOR (CAM_DEPTH-1 downto 0));
end entity ;

architecture Behavioral of CAM_Row is


component BCAM_Cell is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           we : in  STD_LOGIC;
           cell_search_bit : in  STD_LOGIC;
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


Signal cell_match_bit_internal : STD_LOGIC_VECTOR(CAM_DEPTH downto 0);


begin
-- Connect the CAM cells here

	cell_match_bit_internal(0) <= '1';
	
	BCells: for N in 0 to CAM_DEPTH-1 generate
	myBCAM: BCAM_Cell port map(
		if N = 0 then
			clock => clock(N);
		end if;
		rst => rst(N);
		we => we_decoded_row_address(N);
		--cell_search_bit => cell_search_bit(N);
		cell_search_bit => search_word(N);
		cell_match_bit_in => cell_match_bit_internal(N);
		cell_match_bit_out => cell_match_bit_internal(N+1) );
		
	end generate;

	STCells: for N in 0 to CAM_DEPTH-1 generate
	mySTCAM: STCAM_Cell port map(
		if N = 0 then
			clock => clock(N);
		end if;
		rst => rst(N);
		we => we_decoded_row_address(N);
		cell_dont_care_bit => dont_care_mask(N);
		cell_search_bit => search_word(N);
		cell_match_bit_in => cell_match_bit_internal(N);
		cell_match_bit_out => cell_match_bit_internal(N+1) );
		
	end generate;
	
	TCells: for N in 0 to CAM_DEPTH-1 generate
	myTCAM: TCAM_Cell port map(
		if N = 0 then
			clock => clock(N);
		end if;
		rst => rst(N);
		we => we_decoded_row_address(N);
		cell_dont_care_bit => dont_care_mask(N);
		cell_search_bit => search_word(N);
		cell_match_bit_in => cell_match_bit_internal(N);
		cell_match_bit_out => cell_match_bit_internal(N+1) );
		
	end generate;

	decoded_match_address <= cell_match_bit_internal(CAM_DEPTH);
end Behavioral;