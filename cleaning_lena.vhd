library ieee;
library work;
use ieee.std_logic_1164.all;
use work.custom_package.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

entity cleaning_lena is 
port(
	clk : in std_logic;
	rst : in std_logic;
	start : in std_logic;
--	read_addr: in std_logic_vector(7 downto 0);
--	write_addr: in std_logic_vector(7 downto 0);
	done: out std_logic
--	new_row : in std_logic_vector_array(0 to 255);
--	prev_row: out std_logic_vector_array(0 to 255);
--	curr_row: out std_logic_vector_array(0 to 255);
--	next_row: out std_logic_vector_array(0 to 255)	
--	outputs: out std_logic_vector_array(0 to 255) -- for test
--	outputs: out std_logic_vector_array(0 to 1279)-- for write to ram
--	rst: in std_logic; --not really needed
--	inputs: in std_logic_vector_array(0 to 8); --for median tb
--	outputs: out std_logic_vector_array(0 to 7); --for median tb
--	med: out std_logic_vector(4 downto 0) --for median tb
--	outputs: std_logic_vector_array(0 to 4) --for median tb
	);
end cleaning_lena;

architecture merge of cleaning_lena is 
--type buffer_type is array (0 to 2) of std_logic_vector_array(0 to 255);

component rom_256_1280 is
	GENERIC
	(
		init_rom_name	:	string
	);
	
	PORT
	(
		aclr		: IN STD_LOGIC  := '0';
		address		: IN STD_LOGIC_VECTOR (7 downTO 0);
		clock		: IN STD_LOGIC  := '1';
		q			: OUT STD_LOGIC_VECTOR (1279 downTO 0)
	);
end component;

component counter is
	
	
	PORT
	(
		clk 	: in std_logic;
		reset 	: in std_logic;
		enable	: in std_logic;
		count	: out std_logic_vector(0 to 7);
		done	: out std_logic
	);
end component;

