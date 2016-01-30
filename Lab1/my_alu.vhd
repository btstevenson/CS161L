----------------------------------------------------------------------------------
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
		Generic(NUMBITS : natural := 8);
    Port ( A : in  STD_LOGIC_VECTOR(NUMBITS-1 downto 0);
           B : in  STD_LOGIC_VECTOR(NUMBITS-1 downto 0);
           opcode : in  STD_LOGIC_VECTOR(2 downto 0);
           result : out  STD_LOGIC_VECTOR(NUMBITS-1 downto 0);
           carryout : out  STD_LOGIC;
           overflow : out  STD_LOGIC;
           zero : out  STD_LOGIC);
end my_alu;

architecture Behavioral of my_alu is

begin

	process(A, B, opcode)
		VARIABLE temp : STD_LOGIC_VECTOR(NUMBITS-1 downto 0);
		VARIABLE flowCheck : STD_LOGIC_VECTOR(NUMBITS downto 0);
	begin
		case opcode is
			--unsigned add
			when "000" =>
				result <= std_logic_vector(unsigned(A) + unsigned(B));
				flowCheck := std_logic_vector(unsigned('0' & A) + unsigned('0' & B));
				if (flowCheck(NUMBITS) = '1') then
					overflow <= '1';
				else
					overflow <= '0';
				end if;
				temp := std_logic_vector(unsigned(A) + unsigned(B));
				if (flowCheck(NUMBITS) = '1') then
					carryout <= '1';
				else
					carryout <= '0';
				end if;
			--signed add
			when "001" =>
				result <= std_logic_vector(signed(A) + signed(B));
				temp := std_logic_vector(signed(A) + signed(B));
				flowCheck := std_logic_vector(signed('0' & A) + signed('0' & B));
				if (A(NUMBITS-1) = '0' and B(NUMBITS-1) = '0') then
					if(TO_INTEGER(signed(temp)) < 0) then
						overflow <= '1';
					else
						overflow <= '0';
					end if;
				elsif (A(NUMBITS-1) = '1' and B(NUMBITS-1) = '1') then
					if(TO_INTEGER(signed(temp)) >= 0) then
						overflow <= '1';
					else
						overflow <= '0';
					end if;
				else
					overflow <= '0';
					if (flowCheck(NUMBITS) = '1') then
						carryout <= '1';
					else
						carryout <= '0';
					end if;
				end if;
			--unsigned sub
			when "010" =>
				result <= std_logic_vector(unsigned(A) + unsigned((not B) + 1));
				temp := std_logic_vector(unsigned(A) + unsigned((not B) + 1));
				flowCheck := std_logic_vector(unsigned('0' & A) + unsigned('0' &((not B) + 1)));
				if(flowCheck(NUMBITS) = '0') then
					overflow <= '1';
				else
					overflow <= '0';
				end if;
				carryout <= '0';
			--signed sub
			when "011" =>
				result <= std_logic_vector(signed(A) + signed((not B) + 1));
				temp := std_logic_vector(signed(A) + signed((not B) + 1));
				flowCheck := std_logic_vector(signed('0' & A) + signed('0' & ((not B) + 1)));
				if(A(NUMBITS-1) = '0' and B(NUMBITS-1) = '1') then
					if(TO_INTEGER(signed(temp)) < 0) then
						overflow <= '1';
					else
						overflow <= '0';
					end if;
				elsif(A(NUMBITS-1) = '1' and B(NUMBITS-1) = '0') then
					if(TO_INTEGER(signed(temp)) >= 0) then
						overflow <= '1';
					else
						overflow <= '0';
					end if;
				else
					overflow <= '0';
					if (flowCheck(NUMBITS) = '1') then
						carryout <= '0';
					else
						carryout <= '1';
					end if;
				end if;
			when "100" =>
				result <= A and B;
				temp := A and B;
				flowCheck := std_logic_vector(('0' & A) and ('0' & B));
				if (flowCheck(NUMBITS) = '1') then
					carryout <= '1';
				else
					carryout <= '0';
				end if;
			when "101" =>
				result <= A or B;
				temp := A or B;
				flowCheck := std_logic_vector(('0' & A) or ('0' & B));
				if (flowCheck(NUMBITS) = '1') then
					carryout <= '1';
				else
					carryout <= '0';
				end if;
			when "110" =>
				result <= A xor B;
				temp := A xor B;
				flowCheck := std_logic_vector(('0' & A) xor ('0' & B));
				if (flowCheck(NUMBITS) = '1') then
					carryout <= '1';
				else
					carryout <= '0';
				end if;
			when "111" =>
				result <= '0' & A(NUMBITS-1 downto 1);
				temp := '0' & A(NUMBITS-1 downto 1);
				flowCheck := std_logic_vector('0' & ('0' & A(NUMBITS-1 downto 1)));
				if (flowCheck(NUMBITS) = '1') then
					carryout <= '1';
				else
					carryout <= '0';
				end if;
			when OTHERS =>
				result <= A;
		end case;
		if (TO_INTEGER(signed(temp)) = 0) then
			zero <= '1';
		else
			zero <= '0';
		end if;
	
	end process;

end Behavioral;
