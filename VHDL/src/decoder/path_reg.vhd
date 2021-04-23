library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.viterbi_package.all;

entity path_reg is
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
    end entity;
    
architecture rtl of path_reg is
	signal ram_reset  : std_logic;
	signal store_vld  : std_logic;
	signal buff_vld   : std_logic;
	signal buff_end   : std_logic;
    signal data_000_000 : path;
    signal data_000_001 : path;
    signal data_000_010 : path;
    signal data_000_011 : path;
    signal data_000_100 : path;
    signal data_000_101 : path;
    signal data_000_110 : path;
    signal data_000_111 : path;
    signal data_001_000 : path;
    signal data_001_001 : path;
    signal data_001_010 : path;
    signal data_001_011 : path;
    signal data_001_100 : path;
    signal data_001_101 : path;
    signal data_001_110 : path;
    signal data_001_111 : path;
    signal data_010_000 : path;
    signal data_010_001 : path;
    signal data_010_010 : path;
    signal data_010_011 : path;
    signal data_010_100 : path;
    signal data_010_101 : path;
    signal data_010_110 : path;
    signal data_010_111 : path;
    signal data_011_000 : path;
    signal data_011_001 : path;
    signal data_011_010 : path;
    signal data_011_011 : path;
    signal data_011_100 : path;
    signal data_011_101 : path;
    signal data_011_110 : path;
    signal data_011_111 : path;
    signal data_100_000 : path;
    signal data_100_001 : path;
    signal data_100_010 : path;
    signal data_100_011 : path;
    signal data_100_100 : path;
    signal data_100_101 : path;
    signal data_100_110 : path;
    signal data_100_111 : path;
    signal data_101_000 : path;
    signal data_101_001 : path;
    signal data_101_010 : path;
    signal data_101_011 : path;
    signal data_101_100 : path;
    signal data_101_101 : path;
    signal data_101_110 : path;
    signal data_101_111 : path;
    signal data_110_000 : path;
    signal data_110_001 : path;
    signal data_110_010 : path;
    signal data_110_011 : path;
    signal data_110_100 : path;
    signal data_110_101 : path;
    signal data_110_110 : path;
    signal data_110_111 : path;
    signal data_111_000 : path;
    signal data_111_001 : path;
    signal data_111_010 : path;
    signal data_111_011 : path;
    signal data_111_100 : path;
    signal data_111_101 : path;
    signal data_111_110 : path;
    signal data_111_111 : path;
    signal data_min     :  std_logic_vector(tracelength-1 downto 0);
    signal buff_min     : path;
	
    signal buff_000_000 : buff;
    signal buff_000_001 : buff;
    signal buff_000_010 : buff;
    signal buff_000_011 : buff;
    signal buff_000_100 : buff;
    signal buff_000_101 : buff;
    signal buff_000_110 : buff;
    signal buff_000_111 : buff;
    signal buff_001_000 : buff;
    signal buff_001_001 : buff;
    signal buff_001_010 : buff;
    signal buff_001_011 : buff;
    signal buff_001_100 : buff;
    signal buff_001_101 : buff;
    signal buff_001_110 : buff;
    signal buff_001_111 : buff;
    signal buff_010_000 : buff;
    signal buff_010_001 : buff;
    signal buff_010_010 : buff;
    signal buff_010_011 : buff;
    signal buff_010_100 : buff;
    signal buff_010_101 : buff;
    signal buff_010_110 : buff;
    signal buff_010_111 : buff;
    signal buff_011_000 : buff;
    signal buff_011_001 : buff;
    signal buff_011_010 : buff;
    signal buff_011_011 : buff;
    signal buff_011_100 : buff;
    signal buff_011_101 : buff;
    signal buff_011_110 : buff;
    signal buff_011_111 : buff;
    signal buff_100_000 : buff;
    signal buff_100_001 : buff;
    signal buff_100_010 : buff;
    signal buff_100_011 : buff;
    signal buff_100_100 : buff;
    signal buff_100_101 : buff;
    signal buff_100_110 : buff;
    signal buff_100_111 : buff;
    signal buff_101_000 : buff;
    signal buff_101_001 : buff;
    signal buff_101_010 : buff;
    signal buff_101_011 : buff;
    signal buff_101_100 : buff;
    signal buff_101_101 : buff;
    signal buff_101_110 : buff;
    signal buff_101_111 : buff;
    signal buff_110_000 : buff;
    signal buff_110_001 : buff;
    signal buff_110_010 : buff;
    signal buff_110_011 : buff;
    signal buff_110_100 : buff;
    signal buff_110_101 : buff;
    signal buff_110_110 : buff;
    signal buff_110_111 : buff;
    signal buff_111_000 : buff;
    signal buff_111_001 : buff;
    signal buff_111_010 : buff;
    signal buff_111_011 : buff;
    signal buff_111_100 : buff;
    signal buff_111_101 : buff;
    signal buff_111_110 : buff;
    signal buff_111_111 : buff;
    --signal bit_tail_reg : std_logic_vector(63 downto 0);
