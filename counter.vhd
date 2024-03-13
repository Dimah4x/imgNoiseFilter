library ieee;
library work;
use ieee.std_logic_1164.all;
use work.custom_package.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity counter is
	port (
		clk 	: in std_logic;
		reset 	: in std_logic;
		enable	: in std_logic;
		count	: out std_logic_vector(0 to 7);
		done	: out std_logic
	);
	end entity counter;
	
architecture behavioral of counter is
	begin
		process (clk, reset)
		variable count_num : std_logic_vector(0 to 7);
		begin
			if reset = '1' then 
				count_num := (others => '0');
			elsif rising_edge(clk) then
				if enable = '1' then
					if count_num = "11111111" then
						done <= '1';
						count_num := (others => '0');
						
							else
							count_num := count_num + 1;
					end if;
				end if;
			end if;					
				count <= count_num;
		end process;
	end architecture;				
		