----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:20:06 01/21/2016 
-- Design Name: 
-- Module Name:    Bin_to_BCD - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Bin_to_BCD is
		Generic(NUMBITS : natural := 32);
    Port ( A : in  STD_LOGIC_VECTOR(NUMBITS-1 downto 0);
           SignalA : out  STD_LOGIC_VECTOR(NUMBITS-1 downto 0));
end Bin_to_BCD;

architecture Behavioral of Bin_to_BCD is

begin
	process(A)
		VARIABLE temp : INTEGER;
		VARIABLE hold : INTEGER;
		VARIABLE size : INTEGER;
		VARIABLE shift : INTEGER := 15;
	begin
		size := NUMBITS / 4;
		for I in 0 to size loop
			temp := A & (shift sll 4 * I);
			hold := temp * 10**I + hold;
		end loop;
	SignalA <= STD_LOGIC_VECTOR(TO_UNSIGNED(hold,SignalA'length));
	end process;


end Behavioral;

