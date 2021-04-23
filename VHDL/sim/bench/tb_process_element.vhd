library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library viterbilib;
use viterbilib.viterbi_package.all;

entity tb_process_element is
  generic ( one_period   : Time := 100 ns;
            vector_test  : std_logic_vector(63 downto 0) := "0001101010110101100111010101111100011101010101001110100010011110");
  end entity;                                                                                                                             --
    
architecture struct of tb_process_element is
	signal s_clock   : std_logic;
	signal s_reset   : std_logic;
	signal s_newdata : std_logic;
	signal s_data    : std_logic_vector(2 downto 0);
	signal test_data : std_logic_vector(63 downto 0);
	

    signal rute_000_s 	 : path;
    signal rute_001_s	 : path;
    signal rute_010_s 	 : path;
    signal rute_011_s	 : path;
    signal rute_100_s 	 : path;
    signal rute_101_s	 : path;
    signal rute_110_s 	 : path;
    signal rute_111_s    : path;
    signal rute_000_o 	 : path;
    signal rute_001_o	 : path;
    signal rute_010_o 	 : path;
    signal rute_011_o	 : path;
    signal rute_100_o 	 : path;
    signal rute_101_o	 : path;
    signal rute_110_o 	 : path;
    signal rute_111_o    : path;
	
begin       
	
	process
	begin
	s_reset <= '1';
	wait for one_period;
	s_reset <= '0';
	wait;
	end process;
	
	process
	begin
	s_clock <= '1';
	wait for one_period/2;
	s_clock <= '0';
	wait for one_period/2;
	end process;
	


    s_newdata <= '1';
	
	process(s_clock, s_reset)
	begin
	if s_reset = '1' then 
		test_data <= vector_test;
	elsif s_clock'event and s_clock = '1' then
		 for j in 63 downto 1 LOOP
                test_data(j) <= test_data(j-1);
            END LOOP;
                test_data(0) <= test_data(63);
	end if;
	end process;

	s_data <= test_data(63 downto 61);
	
	rute_000_s  <= ("0000000000000000000000000000000000000000000000000000000000000001", "0000000000000000000000000000000000000000000000000000000000000000");
	rute_001_s  <= ("0000000000000000000000000000000000000000000000000000000000000010", "0101010101010101010101010101010101010101010101010101010101010101");
	rute_010_s  <= ("0000000000000000000000000000000000000000000000000000000000001000", "0011001100110011001100110011001100110011001100110011001100110011");
	rute_011_s  <= ("0000000000000000000000000000000000000000000000000000000001000000", "0000111100001111000011110000111100001111000011110000111100001111");
	rute_100_s  <= ("0000000000000000000000000000000000000000000000000000001000000000", "0000000011111111000000001111111100000000111111110000000011111111");
	rute_101_s  <= ("0000000000000000000000000000000000000000000000000001000000000000", "0000000000000000000000001111111111111111111111110000000000000000");
	rute_110_s  <= ("0000000000000000000000000000000000000000000000001000000000000000", "1111111111111111111111111111111100000000000000000000000000000000");
	rute_111_s  <= ("0000000000000000000000000000000000000000000001000000000000000000", "1111111111111111111111111111111111111111111111111111111111111111");
	
	PE : process_element
	generic map( PE_ID => "000001010011100101110111000001010011100101110111")
    port map (
	    clock        => s_clock,
        reset        => s_reset,
        newdata      => s_newdata,
        state_count  => 0,
        datain       => s_data,
        rute_000_i 	 => rute_000_s,
        rute_001_i	 => rute_001_s,
        rute_010_i 	 => rute_010_s,
        rute_011_i	 => rute_011_s,
        rute_100_i 	 => rute_100_s,
        rute_101_i	 => rute_101_s,
        rute_110_i 	 => rute_110_s,
        rute_111_i	 => rute_111_s,
        rute_0_00 	 => rute_000_o,
        rute_0_01	 => rute_001_o,
        rute_0_10 	 => rute_010_o,
        rute_0_11	 => rute_011_o,
        rute_1_00 	 => rute_100_o,
        rute_1_01	 => rute_101_o,
        rute_1_10 	 => rute_110_o,
        rute_1_11	 => rute_111_o
		);
		

end architecture;       