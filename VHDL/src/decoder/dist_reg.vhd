library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.viterbi_package.all;

entity dist_reg is
    port(
        reset	 	   : in  std_logic;
		clock    	   : in  std_logic;
		clock2   	   : in  std_logic;
		traceback_end  : in  std_logic;
		flush_ram  	   : in  std_logic;
        rute_vld 	   : in  std_logic;
        rev_vld 	   : in  std_logic;
        dist_000_i     : in  pe_data;
        dist_001_i     : in  pe_data;
        dist_010_i     : in  pe_data;
        dist_011_i     : in  pe_data;
        dist_100_i     : in  pe_data;
        dist_101_i     : in  pe_data;
        dist_110_i     : in  pe_data;
        dist_111_i     : in  pe_data;
		start_000 	   : in  pe_data;
		start_001 	   : in  pe_data;
		start_010 	   : in  pe_data;
		start_011 	   : in  pe_data;
		start_100 	   : in  pe_data;
		start_101 	   : in  pe_data;
		start_110 	   : in  pe_data;
		start_111 	   : in  pe_data;
        dist_000_o     : out pe_data;
        dist_001_o     : out pe_data;
        dist_010_o     : out pe_data;
        dist_011_o     : out pe_data;
        dist_100_o     : out pe_data;
        dist_101_o     : out pe_data;
        dist_110_o     : out pe_data;
        dist_111_o     : out pe_data;
        total_000_o    : out pe_data;
        total_001_o    : out pe_data;
        total_010_o    : out pe_data;
        total_011_o    : out pe_data;
        total_100_o    : out pe_data;
        total_101_o    : out pe_data;
        total_110_o    : out pe_data;
        total_111_o    : out pe_data;
		total_v	  	   : out std_logic
        );
    end entity;
    
architecture rtl of dist_reg is
	signal ram_reset : std_logic;
	signal traceend_delay : std_logic;
    signal dist_000_buff0 : pe_data;
    signal dist_001_buff0 : pe_data;
    signal dist_010_buff0 : pe_data;
    signal dist_011_buff0 : pe_data;
    signal dist_100_buff0 : pe_data;
    signal dist_101_buff0 : pe_data;
    signal dist_110_buff0 : pe_data;
    signal dist_111_buff0 : pe_data;
    signal dist_000_s	 : pe_data;
    signal dist_001_s	 : pe_data;
    signal dist_010_s	 : pe_data;
    signal dist_011_s	 : pe_data;
    signal dist_100_s	 : pe_data;
    signal dist_101_s	 : pe_data;
    signal dist_110_s	 : pe_data;
    signal dist_111_s	 : pe_data;
    signal state : statetype;
    signal next_state : statetype;
	
begin

	ram_reset <= reset or flush_ram;
	
	
	dist_000_o 	 <= dist_000_s;
	dist_001_o 	 <= dist_001_s;
	dist_010_o 	 <= dist_010_s;
	dist_011_o 	 <= dist_011_s;
	dist_100_o 	 <= dist_100_s;
	dist_101_o 	 <= dist_101_s;
	dist_110_o 	 <= dist_110_s;
	dist_111_o 	 <= dist_111_s;
	total_000_o  <= dist_000_buff0;
    total_001_o  <= dist_001_buff0;
    total_010_o  <= dist_010_buff0;
    total_011_o  <= dist_011_buff0;
    total_100_o  <= dist_100_buff0;
    total_101_o  <= dist_101_buff0;
    total_110_o  <= dist_110_buff0;
    total_111_o  <= dist_111_buff0;
	
	process(clock2, reset)
	begin
		if reset = '1' then
		    state <= s0;
		elsif clock2'event and clock2 = '0' then
			state <= next_state;
		end if;
	end  process;
	
	process(clock2, reset)
	begin
		if reset = '1' then
		    traceend_delay <= '0';
		elsif clock2'event and clock2 = '0' then
			traceend_delay <= traceback_end;
		end if;
	end  process;
	
	
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
	
