library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity generic_register is
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
end generic_register;

architecture Behavioral of generic_register is

begin

  process (clk, rst)
  begin
    if rst = '1' then
      data_out <= (others => '0');
      
    elsif rising_edge(clk) then
      if write_en = '1' then
        data_out <= data_in;
      end if;
      
    end if;
  end process;
  
end Behavioral;

-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2_1_5 is
  generic(
    SIZE           : natural   := 5
  );
  port (
    select_in      : in std_logic;
    data_0_in      : in std_logic_vector(SIZE-1 downto 0);
    data_1_in      : in std_logic_vector(SIZE-1 downto 0);
    data_out       : out std_logic_vector(SIZE-1 downto 0)
  );
end mux_2_1_5;

architecture Behavioral of mux_2_1_5 is

begin

  process (select_in, data_0_in, data_1_in)
  begin
    case select_in is
      when '0'    =>    data_out <= data_0_in;
      when '1'    =>    data_out <= data_1_in;
      when others =>    data_out <= (others => '0');
    end case;
  end process;

end Behavioral;

-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_2_1_32 is
  generic(
    SIZE           : natural   := 32
  );
  port (
    select_in      : in std_logic;
    data_0_in      : in std_logic_vector(SIZE-1 downto 0);
    data_1_in      : in std_logic_vector(SIZE-1 downto 0);
    data_out       : out std_logic_vector(SIZE-1 downto 0)
  );
end mux_2_1_32;

architecture Behavioral of mux_2_1_32 is

begin

  process (select_in, data_0_in, data_1_in)
  begin
    case select_in is
      when '0'    =>    data_out <= data_0_in;
      when '1'    =>    data_out <= data_1_in;
      when others =>    data_out <= (others => '0');
    end case;
  end process;

end Behavioral;

-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity cpu_registers is
  port (
	 clk					 : in std_logic;
    rst               : in std_logic;
    reg_write         : in std_logic;
    read_register_1   : in std_logic_vector(4 downto 0);
    read_register_2   : in std_logic_vector(4 downto 0);
    write_register    : in std_logic_vector(4 downto 0);
    write_data        : in std_logic_vector(31 downto 0);
    read_data_1       : out std_logic_vector(31 downto 0);
    read_data_2       : out std_logic_vector(31 downto 0)
    );
end cpu_registers;

architecture Behavioral of cpu_registers is
  type REG_BUFF is array(0 to 31) of std_logic_vector(31 downto 0);
  signal registers   : REG_BUFF;

begin

  process (rst, read_register_1, read_register_2)
  begin
    if rst = '1' then
      read_data_1 <= (others => '0');
      read_data_2 <= (others => '0');
    else
      read_data_1 <= registers(conv_integer(read_register_1));
      read_data_2 <= registers(conv_integer(read_register_2));
    end if;
    
  end process;
  
  process (rst, clk)
  begin
    if rst = '1' then
      for i in 31 downto 0 loop
        registers(i) <= (others => '0');
      end loop;
    elsif rising_edge(clk) then
      if reg_write = '1' then
        registers(conv_integer(write_register)) <= write_data;
      end if;
    end if;
    
  end process;

end Behavioral;

-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
--use work.cpu_constant_library.all;

entity alu is
  port (
    alu_control_in : in std_logic_vector(3 downto 0);
    channel_a_in   : in std_logic_vector(31 downto 0);
    channel_b_in   : in std_logic_vector(31 downto 0);
    zero_out       : out std_logic;
    alu_result_out : out std_logic_vector(31 downto 0)
    );
end alu;

architecture Behavioral of alu is
  signal result_s   : std_logic_vector(31 downto 0);

begin

  process (alu_control_in, channel_a_in, channel_b_in)
  begin
    case alu_control_in is
      --AND
      when "0000"          => result_s <= channel_a_in and channel_b_in;
      --OR
      when "0001"          => result_s <= channel_a_in or channel_b_in;
      --ADD
      when "0010"          => result_s <= channel_a_in + channel_b_in;
      --SUB
      when "0110"          => result_s <= channel_a_in - channel_b_in;
      --SLT
      when "0111"          => if channel_a_in < channel_b_in then
                                 result_s <= (others => '1');
                              else
                                 result_s <= (others => '0');
                              end if;
      --NOR
      when "1100"          => result_s <= channel_a_in nor channel_b_in;
      when others          => result_s <= (others => '0');
    end case;
  end process;

  alu_result_out <= result_s;
  zero_out <= '1' when result_s = 0 else '0';

end Behavioral;

-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----
-- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity memory is
  generic (
    COE_FILE_NAME        : string   := "init2.coe"
    );
  port (
	 clk						 : in std_logic;
    rst                  : in std_logic;
    instr_read_address   : in std_logic_vector(7 downto 0);
    instr_instruction    : out std_logic_vector(31 downto 0);
    data_mem_write       : in std_logic;
    data_address         : in std_logic_vector(7 downto 0);
    data_write_data      : in std_logic_vector(31 downto 0);
    data_read_data       : out std_logic_vector(31 downto 0)
    );
end memory;

architecture Behavioral of memory is
  type MEMORY_BUFFER is array(255 downto 0) of std_logic_vector(31 downto 0);
  signal buff      : MEMORY_BUFFER;
  
