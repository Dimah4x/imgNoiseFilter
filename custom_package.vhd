library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package custom_package is 
	type std_logic_vector_array is array (natural range <>) of std_logic_vector(4 downto 0);
	function merger(arr1,arr2: in std_logic_vector_array) return std_logic_vector_array;
	function mergern(inputs: in std_logic_vector_array) return std_logic_vector_array;
	function find_median(inputs: in std_logic_vector_array) return std_logic_vector;
	function cast_to_type(inputs: in std_logic_vector) return std_logic_vector_array;
	function type_to_cast(inputs: in std_logic_vector_array) return std_logic_vector;
end package;

package body custom_package is

function merger(arr1,arr2: in std_logic_vector_array) return std_logic_vector_array is
variable result: std_logic_vector_array(0 to 7);
variable temp: std_logic_vector_array(0 to 7);
variable taken: std_logic_vector(0 to 7) := (others => '0');
variable i1, i2: integer := 0; -- Indexes for arr1 and arr2



begin

	temp(0 to 3) := arr1;
	temp(4 to 7) := arr2;
	
	-- Loop through each potential position in the merged array
    for i in 0 to 7 loop
        -- Ensure we don't go out of bounds for either array
        if i1 > 3 then -- If we've exhausted arr1
            result(i) := arr2(i2); -- Take the rest from arr2
            i2 := i2 + 1;
        elsif i2 > 3 then -- If we've exhausted arr2
            result(i) := arr1(i1); -- Take the rest from arr1
            i1 := i1 + 1;
        else
            -- Compare elements from arr1 and arr2, and take the smaller
            if arr1(i1) <= arr2(i2) then
                result(i) := arr1(i1); -- Take from arr1
                i1 := i1 + 1;
            else
                result(i) := arr2(i2); -- Take from arr2
                i2 := i2 + 1;
            end if;
        end if;
    end loop;	
	
	return result;
end function;


function mergern(inputs: in std_logic_vector_array) return std_logic_vector_array is
variable result: std_logic_vector_array(0 to 7);
variable templv1: std_logic_vector_array(0 to 7);
variable arr1: std_logic_vector_array(0 to 3);
variable arr2: std_logic_vector_array(0 to 3);
variable templv2: std_logic_vector_array(0 to 7);
variable i1, i2: integer := 0; -- Indexes for arr1 and arr2


begin

--	templv1 := inputs;
	
	
	for i in 0 to 3 loop
		if inputs(2*i) < inputs(2*i+1) then
			templv1(2*i) := inputs(2*i);
			templv1(2*i+1) := inputs(2*i+1);
		else
			templv1(2*i) := inputs(2*i+1);
			templv1(2*i+1) := inputs(2*i);
		end if;
	end loop;
	
	for i in 0 to 1 loop
		if templv1(4*i) < templv1(4*i+2) then
			templv2(4*i) := templv1(4*i);
			if templv1(4*i+1) < templv1(4*i+2) then
				templv2(4*i+1) := templv1(4*i+1);
				templv2(4*i+2) := templv1(4*i+2);
				templv2(4*i+3) := templv1(4*i+3);
			elsif templv1(4*i+1) < templv1(4*i+3) then
				templv2(4*i+1) := templv1(4*i+2);
				templv2(4*i+2) := templv1(4*i+1);
				templv2(4*i+3) := templv1(4*i+3);
			else
				templv2(4*i+1) := templv1(4*i+2);
				templv2(4*i+2) := templv1(4*i+3);
				templv2(4*i+3) := templv1(4*i+1);
			end if;
		else
			templv2(4*i) := templv1(4*i+2);
			if templv1(4*i) < templv1(4*i+3) then
				templv2(4*i+1) := templv1(4*i);
				templv2(4*i+2) := templv1(4*i+1);
				templv2(4*i+3) := templv1(4*i+3);
			elsif templv1(4*i+1) < templv1(4*i+3) then
				templv2(4*i+1) := templv1(4*i);
				templv2(4*i+2) := templv1(4*i+1);
				templv2(4*i+3) := templv1(4*i+3);
			else
				templv2(4*i+1) := templv1(4*i+3);
				templv2(4*i+2) := templv1(4*i);
				templv2(4*i+3) := templv1(4*i+1);
			end if;
		end if;
	end loop;
	
	arr1 := templv2(0 to 3);
	arr2 := templv2(4 to 7);
	
    for i in 0 to 7 loop
        -- Ensure we don't go out of bounds for either array
        if i1 > 3 then -- If we've exhausted arr1
            result(i) := arr2(i2); -- Take the rest from arr2
            i2 := i2 + 1;
        elsif i2 > 3 then -- If we've exhausted arr2
            result(i) := arr1(i1); -- Take the rest from arr1
            i1 := i1 + 1;
        else
            -- Compare elements from arr1 and arr2, and take the smaller
            if arr1(i1) <= arr2(i2) then
                result(i) := arr1(i1); -- Take from arr1
                i1 := i1 + 1;
            else
                result(i) := arr2(i2); -- Take from arr2
                i2 := i2 + 1;
            end if;
        end if;
    end loop;	
		

	return result;
end function;


function find_median(inputs: in std_logic_vector_array) return std_logic_vector is

variable temp_in: std_logic_vector_array(0 to 8);
variable temp_arr: std_logic_vector_array(0 to 7);
variable median_val: std_logic_vector(4 downto 0);

begin


	temp_in := inputs;
	temp_arr := mergern(temp_in(0 to 7));
	if inputs(8) < temp_arr(4) then
		median_val := temp_arr(4);
	elsif inputs(8) > temp_arr(5) then
		median_val := temp_arr(5);
	else
		median_val := inputs(8);
	end if;
	
	return median_val;
end function;

function cast_to_type(inputs: in std_logic_vector) return std_logic_vector_array is

Variable result: std_logic_vector_array(0 to 255);
	begin
	
	for i in 0 to 255 loop
		result(i) := inputs(5*i to 5*i+4);
	end loop;
	
	return result;
end function;

function type_to_cast(inputs: in std_logic_vector_array) return std_logic_vector is

Variable result: std_logic_vector(0 to 1279);
	begin
	
	for i in 0 to 255 loop
		result(5*i to 5*i+4) := inputs(i);
	end loop;
	
	return result;
end function;

end package body custom_package;

















