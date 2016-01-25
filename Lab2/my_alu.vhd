---------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:34:07 01/07/2016 
-- Design Name: 
-- Module Name:    my_alu - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity my_alu is
		Generic(NUMBITS : natural := 32);
    Port ( A : in  STD_LOGIC_VECTOR(NUMBITS-1 downto 0);
           B : in  STD_LOGIC_VECTOR(NUMBITS-1 downto 0);
           Opcode : in  STD_LOGIC_VECTOR(3 downto 0);
           Result : out  STD_LOGIC_VECTOR(NUMBITS+3 downto 0);
           Carry_out : out  STD_LOGIC;
           Overflow : out  STD_LOGIC;
           Zero : out  STD_LOGIC);
end my_alu;

architecture Behavioral of my_alu is

begin

	process(A, B, Opcode)
	begin
		case Opcode is
			--unsigned add
			when "1000" =>
				result <= A;
			--unsigned sub
			when "1001" =>
				result <= A;
			--signed add
			when "1100" =>
				result <= A;
			--signed sub
			when "1101" =>
				result <= A;
		end case;
	end process;

end Behavioral;

entity Bin_to_BCD is 
	