begin

	ram_reset <= reset or flush_ram;
	store_vld <= rute_vld when (datcount > bufflength-1+6) else '0';
	buff_vld  <= rute_vld when (datcount < bufflength+6) else '0';
    buff_end  <= '1' when (datcount = bufflength+6) else '0';
	
	
	start_rute <=  (data_111_111.start, 
					data_111_110.start,
					data_111_101.start, 
					data_111_100.start,
					data_111_011.start, 
					data_111_010.start,
					data_111_001.start, 
					data_111_000.start,
					data_110_111.start, 
					data_110_110.start,
					data_110_101.start, 
					data_110_100.start,
					data_110_011.start, 
					data_110_010.start,
					data_110_001.start, 
					data_110_000.start,
					data_101_111.start, 
					data_101_110.start,
					data_101_101.start, 
					data_101_100.start,
					data_101_011.start, 
					data_101_010.start,
					data_101_001.start, 
					data_101_000.start,
					data_100_111.start, 
					data_100_110.start,
					data_100_101.start, 
					data_100_100.start,
					data_100_011.start, 
					data_100_010.start,
					data_100_001.start, 
					data_100_000.start,
					data_011_111.start, 
					data_011_110.start,
					data_011_101.start, 
					data_011_100.start,
					data_011_011.start, 
					data_011_010.start,
					data_011_001.start, 
					data_011_000.start,
					data_010_111.start, 
					data_010_110.start,
					data_010_101.start, 
					data_010_100.start,
					data_010_011.start, 
					data_010_010.start,
					data_010_001.start, 
					data_010_000.start,
					data_001_111.start, 
					data_001_110.start,
					data_001_101.start, 
					data_001_100.start,
					data_001_011.start, 
					data_001_010.start,
					data_001_001.start, 
					data_001_000.start,
					data_000_111.start, 
					data_000_110.start,
					data_000_101.start, 
					data_000_100.start,
					data_000_011.start, 
					data_000_010.start,
					data_000_001.start, 
					data_000_000.start);
	
	buff_min <= data_000_000 when (min_rute = "000000") else
				data_000_001 when (min_rute = "000001") else
				data_000_010 when (min_rute = "000010") else
				data_000_011 when (min_rute = "000011") else
				data_000_100 when (min_rute = "000100") else
				data_000_101 when (min_rute = "000101") else
				data_000_110 when (min_rute = "000110") else
				data_000_111 when (min_rute = "000111") else
				data_001_000 when (min_rute = "001000") else
				data_001_001 when (min_rute = "001001") else
				data_001_010 when (min_rute = "001010") else
				data_001_011 when (min_rute = "001011") else
				data_001_100 when (min_rute = "001100") else
				data_001_101 when (min_rute = "001101") else
				data_001_110 when (min_rute = "001110") else
				data_001_111 when (min_rute = "001111") else
				data_010_000 when (min_rute = "010000") else
				data_010_001 when (min_rute = "010001") else
				data_010_010 when (min_rute = "010010") else
				data_010_011 when (min_rute = "010011") else
				data_010_100 when (min_rute = "010100") else
				data_010_101 when (min_rute = "010101") else
				data_010_110 when (min_rute = "010110") else
				data_010_111 when (min_rute = "010111") else
				data_011_000 when (min_rute = "011000") else
				data_011_001 when (min_rute = "011001") else
				data_011_010 when (min_rute = "011010") else
				data_011_011 when (min_rute = "011011") else
				data_011_100 when (min_rute = "011100") else
				data_011_101 when (min_rute = "011101") else
				data_011_110 when (min_rute = "011110") else
				data_011_111 when (min_rute = "011111") else
				data_100_000 when (min_rute = "100000") else
				data_100_001 when (min_rute = "100001") else
				data_100_010 when (min_rute = "100010") else
				data_100_011 when (min_rute = "100011") else
				data_100_100 when (min_rute = "100100") else
				data_100_101 when (min_rute = "100101") else
				data_100_110 when (min_rute = "100110") else
				data_100_111 when (min_rute = "100111") else
				data_101_000 when (min_rute = "101000") else
				data_101_001 when (min_rute = "101001") else
				data_101_010 when (min_rute = "101010") else
				data_101_011 when (min_rute = "101011") else
				data_101_100 when (min_rute = "101100") else
				data_101_101 when (min_rute = "101101") else
				data_101_110 when (min_rute = "101110") else
				data_101_111 when (min_rute = "101111") else
				data_110_000 when (min_rute = "110000") else
				data_110_001 when (min_rute = "110001") else
				data_110_010 when (min_rute = "110010") else
				data_110_011 when (min_rute = "110011") else
				data_110_100 when (min_rute = "110100") else
				data_110_101 when (min_rute = "110101") else
				data_110_110 when (min_rute = "110110") else
				data_110_111 when (min_rute = "110111") else
				data_111_000 when (min_rute = "111000") else
				data_111_001 when (min_rute = "111001") else
				data_111_010 when (min_rute = "111010") else
				data_111_011 when (min_rute = "111011") else
				data_111_100 when (min_rute = "111100") else
				data_111_101 when (min_rute = "111101") else
				data_111_110 when (min_rute = "111110") else
				data_111_111 when (min_rute = "111111") else
				no_path;
	
	
	process(reset, clock, clock2)
    begin
    if reset = '1' then
        data_min <= (others => 'Z');
    elsif clock'event and clock = '1' then
		if min_rute_v = '1' then
			data_min <= buff_min.list & buff_min.start;
		elsif clock2 = '1' then 
			for j in tracelength-1 downto 1 LOOP
                data_min(j-1) <= data_min(j);
            END LOOP;
                data_min(tracelength-1) <= data_min(0);
		end if;
    end if;
    end process;
	
	min_path <= data_min(0);
	
	PMC_000_000 : path_mem_cell
	generic	map(start_state => "000000")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_000(0),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_000_000,
        data_1    => data_000_001,
        buff_0    => buff_000_000,
        buff_1    => buff_000_001,
		--bit_tail  => bit_tail_reg(0),
        buff_out  => buff_000_000,
        data_out  => data_000_000
        ); 
	
	PMC_100_000 : path_mem_cell
	generic	map(start_state => "100000")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_000(1),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_000_000,
        data_1    => data_000_001,
        buff_0    => buff_000_000,
        buff_1    => buff_000_001,
		--bit_tail  => bit_tail_reg(32),
        buff_out  => buff_100_000,
        data_out  => data_100_000
        );   
	
	PMC_000_001 : path_mem_cell
	generic	map(start_state => "000001")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_000(2),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_000_010,
        data_1    => data_000_011,
        buff_0    => buff_000_010,
        buff_1    => buff_000_011,
		--bit_tail  => bit_tail_reg(1),
        buff_out  => buff_000_001,
        data_out  => data_000_001
        ); 
	
	PMC_100_001 : path_mem_cell
	generic	map(start_state => "100001")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_000(3),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_000_010,
        data_1    => data_000_011,
        buff_0    => buff_000_010,
        buff_1    => buff_000_011,
		--bit_tail  => bit_tail_reg(33),
        buff_out  => buff_100_001,
        data_out  => data_100_001
        );      
		
	PMC_000_010 : path_mem_cell
	generic	map(start_state => "000010")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_000(4),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_000_100,
        data_1    => data_000_101,
        buff_0    => buff_000_100,
        buff_1    => buff_000_101,
		--bit_tail  => bit_tail_reg(2),
        buff_out  => buff_000_010,
        data_out  => data_000_010
        ); 
	
	PMC_100_010 : path_mem_cell
	generic	map(start_state => "100010")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_000(5),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_000_100,
        data_1    => data_000_101,
        buff_0    => buff_000_100,
        buff_1    => buff_000_101,
		--bit_tail  => bit_tail_reg(34),
        buff_out  => buff_100_010,
        data_out  => data_100_010
        );   
	
	PMC_000_011 : path_mem_cell
	generic	map(start_state => "000011")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_000(6),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_000_110,
        data_1    => data_000_111,
        buff_0    => buff_000_110,
        buff_1    => buff_000_111,
		--bit_tail  => bit_tail_reg(3),
        buff_out  => buff_000_011,
        data_out  => data_000_011
        ); 
	
	PMC_100_011 : path_mem_cell
	generic	map(start_state => "100011")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_000(7),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_000_110,
        data_1    => data_000_111,
        buff_0    => buff_000_110,
        buff_1    => buff_000_111,
		--bit_tail  => bit_tail_reg(35),
        buff_out  => buff_100_011,
        data_out  => data_100_011
        );  