process (clock2, reset, traceback_end, state)
begin
if reset = '1' then
	next_state <= s0;
	dist_000_buff0    <= no_pe_data;
	dist_001_buff0    <= no_pe_data;
	dist_010_buff0    <= no_pe_data;
	dist_011_buff0    <= no_pe_data;
	dist_100_buff0    <= no_pe_data;
	dist_101_buff0    <= no_pe_data;
	dist_110_buff0    <= no_pe_data;
	dist_111_buff0    <= no_pe_data;
elsif clock2'event and clock2 = '1' then 
	if state = s0 then
		total_v <= '0';
		if traceend_delay = '1' then
			next_state <= s1;	
		 	dist_000_buff0 <= dist_000_s ;	
			dist_001_buff0 <= dist_001_s ;
			dist_010_buff0 <= dist_010_s ;
			dist_011_buff0 <= dist_011_s ;
			dist_100_buff0 <= dist_100_s ;
			dist_101_buff0 <= dist_101_s ;
			dist_110_buff0 <= dist_110_s ;
			dist_111_buff0 <= dist_111_s ;
		else
			next_state <= s0;
		 	dist_000_buff0    <= no_pe_data;
			dist_001_buff0    <= no_pe_data;
			dist_010_buff0    <= no_pe_data;
			dist_011_buff0    <= no_pe_data;
			dist_100_buff0    <= no_pe_data;
			dist_101_buff0    <= no_pe_data;
			dist_110_buff0    <= no_pe_data;
			dist_111_buff0    <= no_pe_data;
		end if;
	elsif state = s1 then
		if rev_vld = '1' then
			next_state <= s2;
		else
			next_state <= s1;
		end if;	
	elsif state = s2 then
			for j in 7 downto 0 LOOP
				dist_000_buff0(j) <= dist_000_buff0(j) + start_000(j);
				dist_001_buff0(j) <= dist_001_buff0(j) + start_001(j);
				dist_010_buff0(j) <= dist_010_buff0(j) + start_010(j);
				dist_011_buff0(j) <= dist_011_buff0(j) + start_011(j);
				dist_100_buff0(j) <= dist_100_buff0(j) + start_100(j);
				dist_101_buff0(j) <= dist_101_buff0(j) + start_101(j);
				dist_110_buff0(j) <= dist_110_buff0(j) + start_110(j);
				dist_111_buff0(j) <= dist_111_buff0(j) + start_111(j);
            END LOOP;
			next_state <= s3;
	elsif state = s3 then
		total_v <= '1';
		next_state <= s4;
	elsif state = s4 then
		total_v <= '0';
		next_state <= s5;
	elsif state = s5 then
		next_state <= s6;
	elsif state = s6 then
		next_state <= s0;
	end if;
	end if;
