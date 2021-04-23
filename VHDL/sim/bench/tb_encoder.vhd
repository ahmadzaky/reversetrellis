library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library viterbilib;
use viterbilib.viterbi_package.all;

entity tb_encoder is
  generic ( one_period   : Time := 120 ns;
            vector_test  : std_logic_vector(63 downto 0) := "0001101010110101100111010101111100011101010101001110100010011110");
  end entity;                                                                                                                             --
    
architecture struct of tb_encoder is
	signal s_clock     : std_logic;
	signal s_clock2    : std_logic;
	signal s_clock6    : std_logic;
	signal s_reset     : std_logic;
	signal s_data      : std_logic;
	signal s_conv_data : std_logic;
	signal s_conv_data_par  : std_logic_vector(2 downto 0);
	signal test_data   : std_logic_vector(63 downto 0);
	signal out_decode  : std_logic;
	signal expect_code : std_logic;
	signal code_lat    : std_logic_vector(tracelength downto 0); 
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
	wait for one_period/3;
	s_clock <= '0';
	wait for one_period/3;
	end process;
	
	process
	begin
	s_clock2 <= '1';
	wait for (one_period*2)/3;
	s_clock2 <= '0';
	wait for (one_period*2)/3;
	end process;
	
	process
	begin
	s_clock6 <= '1';
	wait for one_period*2;
	s_clock6 <= '0';
	wait for one_period*2;
	end process;

	process(s_clock, s_reset)
	begin
	if s_reset = '1' then 
		test_data <= vector_test;
	elsif s_clock6'event and s_clock6 = '1' then
		 for j in 63 downto 1 LOOP
                test_data(j) <= test_data(j-1);
            END LOOP;
                test_data(0) <= test_data(63);
	end if;
	end process;

	s_data <= test_data(63);
	
	ENC : encoder_top
    port map (
        clock   => s_clock,
        reset   => s_reset,
        datain  => s_data,
        dataout => s_conv_data
		);
		
    SP : ser_par
    port map(
        reset	 => s_reset,
		clock2   => s_clock2,
		clock6   => s_clock6,
        datain   => s_conv_data,
		dataout  => s_conv_data_par
        );

end architecture;       