------------------------------------------------------------		
	PMC_000_100 : path_mem_cell
	generic	map(start_state => "000100")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_001(0),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_001_000,
        data_1    => data_001_001,
        buff_0    => buff_001_000,
        buff_1    => buff_001_001,
		--bit_tail  => bit_tail_reg(4),
        buff_out  => buff_000_100,
        data_out  => data_000_100
        ); 
	
	PMC_100_100 : path_mem_cell
	generic	map(start_state => "100100")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_001(1),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_001_000,
        data_1    => data_001_001,
        buff_0    => buff_001_000,
        buff_1    => buff_001_001,
		--bit_tail  => bit_tail_reg(36),
        buff_out  => buff_100_100,
        data_out  => data_100_100
        );   
	
	PMC_000_101 : path_mem_cell
	generic	map(start_state => "000101")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_001(2),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_001_010,
        data_1    => data_001_011,
        buff_0    => buff_001_010,
        buff_1    => buff_001_011,
		--bit_tail  => bit_tail_reg(5),
        buff_out  => buff_000_101,
        data_out  => data_000_101
        ); 
	
	PMC_100_101 : path_mem_cell
	generic	map(start_state => "100101")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_001(3),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_001_010,
        data_1    => data_001_011,
        buff_0    => buff_001_010,
        buff_1    => buff_001_011,
		--bit_tail  => bit_tail_reg(37),
        buff_out  => buff_100_101,
        data_out  => data_100_101
        );      
		
	PMC_000_110 : path_mem_cell
	generic	map(start_state => "000110")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_001(4),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_001_100,
        data_1    => data_001_101,
        buff_0    => buff_001_100,
        buff_1    => buff_001_101,
		--bit_tail  => bit_tail_reg(6),
        buff_out  => buff_000_110,
        data_out  => data_000_110
        ); 
	
	PMC_100_110 : path_mem_cell
	generic	map(start_state => "100110")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_001(5),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_001_100,
        data_1    => data_001_101,
        buff_0    => buff_001_100,
        buff_1    => buff_001_101,
		--bit_tail  => bit_tail_reg(38),
        buff_out  => buff_100_110,
        data_out  => data_100_110
        );   
	
	PMC_000_111 : path_mem_cell
	generic	map(start_state => "000111")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_001(6),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_001_110,
        data_1    => data_001_111,
        buff_0    => buff_001_110,
        buff_1    => buff_001_111,
		--bit_tail  => bit_tail_reg(7),
        buff_out  => buff_000_111,
        data_out  => data_000_111
        ); 
	
	PMC_100_111 : path_mem_cell
	generic	map(start_state => "100111")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_001(7),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_001_110,
        data_1    => data_001_111,
        buff_0    => buff_001_110,
        buff_1    => buff_001_111,
		--bit_tail  => bit_tail_reg(39),
        buff_out  => buff_100_111,
        data_out  => data_100_111
        );          
