library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


library work;
use work.viterbi_package.all;

entity process_element is
    port(
        clock         : in  std_logic;
        reset         : in  std_logic;
        valid         : in  std_logic;
        datain        : in  std_logic_vector(2 downto 0);
        PE_ID         : in  std_logic_vector(47 downto 0);
		rute_i  	  : in  pe_data; -- 000, 001, 010, 011, 100, 101, 110, 111
		rute_min_o    : out pe_data; -- 00_0, 00_1, 01_0, 01_1, 10_0, 10_1, 11_0, 11_1
		rute_o	 	  : out std_logic_vector(7 downto 0)
        );
    end entity;
    
architecture struct of process_element is
    
    signal weight_000_0  : std_logic_vector(2 downto 0);
    signal weight_000_1  : std_logic_vector(2 downto 0);
    signal weight_001_0  : std_logic_vector(2 downto 0);
    signal weight_001_1  : std_logic_vector(2 downto 0);
    signal weight_010_0  : std_logic_vector(2 downto 0);
    signal weight_010_1  : std_logic_vector(2 downto 0);
    signal weight_011_0  : std_logic_vector(2 downto 0);
    signal weight_011_1  : std_logic_vector(2 downto 0);
    signal weight_100_0  : std_logic_vector(2 downto 0);
    signal weight_100_1  : std_logic_vector(2 downto 0);
    signal weight_101_0  : std_logic_vector(2 downto 0);
    signal weight_101_1  : std_logic_vector(2 downto 0);
    signal weight_110_0  : std_logic_vector(2 downto 0);
    signal weight_110_1  : std_logic_vector(2 downto 0);
    signal weight_111_0  : std_logic_vector(2 downto 0);
    signal weight_111_1  : std_logic_vector(2 downto 0);
	

begin       	  

	BMU : branch_metric 
    port map(
        PE_ID        => PE_ID,   
	    weight_000_0 => weight_000_0,
	    weight_000_1 => weight_000_1,
	    weight_001_0 => weight_001_0,
	    weight_001_1 => weight_001_1,
        weight_010_0 => weight_010_0,
	    weight_010_1 => weight_010_1,
	    weight_011_0 => weight_011_0,
	    weight_011_1 => weight_011_1,
	    weight_100_0 => weight_100_0, 
	    weight_100_1 => weight_100_1,
	    weight_101_0 => weight_101_0,
	    weight_101_1 => weight_101_1, 
	    weight_110_0 => weight_110_0,
	    weight_110_1 => weight_110_1,
	    weight_111_0 => weight_111_0,
	    weight_111_1 => weight_111_1
		);

	
    bt_00_0 : acs_unit 
    port map(
        clock        => clock, 
        reset        => reset,
        valid        => valid,
        weight_up    => weight_000_0,
        weight_down  => weight_001_0,
        data_i       => datain, 
        rute_up    	 => rute_i(0),
        rute_down  	 => rute_i(1),
		min_path	 => rute_min_o(0),
        rute_o       => rute_o(0)
        );
        
    bt_00_1 : acs_unit 
    port map(
        clock        => clock, 
        reset        => reset,
        valid        => valid,
        weight_up    => weight_000_1,
        weight_down  => weight_001_1,
        data_i       => datain, 
        rute_up    	 => rute_i(0),
        rute_down  	 => rute_i(1),
		min_path	 => rute_min_o(1),
        rute_o       => rute_o(1)
        );	 
		
    bt_01_0 : acs_unit 
    port map(
        clock        => clock, 
        reset        => reset,
        valid        => valid,
        weight_up    => weight_010_0,
        weight_down  => weight_011_0,
        data_i       => datain, 
        rute_up    	 => rute_i(2),
        rute_down  	 => rute_i(3),
		min_path	 => rute_min_o(2),
        rute_o       => rute_o(2)
        );
        
    bt_01_1 : acs_unit 
    port map(
        clock        => clock, 
        reset        => reset,
        valid        => valid,
        weight_up    => weight_010_1,
        weight_down  => weight_011_1,
        data_i       => datain, 
        rute_up    	 => rute_i(2),
        rute_down  	 => rute_i(3),
		min_path	 => rute_min_o(3),
        rute_o       => rute_o(3)
        );	 

    bt_10_0 : acs_unit 
    port map(
        clock        => clock, 
        reset        => reset,
        valid        => valid,
        weight_up    => weight_100_0,
        weight_down  => weight_101_0,
        data_i       => datain, 
        rute_up    	 => rute_i(4),
        rute_down  	 => rute_i(5),
		min_path	 => rute_min_o(4),
        rute_o       => rute_o(4)
        );
        
    bt_10_1 : acs_unit 
    port map(
        clock        => clock, 
        reset        => reset,
        valid        => valid,
        weight_up    => weight_100_1,
        weight_down  => weight_101_1,
        data_i       => datain, 
        rute_up    	 => rute_i(4),
        rute_down  	 => rute_i(5),
		min_path	 => rute_min_o(5),
        rute_o       => rute_o(5)
        );	 	
		
    bt_11_0 : acs_unit 
    port map(
        clock        => clock, 
        reset        => reset,
        valid        => valid,
        weight_up    => weight_110_0,
        weight_down  => weight_111_0,
        data_i       => datain, 
        rute_up    	 => rute_i(6),
        rute_down  	 => rute_i(7),
		min_path	 => rute_min_o(6),
        rute_o       => rute_o(6)
        );
        
    bt_11_1 : acs_unit 
    port map(
        clock        => clock, 
        reset        => reset,
        valid        => valid,
        weight_up    => weight_110_1,
        weight_down  => weight_111_1,
        data_i       => datain, 
        rute_up    	 => rute_i(6),
        rute_down  	 => rute_i(7),
		min_path	 => rute_min_o(7),
        rute_o       => rute_o(7)
        );	 
		
end architecture;       