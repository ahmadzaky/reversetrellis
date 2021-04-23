library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.viterbi_package.all;

entity decoder_top is
    port(
        clock  : in  std_logic;
        reset  : in  std_logic;
        datain : in  std_logic_vector(2 downto 0);
		valid  : in  std_logic;
        dataout: out std_logic);
    end entity;
    
architecture struct of decoder_top is
	signal clock2        : std_logic;
	signal clock6        : std_logic;
	signal s_data        : std_logic_vector(2 downto 0); 

	signal clk_count     : std_logic_vector(1 downto 0);
	signal best_rute_v   : std_logic;
	signal traceback_end : std_logic;
	signal data_valid    : std_logic;
	signal pe_valid      : std_logic;
	signal flush_ram_2   : std_logic;
	signal flush_ram_1   : std_logic;
	signal flush_ram_0   : std_logic;
	signal flush_ram     : std_logic;
	signal start_rute    : start_buff;
	signal datacount	 : integer range 0 to tracelength-1;
--	signal s_newdata 	: std_logic;
	
	signal min_path   : std_logic_vector(5 downto 0);	
	signal min_path_v : std_logic;	
	signal rute_000   : std_logic_vector(7 downto 0);
    signal rute_001   : std_logic_vector(7 downto 0);
    signal rute_010   : std_logic_vector(7 downto 0);
    signal rute_011   : std_logic_vector(7 downto 0);
    signal rute_100   : std_logic_vector(7 downto 0);
    signal rute_101   : std_logic_vector(7 downto 0);
    signal rute_110   : std_logic_vector(7 downto 0);
    signal rute_111   : std_logic_vector(7 downto 0);
    signal first_seq  : tail_buff;
    signal dist_000_i 	  : pe_data;
    signal dist_001_i 	  : pe_data;
    signal dist_010_i 	  : pe_data;
    signal dist_011_i 	  : pe_data;
    signal dist_100_i 	  : pe_data;
    signal dist_101_i 	  : pe_data;
    signal dist_110_i 	  : pe_data;
    signal dist_111_i 	  : pe_data;
    signal dist_000_o 	  : pe_data;
    signal dist_001_o 	  : pe_data;
    signal dist_010_o 	  : pe_data;
    signal dist_011_o 	  : pe_data;
    signal dist_100_o 	  : pe_data;
    signal dist_101_o 	  : pe_data;
    signal dist_110_o 	  : pe_data;
    signal dist_111_o 	  : pe_data;
	signal start_000_cost : pe_data;
	signal start_001_cost : pe_data;
	signal start_010_cost : pe_data;
	signal start_011_cost : pe_data;
	signal start_100_cost : pe_data;
	signal start_101_cost : pe_data;
	signal start_110_cost : pe_data;
	signal start_111_cost : pe_data;
	signal reverse_valid  : std_logic;
	signal rev_valid  : std_logic;
	signal s_dout  : std_logic;
	signal total_000    : pe_data;
    signal total_001    : pe_data;
    signal total_010    : pe_data;
    signal total_011    : pe_data;
    signal total_100    : pe_data;
    signal total_101    : pe_data;
    signal total_110    : pe_data;
    signal total_111    : pe_data;
	signal total_v	  	: std_logic;
	
	