------------------------------------------------	
	PMC_001_000 : path_mem_cell
	generic	map(start_state => "001000")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_010(0),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_010_000,
        data_1    => data_010_001,
        buff_0    => buff_010_000,
        buff_1    => buff_010_001,
		--bit_tail  => bit_tail_reg(8),
        buff_out  => buff_001_000,
        data_out  => data_001_000
        ); 
	
	PMC_101_000 : path_mem_cell
	generic	map(start_state => "101000")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_010(1),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_010_000,
        data_1    => data_010_001,
        buff_0    => buff_010_000,
        buff_1    => buff_010_001,
		--bit_tail  => bit_tail_reg(40),
        buff_out  => buff_101_000,
        data_out  => data_101_000
        );   
	
	PMC_001_001 : path_mem_cell
	generic	map(start_state => "001001")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_010(2),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_010_010,
        data_1    => data_010_011,
        buff_0    => buff_010_010,
        buff_1    => buff_010_011,
		--bit_tail  => bit_tail_reg(9),
        buff_out  => buff_001_001,
        data_out  => data_001_001
        ); 
	
	PMC_101_001 : path_mem_cell
	generic	map(start_state => "101001")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_010(3),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_010_010,
        data_1    => data_010_011,
        buff_0    => buff_010_010,
        buff_1    => buff_010_011,
		--bit_tail  => bit_tail_reg(41),
        buff_out  => buff_101_001,
        data_out  => data_101_001
        );      
		
	PMC_001_010 : path_mem_cell
	generic	map(start_state => "001010")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_010(4),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_010_100,
        data_1    => data_010_101,
        buff_0    => buff_010_100,
        buff_1    => buff_010_101,
		--bit_tail  => bit_tail_reg(10),
        buff_out  => buff_001_010,
        data_out  => data_001_010
        ); 
	
	PMC_101_010 : path_mem_cell
	generic	map(start_state => "101010")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_010(5),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_010_100,
        data_1    => data_010_101,
        buff_0    => buff_010_100,
        buff_1    => buff_010_101,
		--bit_tail  => bit_tail_reg(42),
        buff_out  => buff_101_010,
        data_out  => data_101_010
        );   
	
	PMC_001_011 : path_mem_cell
	generic	map(start_state => "001011")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_010(6),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_010_110,
        data_1    => data_010_111,
        buff_0    => buff_010_110,
        buff_1    => buff_010_111,
		--bit_tail  => bit_tail_reg(11),
        buff_out  => buff_001_011,
        data_out  => data_001_011
        ); 
	
	PMC_101_011 : path_mem_cell
	generic	map(start_state => "101011")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_010(7),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_010_110,
        data_1    => data_010_111,
        buff_0    => buff_010_110,
        buff_1    => buff_010_111,
		--bit_tail  => bit_tail_reg(43),
        buff_out  => buff_101_011,
        data_out  => data_101_011
        );  
