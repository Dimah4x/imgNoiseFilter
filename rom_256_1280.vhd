library ieee;
library work;
use ieee.std_logic_1164.all;
use work.custom_package.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY rom_256_1280 IS
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
END rom_256_1280;


ARCHITECTURE SYN OF rom_256_1280 IS

	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (1279 downTO 0);

BEGIN
	q    <= sub_wire0;

	altsyncram_component : altsyncram
	GENERIC MAP (
		address_aclr_a => "CLEAR0",
		clock_enable_input_a => "BYPASS",
		clock_enable_output_a => "BYPASS",
		init_file => init_rom_name,--"./x.mif",
		intended_device_family => "Cyclone IV E",
		lpm_hint => "ENABLE_RUNTIME_MOD=YES,INSTANCE_NAME=" & init_rom_name,
		lpm_type => "altsyncram",
		numwords_a => 256,
		operation_mode => "ROM",
		outdata_aclr_a => "CLEAR0",
		outdata_reg_a => "CLOCK0",
		widthad_a => 8,
		width_a => 1280,
		width_byteena_a => 1
	)
	PORT MAP (
		aclr0 => aclr,
		address_a => address,
		clock0 => clock,
		q_a => sub_wire0
	);



END SYN;

