library IEEE;
    use IEEE.STD_LOGIC_1164.all;


package viterbi_package is


  
constant tracelength : integer := 40;
constant bufflength  : integer := 12;
constant distmax  : integer := (tracelength/8)+1;

--type trellis_rute is std_logic_vector(tracelength-7 downto 0);
type pe_state is (S0S1, S2S3, S4S5, S6S7);   
type statetype is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10);

type path is record
        start   : std_logic_vector(5 downto 0);
        list    : std_logic_vector(tracelength-7 downto 0);
   end record;
   
type buff is record
        start   : std_logic_vector(5 downto 0);
        list    : std_logic_vector(bufflength-1 downto 0);
   end record;

type start_buff is array (63 downto 0) of std_logic_vector(5 downto 0);
type pe_data is array (7 downto 0) of std_logic_vector(distmax-1 downto 0);
type sort_data is array (6 downto 0) of std_logic_vector(2 downto 0);
type tail_buff is array (5 downto 0) of std_logic_vector(2 downto 0);


	constant no_path : path := (
	start => (others => 'Z'), list => (others => 'Z'));
	
	
	--constant no_pe_data : pe_data := (no_path, no_path, no_path, no_path);
    constant no_pe_data : pe_data := ((others => '0'), (others => '0'), (others => '0'), (others => '0'),(others => '0'), (others => '0'), (others => '0'), (others => '0'));
	
	
	component input_reg
	port(
		clock    : in  std_logic;
		reset    : in  std_logic;
		datain	 : in  std_logic_vector(2 downto 0);
		dataout  : out std_logic_vector(2 downto 0)
		);
	end component;
	
	component output_reg
	port(
		clock    : in  std_logic;
		reset    : in  std_logic;
		datain	 : in  std_logic;
		dataout  : out std_logic
		);
	end component;
	
	component branch_metric
    port(
        PE_ID        : in  std_logic_vector(47 downto 0);   
	    weight_000_0 : out std_logic_vector(2 downto 0);
	    weight_000_1 : out std_logic_vector(2 downto 0);	
	    weight_001_0 : out std_logic_vector(2 downto 0);	
	    weight_001_1 : out std_logic_vector(2 downto 0);
        weight_010_0 : out std_logic_vector(2 downto 0);
	    weight_010_1 : out std_logic_vector(2 downto 0);	
	    weight_011_0 : out std_logic_vector(2 downto 0);
	    weight_011_1 : out std_logic_vector(2 downto 0);	
	    weight_100_0 : out std_logic_vector(2 downto 0);	 
	    weight_100_1 : out std_logic_vector(2 downto 0); 
	    weight_101_0 : out std_logic_vector(2 downto 0); 
	    weight_101_1 : out std_logic_vector(2 downto 0);	 
	    weight_110_0 : out std_logic_vector(2 downto 0);
	    weight_110_1 : out std_logic_vector(2 downto 0);
	    weight_111_0 : out std_logic_vector(2 downto 0);
	    weight_111_1 : out std_logic_vector(2 downto 0)
		);
    end component;
	
	component process_element
    port(
        clock         : in  std_logic;
        reset         : in  std_logic;
        valid         : in  std_logic;
        datain        : in  std_logic_vector(2 downto 0);
        PE_ID         : in  std_logic_vector(47 downto 0);
		rute_i  	  : in  pe_data; 
		rute_min_o    : out pe_data; 
		rute_o	 	  : out std_logic_vector(7 downto 0)
        );
    end component;
	
	component acs_unit
    port(
        clock        : in  std_logic;
        reset        : in  std_logic;
        valid        : in  std_logic;
        weight_up    : in  std_logic_vector(2 downto 0);
        weight_down  : in  std_logic_vector(2 downto 0);
        data_i       : in  std_logic_vector(2 downto 0);
        rute_up    	 : in  std_logic_vector (distmax-1 downto 0);
        rute_down  	 : in  std_logic_vector (distmax-1 downto 0);
        min_path     : out std_logic_vector (distmax-1 downto 0);
        rute_o       : out std_logic
        );
    end component;
	
	component path_reg
    port(
        reset	 	   : in  std_logic;
		clock    	   : in  std_logic;
		clock2   	   : in  std_logic;
		flush_ram  	   : in  std_logic;
        rute_vld 	   : in  std_logic;
        rute_000   	   : in  std_logic_vector(7 downto 0);
        rute_001  	   : in  std_logic_vector(7 downto 0);
        rute_010   	   : in  std_logic_vector(7 downto 0);
        rute_011  	   : in  std_logic_vector(7 downto 0);
        rute_100   	   : in  std_logic_vector(7 downto 0);
        rute_101  	   : in  std_logic_vector(7 downto 0);
        rute_110   	   : in  std_logic_vector(7 downto 0);
        rute_111       : in  std_logic_vector(7 downto 0);
        datcount       : in  integer range 0 to tracelength-1;
        min_rute_v 	   : in  std_logic;
        min_rute   	   : in  std_logic_vector(5 downto 0);
		start_rute	   : out start_buff;
		min_path_v	   : out std_logic;
		min_path  	   : out std_logic
		); 
    end component;
		
	component traceback_counter
    port(
        reset	 : in  std_logic;
		clock    : in  std_logic;
		valid    : in  std_logic;
		rute_vld : out std_logic;
		datacount: out integer range 0 to tracelength-1
        );
    end component;
	
	component dist_reg
    port(reset	 	   : in  std_logic;
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
    end component;
	
	component clock_divide
    port(
        reset	 : in  std_logic;
		clock    : in  std_logic;
        clock2	 : out std_logic;
        clock6	 : out std_logic;
		clk_count: out std_logic_vector(1 downto 0)
        );
    end component;
	
	component shift_reg 
    port(
        clock  : in  std_logic;
        reset  : in  std_logic;
        datain : in  std_logic;
        data0  : out std_logic;
        data1  : out std_logic;
        data2  : out std_logic;
        data3  : out std_logic;
        data4  : out std_logic;
        data5  : out std_logic;
        data6  : out std_logic
        );
    end component;
	
	component convo_encod
    port(
        clock  : in  std_logic;
        reset  : in  std_logic;
        datain : in  std_logic;
        dataout: out std_logic_vector(2 downto 0)
        );
    end component;
	
	component encoder_top
    port(
        clock  : in  std_logic;
        reset  : in  std_logic;
        datain : in  std_logic;
        dataout: out std_logic_vector(2 downto 0));
    end component;
	
	component decoder_top
    port(
        clock  : in  std_logic;
        reset  : in  std_logic;
        datain : in  std_logic_vector(2 downto 0);
		valid  : in  std_logic;
        dataout: out std_logic);
    end component;
	
	component path_mem_cell
	generic	(start_state : std_logic_vector(5 downto 0));
    port(
        ram_reset	   : in  std_logic;
		clock    	   : in  std_logic;
        store_vld 	   : in  std_logic;
        buff_vld 	   : in  std_logic;
        buff_end 	   : in  std_logic;
        rute	 	   : in  std_logic;
        bit_in	 	   : in  std_logic;
        datcount       : in  integer range 0 to tracelength-1;
        data_0   	   : in  path;
        data_1  	   : in  path;
        buff_0   	   : in  buff;
        buff_1  	   : in  buff;
        buff_out   	   : out buff;
        data_out 	   : out path
        );            
    end component;
	
	component reverse_trellis_unit is
    port(
        clock        : in  std_logic;
        reset        : in  std_logic;
        valid        : in  std_logic;
        data_i       : in  std_logic_vector(2 downto 0);
        start_rute	 : in  std_logic_vector (11 downto 0);
        path_cost    : out std_logic_vector (distmax-1 downto 0)
        );
    end component;
	
	component reverse_trellis is
    port(
        clock         : in  std_logic;
        reset         : in  std_logic;
        datain        : in  std_logic_vector(2 downto 0);
        datcount      : in  integer range 0 to tracelength-1;
        valid         : in  std_logic;
		start_rute	  : in  start_buff; 
		reverse_valid : out std_logic;
		start_000 	  : out pe_data;
		start_001 	  : out pe_data;
		start_010 	  : out pe_data;
		start_011 	  : out pe_data;
		start_100 	  : out pe_data;
		start_101 	  : out pe_data;
		start_110 	  : out pe_data;
		start_111 	  : out pe_data
        );
    end component;
	
	component minrute_selector
    port(
        clock     : in  std_logic;
        reset     : in  std_logic;
        valid     : in  std_logic;
        rute_a	  : in  std_logic_vector(5 downto 0);
        rute_b    : in  std_logic_vector(5 downto 0);
        cost_a    : in  std_logic_vector(distmax-1 downto 0);
        cost_b    : in  std_logic_vector(distmax-1 downto 0);
        min_cost  : out std_logic_vector(distmax-1 downto 0);
        rute_min  : out std_logic_vector(5 downto 0)
        );
    end component;
	
	component best_state_unit is
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
    end component;
	
end viterbi_package;