------------------------------------------------------------		
	PMC_001_100 : path_mem_cell
	generic	map(start_state => "001100")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_011(0),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_011_000,
        data_1    => data_011_001,
        buff_0    => buff_011_000,
        buff_1    => buff_011_001,
		--bit_tail  => bit_tail_reg(12),
        buff_out  => buff_001_100,
        data_out  => data_001_100
        ); 
	
	PMC_101_100 : path_mem_cell
	generic	map(start_state => "101100")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_011(1),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_011_000,
        data_1    => data_011_001,
        buff_0    => buff_011_000,
        buff_1    => buff_011_001,
		--bit_tail  => bit_tail_reg(44),
        buff_out  => buff_101_100,
        data_out  => data_101_100
        );   
	
	PMC_001_101 : path_mem_cell
	generic	map(start_state => "001101")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_011(2),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_011_010,
        data_1    => data_011_011,
        buff_0    => buff_011_010,
        buff_1    => buff_011_011,
		--bit_tail  => bit_tail_reg(13),
        buff_out  => buff_001_101,
        data_out  => data_001_101
        ); 
	
	PMC_101_101 : path_mem_cell
	generic	map(start_state => "101101")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_011(3),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_011_010,
        data_1    => data_011_011,
        buff_0    => buff_011_010,
        buff_1    => buff_011_011,
		--bit_tail  => bit_tail_reg(45),
        buff_out  => buff_101_101,
        data_out  => data_101_101
        );      
		
	PMC_001_110 : path_mem_cell
	generic	map(start_state => "001110")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_011(4),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_011_100,
        data_1    => data_011_101,
        buff_0    => buff_011_100,
        buff_1    => buff_011_101,
		--bit_tail  => bit_tail_reg(14),
        buff_out  => buff_001_110,
        data_out  => data_001_110
        ); 
	
	PMC_101_110 : path_mem_cell
	generic	map(start_state => "101110")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_011(5),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_011_100,
        data_1    => data_011_101,
        buff_0    => buff_011_100,
        buff_1    => buff_011_101,
		--bit_tail  => bit_tail_reg(46),
        buff_out  => buff_101_110,
        data_out  => data_101_110
        );   
	
	PMC_001_111 : path_mem_cell
	generic	map(start_state => "001111")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_011(6),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_011_110,
        data_1    => data_011_111,
        buff_0    => buff_011_110,
        buff_1    => buff_011_111,
		--bit_tail  => bit_tail_reg(15),
        buff_out  => buff_001_111,
        data_out  => data_001_111
        ); 
	
	PMC_101_111 : path_mem_cell
	generic	map(start_state => "101111")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_011(7),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_011_110,
        data_1    => data_011_111,
        buff_0    => buff_011_110,
        buff_1    => buff_011_111,
		--bit_tail  => bit_tail_reg(47),
        buff_out  => buff_101_111,
        data_out  => data_101_111
        );          
