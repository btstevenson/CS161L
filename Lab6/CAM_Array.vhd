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

architecture Behavioral of CAM_Array is

	component CAM_Row is
		Generic (CAM_WIDTH : integer := 8);
		Port (
			clk : in  STD_LOGIC;
         rst : in  STD_LOGIC;
         we : in  STD_LOGIC;
         search_word : in  STD_LOGIC_VECTOR (CAM_WIDTH-1 downto 0);
         dont_care_mask : in  STD_LOGIC_VECTOR (CAM_WIDTH-1 downto 0);
         row_match : out  STD_LOGIC
		);	
	end component;



Signal cell_match_bit_internal : STD_LOGIC_VECTOR(CAM_DEPTH downto 0);


begin
-- Connect the CAM Row cells here

	--RowCells : for N in 0 to CAM_DEPTH-1 generate
		--Rows : CAM_Row generic map(CAM_WIDTH => CAM_WIDTH) port map (
			--clk => clk,
			--rst => rst,
			--we => we_decoded_row_address(N),
			--search_word => search_word,
			--dont_care_mask => dont_care_mask,
			--row_match => decoded_match_address(N)
		--);
	--end generate;

end Behavioral;