end process;
	
	
	process(clock, ram_reset)
	begin
		if ram_reset = '1' then
		    dist_000_s <= no_pe_data;
		elsif clock'event and clock = '1' then
			if rute_vld = '1' then
				dist_000_s(0) <= dist_000_i(0);
				dist_000_s(1) <= dist_000_i(2);
				dist_000_s(2) <= dist_000_i(4);
				dist_000_s(3) <= dist_000_i(6);
				dist_000_s(4) <= dist_001_i(0);
				dist_000_s(5) <= dist_001_i(2);
				dist_000_s(6) <= dist_001_i(4);
				dist_000_s(7) <= dist_001_i(6);
			end if;
		end if;
	end  process;
	
	process(clock, ram_reset)
	begin
		if ram_reset = '1' then
		    dist_001_s <= no_pe_data;
		elsif clock'event and clock = '1' then
			if rute_vld = '1' then
				dist_001_s(0) <= dist_010_i(0);
				dist_001_s(1) <= dist_010_i(2);
				dist_001_s(2) <= dist_010_i(4);
				dist_001_s(3) <= dist_010_i(6);
				dist_001_s(4) <= dist_011_i(0);
				dist_001_s(5) <= dist_011_i(2);
				dist_001_s(6) <= dist_011_i(4);
				dist_001_s(7) <= dist_011_i(6);
			end if;
		end if;
	end  process;
	
	process(clock, ram_reset)
	begin
		if ram_reset = '1' then
		    dist_010_s <= no_pe_data;
		elsif clock'event and clock = '1' then
			if rute_vld = '1' then
				dist_010_s(0) <= dist_100_i(0);
				dist_010_s(1) <= dist_100_i(2);
				dist_010_s(2) <= dist_100_i(4);
				dist_010_s(3) <= dist_100_i(6);
				dist_010_s(4) <= dist_101_i(0);
				dist_010_s(5) <= dist_101_i(2);
				dist_010_s(6) <= dist_101_i(4);
				dist_010_s(7) <= dist_101_i(6);
			end if;
		end if;
	end  process;
	
	process(clock, ram_reset)
	begin
		if ram_reset = '1' then
		    dist_011_s <= no_pe_data;
		elsif clock'event and clock = '1' then
			if rute_vld = '1' then
				dist_011_s(0) <= dist_110_i(0);
				dist_011_s(1) <= dist_110_i(2);
				dist_011_s(2) <= dist_110_i(4);
				dist_011_s(3) <= dist_110_i(6);
				dist_011_s(4) <= dist_111_i(0);
				dist_011_s(5) <= dist_111_i(2);
				dist_011_s(6) <= dist_111_i(4);
				dist_011_s(7) <= dist_111_i(6);
			end if;
		end if;
	end  process;
	
	process(clock, ram_reset)
	begin
		if ram_reset = '1' then
		    dist_100_s <= no_pe_data;
		elsif clock'event and clock = '1' then
			if rute_vld = '1' then
				dist_100_s(0) <= dist_000_i(1);
				dist_100_s(1) <= dist_000_i(3);
				dist_100_s(2) <= dist_000_i(5);
				dist_100_s(3) <= dist_000_i(7);
				dist_100_s(4) <= dist_001_i(1);
				dist_100_s(5) <= dist_001_i(3);
				dist_100_s(6) <= dist_001_i(5);
				dist_100_s(7) <= dist_001_i(7);
			end if;
		end if;
	end  process;
	
	process(clock, ram_reset)
	begin
		if ram_reset = '1' then
		    dist_101_s <= no_pe_data;
		elsif clock'event and clock = '1' then
			if rute_vld = '1' then
				dist_101_s(0) <= dist_010_i(1);
				dist_101_s(1) <= dist_010_i(3);
				dist_101_s(2) <= dist_010_i(5);
				dist_101_s(3) <= dist_010_i(7);
				dist_101_s(4) <= dist_011_i(1);
				dist_101_s(5) <= dist_011_i(3);
				dist_101_s(6) <= dist_011_i(5);
				dist_101_s(7) <= dist_011_i(7);
			end if;
		end if;
	end  process;
	
	process(clock, ram_reset)
	begin
		if ram_reset = '1' then
		    dist_110_s <= no_pe_data;
		elsif clock'event and clock = '1' then
			if rute_vld = '1' then
				dist_110_s(0) <= dist_100_i(1);
				dist_110_s(1) <= dist_100_i(3);
				dist_110_s(2) <= dist_100_i(5);
				dist_110_s(3) <= dist_100_i(7);
				dist_110_s(4) <= dist_101_i(1);
				dist_110_s(5) <= dist_101_i(3);
				dist_110_s(6) <= dist_101_i(5);
				dist_110_s(7) <= dist_101_i(7);
			end if;
		end if;
	end  process;
	
	process(clock, ram_reset)
	begin
		if ram_reset = '1' then
		    dist_111_s <= no_pe_data;
		elsif clock'event and clock = '1' then
			if rute_vld = '1' then
				dist_111_s(0) <= dist_110_i(1);
				dist_111_s(1) <= dist_110_i(3);
				dist_111_s(2) <= dist_110_i(5);
				dist_111_s(3) <= dist_110_i(7);
				dist_111_s(4) <= dist_111_i(1);
				dist_111_s(5) <= dist_111_i(3);
				dist_111_s(6) <= dist_111_i(5);
				dist_111_s(7) <= dist_111_i(7);
			end if;
		end if;
	end  process;
	
	
	
	
end architecture;       