begin

  process (rst, clk, instr_read_address, data_mem_write, data_address, data_write_data, buff)
    file     coe_file  :   text;
    variable coe_line  :   line;
    variable coe_str   :   bit_vector(31 downto 0);
    variable coe_status:   file_open_status;
  begin
    if rst = '1' then
      
      file_open(coe_status, coe_file, COE_FILE_NAME, read_mode);
      
      if coe_status = OPEN_OK then
        for i in 0 to 255 loop
          if not endfile(coe_file) then
            readline(coe_file, coe_line);
            read(coe_line, coe_str);
            buff(i) <= to_StdLogicVector(coe_str);
          else
            buff(i) <= (others => '0');
          end if;
        end loop;
        file_close(coe_file);
      else
        report "Could not open COE file" severity warning;
        for i in 0 to 255 loop
          buff(i) <= (others => '0');
        end loop;
        
      end if;
      
      instr_instruction <= (others => '0');
      data_read_data      <= (others => '0');
    else
		if rising_edge(clk) and data_mem_write = '1' then
				buff(conv_integer(data_address)) <= data_write_data;
		end if;
		
      instr_instruction <= buff(conv_integer(instr_read_address));
      data_read_data <= buff(conv_integer(data_address));
    end if;
  end process;


end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use work.cpu_constant_library.all;

entity alu_control is
  port (
    alu_op            : in std_logic_vector(1 downto 0);
    instruction_5_0   : in std_logic_vector(5 downto 0);
    alu_out           : out std_logic_vector(3 downto 0)
    );
end alu_control;

architecture Behavioral of alu_control is

begin
	process (alu_op, instruction_5_0)
	begin
		case alu_op is
			-- I-type sw, lw, addi, subi
			when "00" =>
				alu_out <= "0010";
			-- I-type beq
			when "01" =>
				alu_out <= "0110";
			-- R-type
			when "10" =>
					case instruction_5_0 is
						-- add
						when "100000" =>
							alu_out <= "0010";
						-- addu
						when "100001" =>
							alu_out <= "0010";
						-- sub
						when "100010" =>
							alu_out <= "0110";
						-- and
						when "100100" =>
							alu_out <= "0000";
						-- or
						when "100101" =>
							alu_out <= "0001";
						-- slt
						when "101010" =>
							alu_out <= "0111";
						-- nor && not
						when "100111" =>
							alu_out <= "1100";
						when OTHERS =>
					end case;
			when OTHERS =>
		end case;
	end process;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity control_unit is
  port (
    instr_op          : in std_logic_vector(5 downto 0);
    reg_dst           : out std_logic;
    branch            : out std_logic;
    mem_read          : out std_logic;
    mem_to_reg        : out std_logic;
    alu_op            : out std_logic_vector(1 downto 0);
    mem_write         : out std_logic;
    alu_src           : out std_logic;
    reg_write         : out std_logic
    );
end control_unit;

architecture Behavioral of control_unit is

begin
  process (instr_op)
	VARIABLE rformat : std_logic;
	VARIABLE lw : std_logic;
	VARIABLE sw : std_logic;
	VARIABLE beq : std_logic;
	VARIABLE flag : std_logic;
	begin
		case instr_op is
			-- r-format
			when "000000" =>
				rformat := '1';
				lw := '0';
				sw := '0';
				beq := '0';
				flag := '0';
			-- lw
			when "100011" =>
				rformat := '0';
				lw := '1';
				sw := '0';
				beq := '0';
				flag := '0';
			-- sw
			when "101011" =>
				rformat := '0';
				lw := '0';
				sw := '1';
				beq := '0';
				flag := '0';
			-- beq
			when "000100" =>
				rformat := '0';
				lw := '0';
				sw := '0';
				beq := '1';
				flag := '0';
			-- addi and subi
			when "001000" =>
				reg_dst 		<= '0';
				mem_to_reg 	<= '0';
				mem_read		<= '0';
				mem_write	<= '0';
				branch		<= '0';
				alu_op 		<= "00";
				alu_src 		<= '1';
				reg_write	<= '1';
				flag := '1';
			when OTHERS =>
				rformat := '0';
				lw := '0';
				sw := '0';
				beq := '0';
		end case;
		if (flag = '0') then
			if (lw = '1' or sw = '1') then
				alu_src <= '1';
			else
				alu_src <= '0';
			end if;
			if (rformat = '1' or lw = '1') then
				reg_write <= '1';
			else
				reg_write <= '0';
			end if;
			reg_dst <= rformat;
			mem_to_reg <= lw;
			mem_read <= lw;
			mem_write <= sw;
			branch <= beq;
			alu_op(1) <= rformat;
			alu_op(0) <= beq;
		end if;
  end process;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity adder is
	port(
		pc_address : in std_logic_vector (31 downto 0);
		output : out std_logic_vector (31 downto 0)
		);
end adder;

architecture Behavioral of adder is
begin
	process(pc_address)
		variable temp : std_logic_vector(31 downto 0);
	begin
			temp := (others => '0');
			temp := pc_address(31 downto 0) + "0100";
			output <= temp;
	end process;
end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sign_extender is
	port(
		input		: in std_logic_vector(15 downto 0);
		output   : out std_logic_vector(31 downto 0)
		);
end sign_extender;

architecture Behavorial of sign_extender is
begin
	process(input)
		variable temp : std_logic_vector(31 downto 0);
	begin
		temp := (others => '0');
		temp := std_logic_vector(resize(signed(input), temp'length));
		output <= temp;
	end process;
end Behavorial;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity shifter is
	port(
		input  : in std_logic_vector(31 downto 0);
		output : out std_logic_vector(31 downto 0)
		);
end shifter;

architecture Behavorial of shifter is
begin
	process(input)
		variable temp : std_logic_vector(31 downto 0);
	begin
		temp := (others => '0');
		temp := input;
		temp := temp(29 downto 0) & '0' & '0';
		output <= temp;
	end process;
end Behavorial;

