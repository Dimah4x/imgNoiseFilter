library ieee;
use ieee.std_logic_1164.all;
use work.custom_package.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


-- Test bench entity (no ports for a test bench)
entity median_tb is
end median_tb;

architecture behavior of median_tb is

    -- Component declaration for the merge sort module
    component cleaning_lena
        port(
            inputs : in  std_logic_vector_array(0 to 8); -- 9 numbers, 5 bits each
--            outputs : out std_logic_vector_array(0 to 7);
				med: out std_logic_vector(4 downto 0)
        );
    end component;

    -- Signals for interfacing with the merge sort component
    signal input_data   : std_logic_vector_array(0 to 8);
--    signal sorted_data  : std_logic_vector_array(0 to 7);
	signal med_s: std_logic_vector(4 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: cleaning_lena
        port map (
            inputs => input_data,
--            outputs => sorted_data,
				med => med_s
        );



    -- Stimulus process
    stim_proc: process
    begin


        -- Wait for the reset to propagate
        wait for 1 ns;
	
        -- You can define multiple input vectors and apply them sequentially
        -- For example, to test different sets of numbers

			input_data(0) <= std_logic_vector(to_unsigned(7, 5));
			input_data(1) <= std_logic_vector(to_unsigned(28, 5));
			input_data(2) <= std_logic_vector(to_unsigned(11, 5));
			input_data(3) <= std_logic_vector(to_unsigned(14, 5));
			input_data(4) <= std_logic_vector(to_unsigned(30, 5));
			input_data(5) <= std_logic_vector(to_unsigned(1, 5));
			input_data(6) <= std_logic_vector(to_unsigned(5, 5));
			input_data(7) <= std_logic_vector(to_unsigned(19, 5));
			input_data(8) <= std_logic_vector(to_unsigned(22, 5));

			wait for 1 ns;

			input_data(0) <= std_logic_vector(to_unsigned(10, 5));
			input_data(1) <= std_logic_vector(to_unsigned(16, 5));
			input_data(2) <= std_logic_vector(to_unsigned(27, 5));
			input_data(3) <= std_logic_vector(to_unsigned(20, 5));
			input_data(4) <= std_logic_vector(to_unsigned(23, 5));
			input_data(5) <= std_logic_vector(to_unsigned(31, 5));
			input_data(6) <= std_logic_vector(to_unsigned(1, 5));
			input_data(7) <= std_logic_vector(to_unsigned(10, 5));
			input_data(8) <= std_logic_vector(to_unsigned(22, 5));

			-- edge cases --
			--same val
			wait for 1 ns;

			input_data(0) <= std_logic_vector(to_unsigned(15, 5));
			input_data(1) <= std_logic_vector(to_unsigned(15, 5));
			input_data(2) <= std_logic_vector(to_unsigned(15, 5));
			input_data(3) <= std_logic_vector(to_unsigned(15, 5));
			input_data(4) <= std_logic_vector(to_unsigned(15, 5));
			input_data(5) <= std_logic_vector(to_unsigned(15, 5));
			input_data(6) <= std_logic_vector(to_unsigned(15, 5));
			input_data(7) <= std_logic_vector(to_unsigned(15, 5));
			input_data(8) <= std_logic_vector(to_unsigned(15, 5));

			wait for 1 ns;
			--ascending
			input_data(0) <= std_logic_vector(to_unsigned(0, 5));
			input_data(1) <= std_logic_vector(to_unsigned(1, 5));
			input_data(2) <= std_logic_vector(to_unsigned(2, 5));
			input_data(3) <= std_logic_vector(to_unsigned(3, 5));
			input_data(4) <= std_logic_vector(to_unsigned(4, 5));
			input_data(5) <= std_logic_vector(to_unsigned(5, 5));
			input_data(6) <= std_logic_vector(to_unsigned(6, 5));
			input_data(7) <= std_logic_vector(to_unsigned(7, 5));
			input_data(8) <= std_logic_vector(to_unsigned(8, 5));

			wait for 1 ns;
			--decending
			input_data(0) <= std_logic_vector(to_unsigned(8, 5));
			input_data(1) <= std_logic_vector(to_unsigned(7, 5));
			input_data(2) <= std_logic_vector(to_unsigned(6, 5));
			input_data(3) <= std_logic_vector(to_unsigned(5, 5));
			input_data(4) <= std_logic_vector(to_unsigned(4, 5));
			input_data(5) <= std_logic_vector(to_unsigned(3, 5));
			input_data(6) <= std_logic_vector(to_unsigned(2, 5));
			input_data(7) <= std_logic_vector(to_unsigned(1, 5));
			input_data(8) <= std_logic_vector(to_unsigned(0, 5));

			--single val not zero
			wait for 1 ns;
			
			input_data(0) <= std_logic_vector(to_unsigned(1, 5));
			input_data(1) <= std_logic_vector(to_unsigned(0, 5));
			input_data(2) <= std_logic_vector(to_unsigned(0, 5));
			input_data(3) <= std_logic_vector(to_unsigned(0, 5));
			input_data(4) <= std_logic_vector(to_unsigned(0, 5));
			input_data(5) <= std_logic_vector(to_unsigned(0, 5));
			input_data(6) <= std_logic_vector(to_unsigned(0, 5));
			input_data(7) <= std_logic_vector(to_unsigned(0, 5));
			input_data(8) <= std_logic_vector(to_unsigned(0, 5));


        -- Continue with other test vectors as needed
        -- Example: input_data <= "next_vector";

        wait; -- Wait indefinitely; simulation stops here
    end process;

end behavior;