------------------------------------------------
------------------------------------------------
	PMC_010_000 : path_mem_cell
	generic	map(start_state => "010000")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_100(0),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_100_000,
        data_1    => data_100_001,
        buff_0    => buff_100_000,
        buff_1    => buff_100_001,
		--bit_tail  => bit_tail_reg(16),
        buff_out  => buff_010_000,
        data_out  => data_010_000
        ); 
	
	PMC_110_000 : path_mem_cell
	generic	map(start_state => "110000")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_100(1),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_100_000,
        data_1    => data_100_001,
        buff_0    => buff_100_000,
        buff_1    => buff_100_001,
		--bit_tail  => bit_tail_reg(48),
        buff_out  => buff_110_000,
        data_out  => data_110_000
        );   
	
	PMC_010_001 : path_mem_cell
	generic	map(start_state => "010001")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_100(2),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_100_010,
        data_1    => data_100_011,
        buff_0    => buff_100_010,
        buff_1    => buff_100_011,
		--bit_tail  => bit_tail_reg(17),
        buff_out  => buff_010_001,
        data_out  => data_010_001
        ); 
	
	PMC_110_001 : path_mem_cell
	generic	map(start_state => "110001")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_100(3),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_100_010,
        data_1    => data_100_011,
        buff_0    => buff_100_010,
        buff_1    => buff_100_011,
		--bit_tail  => bit_tail_reg(49),
        buff_out  => buff_110_001,
        data_out  => data_110_001
        );      
		
	PMC_010_010 : path_mem_cell
	generic	map(start_state => "010010")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_100(4),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_100_100,
        data_1    => data_100_101,
        buff_0    => buff_100_100,
        buff_1    => buff_100_101,
		--bit_tail  => bit_tail_reg(18),
        buff_out  => buff_010_010,
        data_out  => data_010_010
        ); 
	
	PMC_110_010 : path_mem_cell
	generic	map(start_state => "110010")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_100(5),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_100_100,
        data_1    => data_100_101,
        buff_0    => buff_100_100,
        buff_1    => buff_100_101,
		--bit_tail  => bit_tail_reg(50),
        buff_out  => buff_110_010,
        data_out  => data_110_010
        );   
	
	PMC_010_011 : path_mem_cell
	generic	map(start_state => "010011")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_100(6),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_100_110,
        data_1    => data_100_111,
        buff_0    => buff_100_110,
        buff_1    => buff_100_111,
		--bit_tail  => bit_tail_reg(19),
        buff_out  => buff_010_011,
        data_out  => data_010_011
        ); 
	
	PMC_110_011 : path_mem_cell
	generic	map(start_state => "110011")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_100(7),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_100_110,
        data_1    => data_100_111,
        buff_0    => buff_100_110,
        buff_1    => buff_100_111,
		--bit_tail  => bit_tail_reg(51),
        buff_out  => buff_110_011,
        data_out  => data_110_011
        );  