begin       


	
	
	
	
    process(clock, reset)
	begin
	if reset = '1' then
       data_valid <= '0';
	elsif clock'event and clock = '1' then
		if (datacount > 5) then
	  data_valid <= clock2;
		end if;
	end if;
	end process;
    
	process(clock, reset)
	begin
	if reset = '1' then
       flush_ram_0 <= '0';
	elsif clock'event and clock = '0' then
		flush_ram_0 <= traceback_end;
	end if;
	end process;
	
	process(clock, reset)
	begin
	if reset = '1' then
       flush_ram_1 <= '0';
	elsif clock'event and clock = '1' then
		flush_ram_1 <= traceback_end;
	end if;
	end process;
	
	flush_ram_2 <= traceback_end when (flush_ram_0 = '0') else '0';
	--flush_ram   <= flush_ram_0 when (flush_ram_1 = '0') else '0';
	flush_ram   <= '1' when (datacount = 5) else '0';
	
 
	
    process(clock2, reset)
	begin
	if reset = '1' then
		rev_valid <= '0';
	elsif clock2'event and clock2 = '1' then
		if 	(datacount < 6) then
			rev_valid <= '1';
		else
			rev_valid <= '0';
		end if;
	end if;
	end process;

	
	TC : traceback_counter
    port map(
        reset	  => reset,
		clock     => clock2,
		valid     => valid,
		rute_vld  => traceback_end,
		datacount => datacount
        );
        
		
		
		
		
	IREG : input_reg
	port map(
		clock    => clock2,
		reset    => reset,
		datain	 => datain,
		dataout  => s_data
	);
		
	OREG : output_reg
	port map(
		clock    => clock2,
		reset    => reset,
		datain	 => s_dout,
		dataout  => dataout
		);			
		
	CLKDV : clock_divide
    port map(
        reset	  => reset,
		clock     => clock,
        clock2	  => clock2,
        clock6	  => clock6,
		clk_count => clk_count
        ); 
	 
	PE000 : process_element
    port map(
        clock        => clock, 
        reset        => reset, 
		valid		 => clock2,
        datain       => s_data,
        PE_ID        => "000111111000100011011100001110110001101010010101", 
		rute_i  	 => dist_000_i,
		rute_min_o   => dist_000_o,
		rute_o	 	 => rute_000 
        );
     
	PE001 : process_element
    port map(
        clock        => clock, 
        reset        => reset, 
		valid		 => clock2,
        datain       => s_data,
        PE_ID        => "110001001110010101101010111000000111011100100011", 
		rute_i  	 => dist_001_i,
		rute_min_o   => dist_001_o,
		rute_o	 	 => rute_001 
        );
     
	PE010 : process_element
    port map(
        clock        => clock, 
        reset        => reset, 
		valid		 => clock2,
        datain       => s_data,
        PE_ID        => "111000000111011100100011110001001110010101101010", 
		rute_i  	 => dist_010_i,
		rute_min_o   => dist_010_o,
		rute_o	 	 => rute_010 
        );
     
	PE011 : process_element
    port map(
        clock        => clock, 
        reset        => reset, 
		valid		 => clock2,
        datain       => s_data,
        PE_ID        => "001110110001101010010101000111111000100011011100", 
		rute_i  	 => dist_011_i,
		rute_min_o   => dist_011_o,
		rute_o	 	 => rute_011 
        );
		
	PE100 : process_element
    port map(
        clock        => clock, 
        reset        => reset, 
		valid		 => clock2,
        datain       => s_data,
        PE_ID        => "011100100011111000000111010101101010110001001110", 
		rute_i  	 => dist_100_i,
		rute_min_o   => dist_100_o,
		rute_o	 	 => rute_100 
        );
		
	PE101 : process_element
    port map(
        clock        => clock, 
        reset        => reset, 
		valid		 => clock2,
        datain       => s_data,
        PE_ID        => "101010010101001110110001100011011100000111111000", 
		rute_i  	 => dist_101_i,
		rute_min_o   => dist_101_o,
		rute_o	 	 => rute_101 
        );
		
	PE110 : process_element
    port map(
        clock        => clock, 
        reset        => reset, 
		valid		 => clock2,
        datain       => s_data,
        PE_ID        => "100011011100000111111000101010010101001110110001", 
		rute_i  	 => dist_110_i,
		rute_min_o   => dist_110_o,
		rute_o	 	 => rute_110 
        );
		
	PE111 : process_element
    port map(
        clock        => clock, 
        reset        => reset, 
		valid		 => clock2,
        datain       => s_data,
        PE_ID        => "010101101010110001001110011100100011111000000111", 
		rute_i  	 => dist_111_i,
		rute_min_o   => dist_111_o,
		rute_o	 	 => rute_111 
        );
	 
	DISREG : dist_reg
    port map(
        reset	 	=> reset,
		clock    	=> clock, 
		clock2    	=> clock2, 
		traceback_end => traceback_end,
		flush_ram  	=> flush_ram,
        rute_vld 	=> data_valid,
		rev_vld		=> reverse_valid,
        dist_000_i  => dist_000_o,
        dist_001_i  => dist_001_o,
        dist_010_i  => dist_010_o,
        dist_011_i  => dist_011_o,
        dist_100_i  => dist_100_o,
        dist_101_i  => dist_101_o,
        dist_110_i  => dist_110_o,
        dist_111_i  => dist_111_o,
		start_000 	=> start_000_cost,
		start_001 	=> start_001_cost,
		start_010 	=> start_010_cost,
		start_011 	=> start_011_cost,
		start_100 	=> start_100_cost,
		start_101 	=> start_101_cost,
		start_110 	=> start_110_cost,
		start_111 	=> start_111_cost,
        dist_000_o  => dist_000_i,
        dist_001_o  => dist_001_i,
        dist_010_o  => dist_010_i,
        dist_011_o  => dist_011_i,
        dist_100_o  => dist_100_i,
        dist_101_o  => dist_101_i,
        dist_110_o  => dist_110_i,
        dist_111_o  => dist_111_i,
        total_000_o => total_000,
        total_001_o => total_001,
        total_010_o => total_010,
        total_011_o => total_011,
        total_100_o => total_100,
        total_101_o => total_101,
        total_110_o => total_110,
        total_111_o => total_111,
		total_v	  	=> total_v
        );
		
	BSU : best_state_unit
    port map(
        reset	 	   => reset, 
		clock    	   => clock,
		total_v  	   => total_v,
        total_000_o    => total_000,
        total_001_o    => total_001,
        total_010_o    => total_010,
        total_011_o    => total_011,
        total_100_o    => total_100,
        total_101_o    => total_101,
        total_110_o    => total_110,
        total_111_o    => total_111,
		min_path	   => min_path, 
		min_path_v	   => min_path_v
        );
       
	PMU : path_reg 
    port map(
        reset	 	=> reset, 
		clock2    	=> clock2, 
		clock    	=> clock, 
		flush_ram  	=> flush_ram, 
        rute_vld 	=> data_valid, 
		start_rute	=> start_rute,	
        rute_000   	=> rute_000,
        rute_001  	=> rute_001,
        rute_010   	=> rute_010,
        rute_011  	=> rute_011,
        rute_100   	=> rute_100,
        rute_101  	=> rute_101,
        rute_110   	=> rute_110,
        rute_111    => rute_111,
        datcount    => datacount,
		min_rute_v	=> min_path_v, 
		min_rute  	=> min_path, 
		min_path_v	=> best_rute_v, 
		min_path  	=> s_dout 
        );
		
	
	REVSE : reverse_trellis
    port map(
        clock         => clock2, 	
        reset         => reset,
		datain  	  => s_data,
		datcount	  => datacount,   	
        valid         => rev_valid, 
		start_rute	  => start_rute,
		reverse_valid => reverse_valid, 
		start_000 	  => start_000_cost,
		start_001 	  => start_001_cost,
		start_010 	  => start_010_cost,
		start_011 	  => start_011_cost,
		start_100 	  => start_100_cost,
		start_101 	  => start_101_cost,
		start_110 	  => start_110_cost,
		start_111 	  => start_111_cost
        );
end architecture;       