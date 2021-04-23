library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


library work;
use work.viterbi_package.all;

entity reverse_trellis is
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
    end entity;
    
architecture struct of reverse_trellis is
    
    signal din    : std_logic_vector(2 downto 0);
    signal count  : integer range 0 to 7;
	signal first_buff : tail_buff;
	signal first_seq  : tail_buff;
	

begin   
    	  
	reverse_valid <= '1' when (datcount = 7) else '0';
	
	process(clock, reset)
	begin
	if reset = '1' then
        for j in 5 downto 0 LOOP
			first_seq(j) <= (others => '0') ;
        END LOOP;
	elsif clock'event and clock = '1' then
		if 	(datcount < 6) then
			first_seq(datcount) <= datain;
		end if;
	end if;
	end process;
	
	process(reset, clock, valid, datcount)
    begin
    if reset = '1' then
		for j in 5 downto 0 LOOP
			first_buff(j) <= (others => '0') ;
		END LOOP; 
    elsif clock'event and clock = '1' then
		if datcount = 16 then
			first_buff <= first_seq;
		elsif valid = '1' then
			for j in 5 downto 1 LOOP
				first_buff(j) <= first_buff(j-1) ;
			END LOOP;
			first_buff(0) <= (others => 'Z');
		end if;
    end if;
    end process;

	din <= first_buff(5);
	
	
	rtu_000_000 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(0),
        start_rute(5 downto 0)	 => "000000",
        path_cost    => start_000(0)
        );
	
	rtu_000_001 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(1),
        start_rute(5 downto 0)	 => "000001",
        path_cost    => start_000(1)
        );
	
	rtu_000_010 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(2), 
        start_rute(5 downto 0)	 => "000010",
        path_cost    => start_000(2)
        );
	
	rtu_000_011 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(3), 
        start_rute(5 downto 0)	 => "000011",
        path_cost    => start_000(3)
        );
	
	rtu_000_100 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(4), 
        start_rute(5 downto 0)	 => "000100",
        path_cost    => start_000(4)
        );
	
	rtu_000_101 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(5), 
        start_rute(5 downto 0)	 => "000101",
        path_cost    => start_000(5)
        );
	
	rtu_000_110 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(6), 
        start_rute(5 downto 0)	 => "000111",
        path_cost    => start_000(6)
        );
	
	rtu_000_111 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(7), 
        start_rute(5 downto 0)	 => "000111",
        path_cost    => start_000(7)
        );
		
	rtu_001_000 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(8), 
        start_rute(5 downto 0)	 => "001000",
        path_cost    => start_001(0)
        );
		
	rtu_001_001 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(9), 
        start_rute(5 downto 0)	 => "001001",
        path_cost    => start_001(1)
        );
		
	rtu_001_010 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(10), 
        start_rute(5 downto 0)	 => "001010",
        path_cost    => start_001(2)
        );
		
	rtu_001_011 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(11), 
        start_rute(5 downto 0)	 => "001011",
        path_cost    => start_001(3)
        );
		
	rtu_001_100 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(12), 
        start_rute(5 downto 0)	 => "001100",
        path_cost    => start_001(4)
        );
		
	rtu_001_101 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(13), 
        start_rute(5 downto 0)	 => "001101",
        path_cost    => start_001(5)
        );
		
	rtu_001_110 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(14), 
        start_rute(5 downto 0)	 => "001110",
        path_cost    => start_001(6)
        );
		
	rtu_001_111 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(15), 
        start_rute(5 downto 0)	 => "001111",
        path_cost    => start_001(7)
        );
	
	rtu_010_000 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(16), 
        start_rute(5 downto 0)	 => "010000",
        path_cost    => start_010(0)
        );
	
	rtu_010_001 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(17), 
        start_rute(5 downto 0)	 => "010001",
        path_cost    => start_010(1)
        );
	
	rtu_010_010 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(18), 
        start_rute(5 downto 0)	 => "010010",
        path_cost    => start_010(2)
        );
	
	rtu_010_011 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(19), 
        start_rute(5 downto 0)	 => "010011",
        path_cost    => start_010(3)
        );
	
	rtu_010_100 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(20), 
        start_rute(5 downto 0)	 => "010100",
        path_cost    => start_010(4)
        );
	
	rtu_010_101 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(21), 
        start_rute(5 downto 0)	 => "010101",
        path_cost    => start_010(5)
        );
	
	rtu_010_110 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(22), 
        start_rute(5 downto 0)	 => "010110",
        path_cost    => start_010(6)
        );
	
	rtu_010_111 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(23), 
        start_rute(5 downto 0)	 => "010111",
        path_cost    => start_010(7)
        );
	
	rtu_011_000 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(24), 
        start_rute(5 downto 0)	 => "011000",
        path_cost    => start_011(0)
        );
		
	rtu_011_001 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(25), 
        start_rute(5 downto 0)	 => "011001",
        path_cost    => start_011(1)
        );
		
	rtu_011_010 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(26), 
        start_rute(5 downto 0)	 => "011010",
        path_cost    => start_011(2)
        );
		
	rtu_011_011 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(27), 
        start_rute(5 downto 0)	 => "011011",
        path_cost    => start_011(3)
        );
		
	rtu_011_100 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(28), 
        start_rute(5 downto 0)	 => "011100",
        path_cost    => start_011(4)
        );
		
	rtu_011_101 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(29), 
        start_rute(5 downto 0)	 => "011101",
        path_cost    => start_011(5)
        );
		
	rtu_011_110 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(30), 
        start_rute(5 downto 0)	 => "011110",
        path_cost    => start_011(6)
        );
		
	rtu_011_111 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(31), 
        start_rute(5 downto 0)	 => "011111",
        path_cost    => start_011(7)
        );
	
	rtu_100_000 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(32), 
        start_rute(5 downto 0)	 => "100000",
        path_cost    => start_100(0)
        );
	
	rtu_100_001 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(33), 
        start_rute(5 downto 0)	 => "100001",
        path_cost    => start_100(1)
        );
	
	rtu_100_010 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(34), 
        start_rute(5 downto 0)	 => "100010",
        path_cost    => start_100(2)
        );
	
	rtu_100_011 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(35), 
        start_rute(5 downto 0)	 => "100011",
        path_cost    => start_100(3)
        );
	
	rtu_100_100 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(36), 
        start_rute(5 downto 0)	 => "100100",
        path_cost    => start_100(4)
        );
	
	rtu_100_101 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(37), 
        start_rute(5 downto 0)	 => "100101",
        path_cost    => start_100(5)
        );
	
	rtu_100_110 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(38), 
        start_rute(5 downto 0)	 => "100110",
        path_cost    => start_100(6)
        );
	
	rtu_100_111 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(39), 
        start_rute(5 downto 0)	 => "100111",
        path_cost    => start_100(7)
        );
	
	rtu_101_000 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(40), 
        start_rute(5 downto 0)	 => "101000",
        path_cost    => start_101(0)
        );
	
	rtu_101_001 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(41), 
        start_rute(5 downto 0)	 => "101001",
        path_cost    => start_101(1)
        );
	
	rtu_101_010 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(42), 
        start_rute(5 downto 0)	 => "101010",
        path_cost    => start_101(2)
        );
	
	rtu_101_011 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(43), 
        start_rute(5 downto 0)	 => "101011",
        path_cost    => start_101(3)
        );
	
	rtu_101_100 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(44), 
        start_rute(5 downto 0)	 => "101100",
        path_cost    => start_101(4)
        );
	
	rtu_101_101 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(45), 
        start_rute(5 downto 0)	 => "101101",
        path_cost    => start_101(5)
        );
	
	rtu_101_110 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(46), 
        start_rute(5 downto 0)	 => "101110",
        path_cost    => start_101(6)
        );
	
	rtu_101_111 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(47), 
        start_rute(5 downto 0)	 => "101111",
        path_cost    => start_101(7)
        );
	
	rtu_110_000 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(48), 
        start_rute(5 downto 0)	 => "110000",
        path_cost    => start_110(0)
        );
	
	rtu_110_001 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(49), 
        start_rute(5 downto 0)	 => "110001",
        path_cost    => start_110(1)
        );
	
	rtu_110_010 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(50), 
        start_rute(5 downto 0)	 => "110010",
        path_cost    => start_110(2)
        );
	
	rtu_110_011 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(51), 
        start_rute(5 downto 0)	 => "110011",
        path_cost    => start_110(3)
        );
	
	rtu_110_100 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(52), 
        start_rute(5 downto 0)	 => "110100",
        path_cost    => start_110(4)
        );
	
	rtu_110_101 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(53), 
        start_rute(5 downto 0)	 => "110101",
        path_cost    => start_110(5)
        );
	
	rtu_110_110 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(54), 
        start_rute(5 downto 0)	 => "110110",
        path_cost    => start_110(6)
        );
	
	rtu_110_111 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(55), 
        start_rute(5 downto 0)	 => "110111",
        path_cost    => start_110(7)
        );
	
	rtu_111_000 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(56), 
        start_rute(5 downto 0)	 => "111000",
        path_cost    => start_111(0)
        );	
	
	rtu_111_001 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(57), 
        start_rute(5 downto 0)	 => "111001",
        path_cost    => start_111(1)
        );	
	
	rtu_111_010 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(58), 
        start_rute(5 downto 0)	 => "111010",
        path_cost    => start_111(2)
        );	
	
	rtu_111_011 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(59), 
        start_rute(5 downto 0)	 => "111011",
        path_cost    => start_111(3)
        );	
	
	rtu_111_100 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(60), 
        start_rute(5 downto 0)	 => "111100",
        path_cost    => start_111(4)
        );	
	
	rtu_111_101 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(61), 
        start_rute(5 downto 0)	 => "111101",
        path_cost    => start_111(5)
        );	
	
	rtu_111_110 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(62), 
        start_rute(5 downto 0)	 => "111110",
        path_cost    => start_111(6)
        );	
	
	rtu_111_111 :reverse_trellis_unit
    port map(
        clock        => clock,
        reset        => reset,
        valid        => valid,
        data_i       => din,
        start_rute(11 downto 6)	 => start_rute(63), 
        start_rute(5 downto 0)	 => "111111",
        path_cost    => start_111(7)
        );	
		
end architecture;       