------------------------------------------------------------		
	PMC_010_100 : path_mem_cell
	generic	map(start_state => "010100")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_101(0),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_101_000,
        data_1    => data_101_001,
        buff_0    => buff_101_000,
        buff_1    => buff_101_001,
		--bit_tail  => bit_tail_reg(20),
        buff_out  => buff_010_100,
        data_out  => data_010_100
        ); 
	
	PMC_110_100 : path_mem_cell
	generic	map(start_state => "110100")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_101(1),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_101_000,
        data_1    => data_101_001,
        buff_0    => buff_101_000,
        buff_1    => buff_101_001,
		--bit_tail  => bit_tail_reg(52),
        buff_out  => buff_110_100,
        data_out  => data_110_100
        );   
	
	PMC_010_101 : path_mem_cell
	generic	map(start_state => "010101")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_101(2),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_101_010,
        data_1    => data_101_011,
        buff_0    => buff_101_010,
        buff_1    => buff_101_011,
		--bit_tail  => bit_tail_reg(21),
        buff_out  => buff_010_101,
        data_out  => data_010_101
        ); 
	
	PMC_110_101 : path_mem_cell
	generic	map(start_state => "110101")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_101(3),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_101_010,
        data_1    => data_101_011,
        buff_0    => buff_101_010,
        buff_1    => buff_101_011,
		--bit_tail  => bit_tail_reg(53),
        buff_out  => buff_110_101,
        data_out  => data_110_101
        );      
		
	PMC_010_110 : path_mem_cell
	generic	map(start_state => "010110")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_101(4),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_101_100,
        data_1    => data_101_101,
        buff_0    => buff_101_100,
        buff_1    => buff_101_101,
		--bit_tail  => bit_tail_reg(22),
        buff_out  => buff_010_110,
        data_out  => data_010_110
        ); 
	
	PMC_110_110 : path_mem_cell
	generic	map(start_state => "110110")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_101(5),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_101_100,
        data_1    => data_101_101,
        buff_0    => buff_101_100,
        buff_1    => buff_101_101,
		--bit_tail  => bit_tail_reg(54),
        buff_out  => buff_110_110,
        data_out  => data_110_110
        );   
	
	PMC_010_111 : path_mem_cell
	generic	map(start_state => "010111")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_101(6),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_101_110,
        data_1    => data_101_111,
        buff_0    => buff_101_110,
        buff_1    => buff_101_111,
		--bit_tail  => bit_tail_reg(23),
        buff_out  => buff_010_111,
        data_out  => data_010_111
        ); 
	
	PMC_110_111 : path_mem_cell
	generic	map(start_state => "110111")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_101(7),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_101_110,
        data_1    => data_101_111,
        buff_0    => buff_101_110,
        buff_1    => buff_101_111,
		--bit_tail  => bit_tail_reg(55),
        buff_out  => buff_110_111,
        data_out  => data_110_111
        );          
------------------------------------------------	
	PMC_011_000 : path_mem_cell
	generic	map(start_state => "011000")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_110(0),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_110_000,
        data_1    => data_110_001,
        buff_0    => buff_110_000,
        buff_1    => buff_110_001,
		--bit_tail  => bit_tail_reg(24),
        buff_out  => buff_011_000,
        data_out  => data_011_000
        ); 
	
	PMC_111_000 : path_mem_cell
	generic	map(start_state => "111000")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_110(1),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_110_000,
        data_1    => data_110_001,
        buff_0    => buff_110_000,
        buff_1    => buff_110_001,
		--bit_tail  => bit_tail_reg(56),
        buff_out  => buff_111_000,
        data_out  => data_111_000
        );   
	
	PMC_011_001 : path_mem_cell
	generic	map(start_state => "011001")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_110(2),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_110_010,
        data_1    => data_110_011,
        buff_0    => buff_110_010,
        buff_1    => buff_110_011,
		--bit_tail  => bit_tail_reg(25),
        buff_out  => buff_011_001,
        data_out  => data_011_001
        ); 
	
	PMC_111_001 : path_mem_cell
	generic	map(start_state => "111001")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_110(3),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_110_010,
        data_1    => data_110_011,
        buff_0    => buff_110_010,
        buff_1    => buff_110_011,
		--bit_tail  => bit_tail_reg(57),
        buff_out  => buff_111_001,
        data_out  => data_111_001
        );      
		
	PMC_011_010 : path_mem_cell
	generic	map(start_state => "011010")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_110(4),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_110_100,
        data_1    => data_110_101,
        buff_0    => buff_110_100,
        buff_1    => buff_110_101,
		--bit_tail  => bit_tail_reg(26),
        buff_out  => buff_011_010,
        data_out  => data_011_010
        ); 
	
	PMC_111_010 : path_mem_cell
	generic	map(start_state => "111010")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_110(5),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_110_100,
        data_1    => data_110_101,
        buff_0    => buff_110_100,
        buff_1    => buff_110_101,
		--bit_tail  => bit_tail_reg(58),
        buff_out  => buff_111_010,
        data_out  => data_111_010
        );   
	
	PMC_011_011 : path_mem_cell
	generic	map(start_state => "011011")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_110(6),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_110_110,
        data_1    => data_110_111,
        buff_0    => buff_110_110,
        buff_1    => buff_110_111,
		--bit_tail  => bit_tail_reg(27),
        buff_out  => buff_011_011,
        data_out  => data_011_011
        ); 
	
	PMC_111_011 : path_mem_cell
	generic	map(start_state => "111011")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_110(7),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_110_110,
        data_1    => data_110_111,
        buff_0    => buff_110_110,
        buff_1    => buff_110_111,
		--bit_tail  => bit_tail_reg(59),
        buff_out  => buff_111_011,
        data_out  => data_111_011
        );  
