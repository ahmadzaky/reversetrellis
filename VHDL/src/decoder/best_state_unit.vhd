library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.viterbi_package.all;

entity best_state_unit is
    port(
        reset	 	   : in std_logic;
		clock    	   : in std_logic;
		total_v  	   : in std_logic;
        total_000_o    : in pe_data;
        total_001_o    : in pe_data;
        total_010_o    : in pe_data;
        total_011_o    : in pe_data;
        total_100_o    : in pe_data;
        total_101_o    : in pe_data;
        total_110_o    : in pe_data;
        total_111_o    : in pe_data;
		min_path	   : out std_logic_vector(5 downto 0);
		min_path_v	   : out std_logic
        );
    end entity;
    
architecture rtl of best_state_unit is
    signal cost_min_000 :pe_data;
    signal cost_min_001 :pe_data;
    signal cost_min_010 :pe_data;
    signal cost_min_011 :pe_data;
    signal cost_min_100 :pe_data;
    signal cost_min_101 :pe_data;
    signal cost_min_110 :pe_data;
    signal cost_min_111 :pe_data;
    signal cost_min_idx :pe_data;
    signal pe_min_000 :sort_data;
    signal pe_min_001 :sort_data;
    signal pe_min_010 :sort_data;
    signal pe_min_011 :sort_data;
    signal pe_min_100 :sort_data;
    signal pe_min_101 :sort_data;
    signal pe_min_110 :sort_data;
    signal pe_min_111 :sort_data;
    signal pe_min_idx :sort_data;
    signal pe_min_id  :sort_data;
    signal state : statetype;
    signal next_state : statetype;
	
