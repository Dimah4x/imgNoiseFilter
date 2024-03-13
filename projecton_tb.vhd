library ieee;
library work;
use ieee.std_logic_1164.all;
use work.custom_package.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


-----------------------------------------------------------------

ENTITY projecton_tb IS

END ENTITY projecton_tb;


-----------------------------------------------------------------

ARCHITECTURE projecton_tb_arc OF projecton_tb IS
		
	COMPONENT cleaning_lena
    port (
		start	: in std_logic;
		clk : in std_logic;
		rst : in std_logic;
		done : out std_logic
	);
	END COMPONENT;
	
		signal start	: std_logic;
		signal clk : std_logic:='0';
		signal rst : std_logic;
		signal done : std_logic;
	
	BEGIN
	
		tester: cleaning_lena
		PORT MAP(

        start => start,
        clk => clk,
        rst => rst,
        done => done
		);
		
		
		
     	clock1: PROCESS 
      	BEGIN
			   WAIT FOR 5 ns; clk <= not clk;
      	END PROCESS clock1;
		
		stimulus: PROCESS
		BEGIN
			rst <= '1';
			start <= '0';
			wait for 50 ns;
			rst <= '0';
			wait for 50 ns;
			start <='1';
			wait until done='1';
			start <= '0';
			report "finish";
			wait;
			
			
		END PROCESS stimulus;
			
		
	
END ARCHITECTURE projecton_tb_arc; 
 		
		


 