------------------------------------------------------------		
	PMC_011_100 : path_mem_cell
	generic	map(start_state => "011100")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_111(0),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_111_000,
        data_1    => data_111_001,
        buff_0    => buff_111_000,
        buff_1    => buff_111_001,
		--bit_tail  => bit_tail_reg(28),
        buff_out  => buff_011_100,
        data_out  => data_011_100
        ); 
	
	PMC_111_100 : path_mem_cell
	generic	map(start_state => "111100")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_111(1),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_111_000,
        data_1    => data_111_001,
        buff_0    => buff_111_000,
        buff_1    => buff_111_001,
		--bit_tail  => bit_tail_reg(60),
        buff_out  => buff_111_100,
        data_out  => data_111_100
        );   
	
	PMC_011_101 : path_mem_cell
	generic	map(start_state => "011101")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_111(2),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_111_010,
        data_1    => data_111_011,
        buff_0    => buff_111_010,
        buff_1    => buff_111_011,
		--bit_tail  => bit_tail_reg(29),
        buff_out  => buff_011_101,
        data_out  => data_011_101
        ); 
	
	PMC_111_101 : path_mem_cell
	generic	map(start_state => "111101")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_111(3),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_111_010,
        data_1    => data_111_011,
        buff_0    => buff_111_010,
        buff_1    => buff_111_011,
		--bit_tail  => bit_tail_reg(61),
        buff_out  => buff_111_101,
        data_out  => data_111_101
        );      
		
	PMC_011_110 : path_mem_cell
	generic	map(start_state => "011110")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_111(4),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_111_100,
        data_1    => data_111_101,
        buff_0    => buff_111_100,
        buff_1    => buff_111_101,
		--bit_tail  => bit_tail_reg(30),
        buff_out  => buff_011_110,
        data_out  => data_011_110
        ); 
	
	PMC_111_110 : path_mem_cell
	generic	map(start_state => "111110")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_111(5),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_111_100,
        data_1    => data_111_101,
        buff_0    => buff_111_100,
        buff_1    => buff_111_101,
		--bit_tail  => bit_tail_reg(62),
        buff_out  => buff_111_110,
        data_out  => data_111_110
        );   
	
	PMC_011_111 : path_mem_cell
	generic	map(start_state => "011111")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_111(6),
        bit_in	  => '0',
        datcount  => datcount,
        data_0    => data_111_110,
        data_1    => data_111_111,
        buff_0    => buff_111_110,
        buff_1    => buff_111_111,
		--bit_tail  => bit_tail_reg(31),
        buff_out  => buff_011_111,
        data_out  => data_011_111
        ); 
	
	PMC_111_111 : path_mem_cell
	generic	map(start_state => "111111")
    port map(
        ram_reset => ram_reset,
		clock     => clock,
        store_vld => store_vld,
        buff_vld  => buff_vld,
        buff_end  => buff_end,
        rute	  => rute_111(7),
        bit_in	  => '1',
        datcount  => datcount,
        data_0    => data_111_110,
        data_1    => data_111_111,
        buff_0    => buff_111_110,
        buff_1    => buff_111_111,
		--bit_tail  => bit_tail_reg(63),
        buff_out  => buff_111_111,
        data_out  => data_111_111
        );          
------------------------------------------------


	


end architecture;       