begin
	
	-- process(clock, reset)
	-- begin
		-- if reset = '1' then
		    -- min_path_v <= '0';
		-- elsif clock'event and clock = '0' then
			-- if state = s10 then
				-- min_path_v <= '1';
			-- else
				-- min_path_v <= '0';
			-- end if;
		-- end if;
	-- end  process;
	
	process(reset, clock)
	begin
	if reset = '1' then
		state <= s0;
	elsif clock'event and clock = '0' then
		if total_v = '1' then
			state <= s3;
		else
			state <= next_state;
		end if;
	end if;
	end process;
	
	
	process(reset, clock)
	begin
	if reset = '1' then
		cost_min_000 <= no_pe_data;
		cost_min_001 <= no_pe_data;
		cost_min_010 <= no_pe_data;
		cost_min_011 <= no_pe_data;
		cost_min_100 <= no_pe_data;
		cost_min_101 <= no_pe_data;
		cost_min_110 <= no_pe_data;
		cost_min_111 <= no_pe_data;
		cost_min_idx <= no_pe_data;
		next_state	 <= s0;
			min_path_v <= '0';
	elsif clock'event and clock = '1' then	
		if state = s0 then
			min_path_v <= '0';
		elsif state = s3 then
			if total_000_o(0) < total_000_o(1) then
				pe_min_000(0) <= "000";
				cost_min_000(0) <= total_000_o(0);
			else
				pe_min_000(0) <= "001";
				cost_min_000(0) <= total_000_o(1);
			end if;
			if total_000_o(2) < total_000_o(3) then
				pe_min_000(1) <= "010";
				cost_min_000(1) <= total_000_o(2);
			else
				pe_min_000(1) <= "011";
				cost_min_000(1) <= total_000_o(3);
			end if;
			if total_000_o(4) < total_000_o(5) then
				pe_min_000(2) <= "100";
				cost_min_000(2) <= total_000_o(4);
			else
				pe_min_000(2) <= "101";
				cost_min_000(2) <= total_000_o(5);
			end if;
			if total_000_o(6) < total_000_o(7) then
				pe_min_000(3) <= "110";
				cost_min_000(3) <= total_000_o(6);
			else
				pe_min_000(3) <= "111";
				cost_min_000(3) <= total_000_o(7);
			end if;
	----	------------------------------------------------	
			if total_001_o(0) < total_001_o(1) then
				pe_min_001(0) <= "000";
				cost_min_001(0) <= total_001_o(0);
			else
				pe_min_001(0) <= "001";
				cost_min_001(0) <= total_001_o(1);
			end if;
			if total_001_o(2) < total_001_o(3) then
				pe_min_001(1) <= "010";
				cost_min_001(1) <= total_001_o(2);
			else
				pe_min_001(1) <= "011";
				cost_min_001(1) <= total_001_o(3);
			end if;
			if total_001_o(4) < total_001_o(5) then
				pe_min_001(2) <= "100";
				cost_min_001(2) <= total_001_o(4);
			else
				pe_min_001(2) <= "101";
				cost_min_001(2) <= total_001_o(5);
			end if;
			if total_001_o(6) < total_001_o(7) then
				pe_min_001(3) <= "110";
				cost_min_001(3) <= total_001_o(6);
			else
				pe_min_001(3) <= "111";
				cost_min_001(3) <= total_001_o(7);
			end if;
	----	-------------------------------------------------	
			if total_010_o(0) < total_010_o(1) then
				pe_min_010(0) <= "000";
				cost_min_010(0) <= total_010_o(0);
			else
				pe_min_010(0) <= "001";
				cost_min_010(0) <= total_010_o(1);
			end if;
			if total_010_o(2) < total_010_o(3) then
				pe_min_010(1) <= "010";
				cost_min_010(1) <= total_010_o(2);
			else
				pe_min_010(1) <= "011";
				cost_min_010(1) <= total_010_o(3);
			end if;
			if total_010_o(4) < total_010_o(5) then
				pe_min_010(2) <= "100";
				cost_min_010(2) <= total_010_o(4);
			else
				pe_min_010(2) <= "101";
				cost_min_010(2) <= total_010_o(5);
			end if;
			if total_010_o(6) < total_010_o(7) then
				pe_min_010(3) <= "110";
				cost_min_010(3) <= total_010_o(6);
			else
				pe_min_010(3) <= "111";
				cost_min_010(3) <= total_010_o(7);
			end if;
	----	-------------------------------------------------	
			if total_011_o(0) < total_011_o(1) then
				pe_min_011(0) <= "000";
				cost_min_011(0) <= total_011_o(0);
			else
				pe_min_011(0) <= "001";
				cost_min_011(0) <= total_011_o(1);
			end if;
			if total_011_o(2) < total_011_o(3) then
				pe_min_011(1) <= "010";
				cost_min_011(1) <= total_011_o(2);
			else
				pe_min_011(1) <= "011";
				cost_min_011(1) <= total_011_o(3);
			end if;
			if total_011_o(4) < total_011_o(5) then
				pe_min_011(2) <= "100";
				cost_min_011(2) <= total_011_o(4);
			else
				pe_min_011(2) <= "101";
				cost_min_011(2) <= total_011_o(5);
			end if;
			if total_011_o(6) < total_011_o(7) then
				pe_min_011(3) <= "110";
				cost_min_011(3) <= total_011_o(6);
			else
				pe_min_011(3) <= "111";
				cost_min_011(3) <= total_011_o(7);
			end if;
	----	-----------------------------------------------	
			if total_100_o(0) < total_100_o(1) then
				pe_min_100(0) <= "000";
				cost_min_100(0) <= total_100_o(0);
			else
				pe_min_100(0) <= "001";
				cost_min_100(0) <= total_100_o(1);
			end if;
			if total_100_o(2) < total_100_o(3) then
				pe_min_100(1) <= "010";
				cost_min_100(1) <= total_100_o(2);
			else
				pe_min_100(1) <= "011";
				cost_min_100(1) <= total_100_o(3);
			end if;
			if total_100_o(4) < total_100_o(5) then
				pe_min_100(2) <= "100";
				cost_min_100(2) <= total_100_o(4);
			else
				pe_min_100(2) <= "101";
				cost_min_100(2) <= total_100_o(5);
			end if;
			if total_100_o(6) < total_100_o(7) then
				pe_min_100(3) <= "110";
				cost_min_100(3) <= total_100_o(6);
			else
				pe_min_100(3) <= "111";
				cost_min_100(3) <= total_100_o(7);
			end if;
	----	-----------------------------------------------		
			if total_101_o(0) < total_101_o(1) then
				pe_min_101(0) <= "000";
				cost_min_101(0) <= total_101_o(0);
			else
				pe_min_101(0) <= "001";
				cost_min_101(0) <= total_101_o(1);
			end if;
			if total_101_o(2) < total_101_o(3) then
				pe_min_101(1) <= "010";
				cost_min_101(1) <= total_101_o(2);
			else
				pe_min_101(1) <= "011";
				cost_min_101(1) <= total_101_o(3);
			end if;
			if total_101_o(4) < total_101_o(5) then
				pe_min_101(2) <= "100";
				cost_min_101(2) <= total_101_o(4);
			else
				pe_min_101(2) <= "101";
				cost_min_101(2) <= total_101_o(5);
			end if;
			if total_101_o(6) < total_101_o(7) then
				pe_min_101(3) <= "110";
				cost_min_101(3) <= total_101_o(6);
			else
				pe_min_101(3) <= "111";
				cost_min_101(3) <= total_101_o(7);
			end if;	
	----	-----------------------------------------------		
			if total_110_o(0) < total_110_o(1) then
				pe_min_110(0) <= "000";
				cost_min_110(0) <= total_110_o(0);
			else
				pe_min_110(0) <= "001";
				cost_min_110(0) <= total_110_o(1);
			end if;
			if total_110_o(2) < total_110_o(3) then
				pe_min_110(1) <= "010";
				cost_min_110(1) <= total_110_o(2);
			else
				pe_min_110(1) <= "011";
				cost_min_110(1) <= total_110_o(3);
			end if;
			if total_110_o(4) < total_110_o(5) then
				pe_min_110(2) <= "100";
				cost_min_110(2) <= total_110_o(4);
			else
				pe_min_110(2) <= "101";
				cost_min_110(2) <= total_110_o(5);
			end if;
			if total_110_o(6) < total_110_o(7) then
				pe_min_110(3) <= "110";
				cost_min_110(3) <= total_110_o(6);
			else
				pe_min_110(3) <= "111";
				cost_min_110(3) <= total_110_o(7);
			end if;
	----	-----------------------------------------------			
			if total_111_o(0) < total_111_o(1) then
				pe_min_111(0) <= "000";
				cost_min_111(0) <= total_111_o(0);
			else
				pe_min_111(0) <= "001";
				cost_min_111(0) <= total_111_o(1);
			end if;
			if total_111_o(2) < total_111_o(3) then
				pe_min_111(1) <= "010";
				cost_min_111(1) <= total_111_o(2);
			else
				pe_min_111(1) <= "011";
				cost_min_111(1) <= total_111_o(3);
			end if;
			if total_111_o(4) < total_111_o(5) then
				pe_min_111(2) <= "100";
				cost_min_111(2) <= total_111_o(4);
			else
				pe_min_111(2) <= "101";
				cost_min_111(2) <= total_111_o(5);
			end if;
			if total_111_o(6) < total_111_o(7) then
				pe_min_111(3) <= "110";
				cost_min_111(3) <= total_111_o(6);
			else
				pe_min_111(3) <= "111";
				cost_min_111(3) <= total_111_o(7);
			end if;
	-------------------------------------------------------				
			next_state <= s4;
		elsif state = s4 then
			if cost_min_000(0) < cost_min_000(1) then
				pe_min_000(4) <= pe_min_000(0);
				cost_min_000(4) <= cost_min_000(0);
			else
				pe_min_000(4) <= pe_min_000(1);
				cost_min_000(4) <= cost_min_000(1);
			end if;
			if cost_min_000(2) < cost_min_000(3) then
				pe_min_000(5) <= pe_min_000(2);
				cost_min_000(5) <= cost_min_000(2);
			else
				pe_min_000(5) <= pe_min_000(3);
				cost_min_000(5) <= cost_min_000(3);
			end if;
	----	------------------------------------------------
			if pe_min_001(0) < pe_min_001(1) then
				pe_min_001(4) <= pe_min_001(0);
				cost_min_001(4) <= cost_min_001(0);
			else
				pe_min_001(4) <= pe_min_001(1);
				cost_min_001(4) <= cost_min_001(1);
			end if;
			if pe_min_001(2) < pe_min_001(3) then
				pe_min_001(5) <= pe_min_001(2);
				cost_min_001(5) <= cost_min_001(2);
			else
				pe_min_001(5) <= pe_min_001(3);
				cost_min_001(5) <= cost_min_001(3);
			end if;
	----	------------------------------------------------
			if cost_min_010(0) < cost_min_010(1) then
				pe_min_010(4) <= pe_min_010(0);
				cost_min_010(4) <= cost_min_010(0);
			else
				pe_min_010(4) <= pe_min_010(1);
				cost_min_010(4) <= cost_min_010(1);
			end if;
			if cost_min_010(2) < cost_min_010(3) then
				pe_min_010(5) <= pe_min_010(2);
				cost_min_010(5) <= cost_min_010(2);
			else
				pe_min_010(5) <= pe_min_010(3);
				cost_min_010(5) <= cost_min_010(3);
			end if;
	----	------------------------------------------------
			if cost_min_011(0) < cost_min_011(1) then
				pe_min_011(4) <= pe_min_011(0);
				cost_min_011(4) <= cost_min_011(0);
			else
				pe_min_011(4) <= pe_min_011(1);
				cost_min_011(4) <= cost_min_011(1);
			end if;
			if cost_min_011(2) < cost_min_011(3) then
				pe_min_011(5) <= pe_min_011(2);
				cost_min_011(5) <= cost_min_011(2);
			else
				pe_min_011(5) <= pe_min_011(3);
				cost_min_011(5) <= cost_min_011(3);
			end if;
	----	------------------------------------------------
			if cost_min_100(0) < cost_min_100(1) then
				pe_min_100(4) <= pe_min_100(0);
				cost_min_100(4) <= cost_min_100(0);
			else
				pe_min_100(4) <= pe_min_100(1);
				cost_min_100(4) <= cost_min_100(1);
			end if;
			if cost_min_100(2) < cost_min_100(3) then
				pe_min_100(5) <= pe_min_100(2);
				cost_min_100(5) <= cost_min_100(2);
			else
				pe_min_100(5) <= pe_min_100(3);
				cost_min_100(5) <= cost_min_100(3);
			end if;
	----	------------------------------------------------
			if cost_min_101(0) < cost_min_101(1) then
				pe_min_101(4) <= pe_min_101(0);
				cost_min_101(4) <= cost_min_101(0);
			else
				pe_min_101(4) <= pe_min_101(1);
				cost_min_101(4) <= cost_min_101(1);
			end if;
			if cost_min_101(2) < cost_min_101(3) then
				pe_min_101(5) <= pe_min_101(2);
				cost_min_101(5) <= cost_min_101(2);
			else
				pe_min_101(5) <= pe_min_101(3);
				cost_min_101(5) <= cost_min_101(3);
			end if;
	----	------------------------------------------------
			if cost_min_110(0) < cost_min_110(1) then
				pe_min_110(4) <= pe_min_110(0);
				cost_min_110(4) <= cost_min_110(0);
			else
				pe_min_110(4) <= pe_min_110(1);
				cost_min_110(4) <= cost_min_110(1);
			end if;
			if cost_min_110(2) < cost_min_110(3) then
				pe_min_110(5) <= pe_min_110(2);
				cost_min_110(5) <= cost_min_110(2);
			else
				pe_min_110(5) <= pe_min_110(3);
				cost_min_110(5) <= cost_min_110(3);
			end if;
	----	------------------------------------------------
			if cost_min_111(0) < cost_min_111(1) then
				pe_min_111(4) <= pe_min_111(0);
				cost_min_111(4) <= cost_min_111(0);
			else
				pe_min_111(4) <= pe_min_111(1);
				cost_min_111(4) <= cost_min_111(1);
			end if;
			if cost_min_111(2) < cost_min_111(3) then
				pe_min_111(5) <= pe_min_111(2);
				cost_min_111(5) <= cost_min_111(2);
			else
				pe_min_111(5) <= pe_min_111(3);
				cost_min_111(5) <= cost_min_111(3);
			end if;
	----	--------------------------------------------------
			next_state <= s5;
		elsif state = s5 then
			if cost_min_000(4) < cost_min_000(5) then
				pe_min_000(6) <= pe_min_000(4);
				cost_min_000(6) <= cost_min_000(4);
			else
				pe_min_000(6) <= pe_min_000(5);
				cost_min_000(6) <= cost_min_000(5);
			end if;
			
			if cost_min_001(4) < cost_min_001(5) then
				pe_min_001(6) <= pe_min_001(4);
				cost_min_001(6) <= cost_min_001(4);
			else
				pe_min_001(6) <= pe_min_001(5);
				cost_min_001(6) <= cost_min_001(5);
			end if;
			
			if cost_min_010(4) < cost_min_010(5) then
				pe_min_010(6) <= pe_min_010(4);
				cost_min_010(6) <= cost_min_010(4);
			else
				pe_min_010(6) <= pe_min_010(5);
				cost_min_010(6) <= cost_min_010(5);
			end if;
			
			if cost_min_011(4) < cost_min_011(5) then
				pe_min_011(6) <= pe_min_011(4);
				cost_min_011(6) <= cost_min_011(4);
			else
				pe_min_011(6) <= pe_min_011(5);
				cost_min_011(6) <= cost_min_011(5);
			end if;
			
			if cost_min_100(4) < cost_min_100(5) then
				pe_min_100(6) <= pe_min_100(4);
				cost_min_100(6) <= cost_min_100(4);
			else
				pe_min_100(6) <= pe_min_100(5);
				cost_min_100(6) <= cost_min_100(5);
			end if;
			
			if cost_min_101(4) < cost_min_101(5) then
				pe_min_101(6) <= pe_min_101(4);
				cost_min_101(6) <= cost_min_101(4);
			else
				pe_min_101(6) <= pe_min_101(5);
				cost_min_101(6) <= cost_min_101(5);
			end if;
			
			if cost_min_110(4) < cost_min_110(5) then
				pe_min_110(6) <= pe_min_110(4);
				cost_min_110(6) <= cost_min_110(4);
			else
				pe_min_110(6) <= pe_min_110(5);
				cost_min_110(6) <= cost_min_110(5);
			end if;
			
			if cost_min_111(4) < cost_min_111(5) then
				pe_min_111(6) <= pe_min_111(4);
				cost_min_111(6) <= cost_min_111(4);
			else
				pe_min_111(6) <= pe_min_111(5);
				cost_min_111(6) <= cost_min_111(5);
			end if;
			next_state <= s6;
		elsif state = s6 then
		
			if cost_min_000(6) < cost_min_001(6) then
				pe_min_idx(0) <= "000";
				pe_min_id(0)  <= pe_min_000(6);
				cost_min_idx(0) <= cost_min_000(6);
			else
				pe_min_idx(0) <= "001";
				pe_min_id(0)  <= pe_min_001(6);
				cost_min_idx(0) <= cost_min_001(6);
			end if;
			
			if cost_min_010(6) < cost_min_011(6) then
				pe_min_idx(1) <= "010";
				pe_min_id(1)  <= pe_min_010(6);
				cost_min_idx(1) <= cost_min_010(6);
			else
				pe_min_idx(1) <= "011";
				pe_min_id(1)  <= pe_min_011(6);
				cost_min_idx(1) <= cost_min_011(6);
			end if;
			
			if cost_min_100(6) < cost_min_101(6) then
				pe_min_idx(2) <= "100";
				pe_min_id(2)  <= pe_min_100(6);
				cost_min_idx(2) <= cost_min_100(6);
			else
				pe_min_idx(2) <= "101";
				pe_min_id(2)  <= pe_min_101(6);
				cost_min_idx(2) <= cost_min_101(6);
			end if;
			
			if cost_min_110(6) < cost_min_111(6) then
				pe_min_idx(3) <= "110";
				pe_min_id(3)  <= pe_min_110(6);
				cost_min_idx(3) <= cost_min_110(6);
			else
				pe_min_idx(3) <= "111";
				pe_min_id(3)  <= pe_min_111(6);
				cost_min_idx(3) <= cost_min_111(6);
			end if;
			next_state <= s7;
		elsif state = s7 then
			if cost_min_idx(0) < cost_min_idx(1) then
				pe_min_idx(4) <= pe_min_idx(0);
				pe_min_id(4)  <= pe_min_id(0);
				cost_min_idx(4) <= cost_min_idx(0);
			else
				pe_min_idx(4) <= pe_min_idx(1);
				pe_min_id(4)  <= pe_min_id(1);
				cost_min_idx(4) <= cost_min_idx(1);
			end if;
			
			if cost_min_idx(2) < cost_min_idx(3) then
				pe_min_idx(5) <= pe_min_idx(2);
				pe_min_id(5)  <= pe_min_id(2);
				cost_min_idx(5) <= cost_min_idx(2);
			else
				pe_min_idx(5) <= pe_min_idx(3);
				pe_min_id(5)  <= pe_min_id(3);
				cost_min_idx(5) <= cost_min_idx(3);
			end if;
			next_state <= s8;
		elsif state = s8 then
			if cost_min_idx(4) < cost_min_idx(5) then
				pe_min_idx(6) <= pe_min_idx(4);
				pe_min_id(6)  <= pe_min_id(4);
				cost_min_idx(6) <= cost_min_idx(4);
			else
				pe_min_idx(6) <= pe_min_idx(5);
				pe_min_id(6)  <= pe_min_id(5);
				cost_min_idx(6) <= cost_min_idx(5);
			end if;
			next_state <= s9;
		elsif state = s9 then
			min_path(5 downto 3) <= pe_min_idx(6);
			min_path(2 downto 0) <= pe_min_id(6);
			next_state <= s10;
		elsif state = s10 then
			min_path_v <= '1';
			next_state <= s0;
		end if;
	end if;
	end process;
end rtl;