component ram_256_1280 is
	GENERIC
	(
		inst_name	:	string
	);
	
	PORT
	(
		aclr		: IN STD_LOGIC  := '0';
		address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (1279 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q			: OUT STD_LOGIC_VECTOR (1279 DOWNTO 0)
	);
END component;


-- signals for red --

signal r_prev_s : std_logic_vector_array(0 to 255);
signal r_curr_s : std_logic_vector_array(0 to 255);
signal r_next_s : std_logic_vector_array(0 to 255);
signal r_rom_out_s: std_logic_vector(0 to 1279);
signal r_ram_in_s: std_logic_vector(0 to 1279);
signal r_outputs_s : std_logic_vector_array(0 to 255);

-- signals for green --

signal g_prev_s : std_logic_vector_array(0 to 255);
signal g_curr_s : std_logic_vector_array(0 to 255);
signal g_next_s : std_logic_vector_array(0 to 255);
signal g_rom_out_s: std_logic_vector(0 to 1279);
signal g_ram_in_s: std_logic_vector(0 to 1279);
signal g_outputs_s : std_logic_vector_array(0 to 255);

-- signals for blue --

signal b_prev_s : std_logic_vector_array(0 to 255);
signal b_curr_s : std_logic_vector_array(0 to 255);
signal b_next_s : std_logic_vector_array(0 to 255);
signal b_rom_out_s: std_logic_vector(0 to 1279);
signal b_ram_in_s: std_logic_vector(0 to 1279);
signal b_outputs_s : std_logic_vector_array(0 to 255);


-- general signals --
signal write_enable: std_logic := '1';
--signal read_addr_s: std_logic_vector(0 to 7);
--signal write_addr_s: std_logic_vector(0 to 7);
signal count_s: std_logic_vector(0 to 7);
signal ff_d1: std_logic_vector(0 to 7);
signal ff_d2: std_logic_vector(0 to 7);
signal ff_d3: std_logic_vector(0 to 7);
signal ff_d4: std_logic_vector(0 to 7);


BEGIN

	cnt: counter
		port map(
			clk 	=>	clk,
			reset 	=>	rst,
			enable	=>	start,
			count	=>	count_s,
			done	=>	done
				);
			
		

	romR: rom_256_1280
		generic map(init_rom_name => "C:\Users\Avi\Desktop\pro\r.mif")
		port map(
			clock	=>	clk,
			aclr 	=>	rst,
			address	=>	count_s,
			q		=>	r_rom_out_s
				);

				
	ramR: ram_256_1280
		generic map(inst_name => "rRAM")
		port map(
			aclr => rst,
			clock => clk,
			address => ff_d4,
			data => r_ram_in_s,
			wren => write_enable,
			q => open
				);

				
				
	romG: rom_256_1280
		generic map(init_rom_name => "C:\Users\Avi\Desktop\pro\g.mif")
		port map(
			clock	=>	clk,
			aclr 	=>	rst,
			address	=>	count_s,
			q		=>	g_rom_out_s
				);

				
	ramG: ram_256_1280
		generic map(inst_name => "gRAM")
		port map(
			aclr => rst,
			clock => clk,
			address => ff_d4,
			data => g_ram_in_s,
			wren => write_enable,
			q => open
				);

				
	romB: rom_256_1280
		generic map(init_rom_name => "C:\Users\Avi\Desktop\pro\b.mif")
		port map(
			clock	=>	clk,
			aclr 	=>	rst,
			address	=>	count_s,
			q		=>	b_rom_out_s
				);

				
	ramB: ram_256_1280
		generic map(inst_name => "bRAM")
		port map(
			aclr => rst,
			clock => clk,
			address => ff_d4,
			data => b_ram_in_s,
			wren => write_enable,
			q => open
				);
				
				
   r_proc: process(clk, rst) is
	begin
		if (rst='1') then
			r_prev_s<=(others=>"00000");
			r_curr_s<=(others=>"00000");
			r_next_s<=(others=>"00000");
		elsif (rising_edge(clk)) then
			r_prev_s<= cast_to_type(r_rom_out_s);
			r_curr_s<=r_prev_s;
			r_next_s<=r_curr_s;
			for i in 1 to 254 loop
				r_outputs_s(i) <= find_median(r_prev_s(i-1 to i+1) & r_curr_s(i-1 to i+1) & r_next_s(i-1 to i+1));
			end loop;
			r_ram_in_s <= type_to_cast(r_outputs_s);
		end if;
   end process;
	
	g_proc: process(clk, rst) is
	begin
		if (rst='1') then
			g_prev_s<=(others=>"00000");
			g_curr_s<=(others=>"00000");
			g_next_s<=(others=>"00000");
		elsif (rising_edge(clk)) then
			g_prev_s<= cast_to_type(g_rom_out_s);
			g_curr_s<=g_prev_s;
			g_next_s<=g_curr_s;
			for i in 1 to 254 loop
				g_outputs_s(i) <= find_median(g_prev_s(i-1 to i+1) & g_curr_s(i-1 to i+1) & g_next_s(i-1 to i+1));
			end loop;
			g_ram_in_s <= type_to_cast(g_outputs_s);
		end if;
   end process;
	
	b_proc: process(clk, rst) is
	begin
		if (rst='1') then
			b_prev_s<=(others=>"00000");
			b_curr_s<=(others=>"00000");
			b_next_s<=(others=>"00000");
		elsif (rising_edge(clk)) then
			b_prev_s<= cast_to_type(b_rom_out_s);
			b_curr_s<=b_prev_s;
			b_next_s<=b_curr_s;
			for i in 1 to 254 loop
				b_outputs_s(i) <= find_median(b_prev_s(i-1 to i+1) & b_curr_s(i-1 to i+1) & b_next_s(i-1 to i+1));
			end loop;
			b_ram_in_s <= type_to_cast(b_outputs_s);
		end if;
   end process;
   
   cnt_proc: process(clk, rst) is 
   begin	
		if (rst='1') then
			ff_d1<=(others=>'0'); 
			ff_d2<=(others=>'0'); 
			ff_d3<=(others=>'0'); 
			ff_d4<=(others=>'0'); 
		elsif (rising_edge(clk)) then
			ff_d1<=count_s;
			ff_d2<=ff_d1;
			ff_d3<=ff_d2;
			ff_d4<=ff_d3;
		end if;
	end process;

			
end merge;

