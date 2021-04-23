library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.viterbi_package.all;

entity tb_systol_vit is
  generic ( one_period   : Time := 50 ns;
    --        vector_test  : std_logic_vector(63 downto 0) := "1111111010110101100111010101111100011101010101001110100010011110";
      --     vector_test  : std_logic_vector(63 downto 0) := "1000011010110111000111010101000011101000100111101011001110101011";--);
             vector_test  : std_logic_vector(39 downto 0) := "0001100001101100100111110110110011100010";
      --       vector_test  : std_logic_vector(63 downto 0) := "0011011000110111000111010101001111101000000111101011001100011000";
       --     vector_test  : std_logic_vector(63 downto 0)   := "0011111111111111111100000000000000000000000000000000000000000000";
            error_vector : std_logic_vector((3*tracelength)-1 downto 0) := "110100010000010100000001000000001000101010000000100010100100001100000000010000000001010000000011000000010100000001000000");
  --  error_vector : std_logic_vector((3*tracelength)-1 downto 0) := "000000001010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000101000000010000000100000001000000100000001000000010000000100000001");
  --  error_vector : std_logic_vector((3*tracelength)-1 downto 0) := "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
    end entity;                                                                                                                            --
																	
architecture struct of tb_systol_vit is
	signal s_clock     : std_logic;
	signal s_hclock    : std_logic;
	signal s_valid     : std_logic;
	signal s_reset     : std_logic;
	signal s_data      : std_logic;
	signal s_conv_data : std_logic_vector(2 downto 0);
	signal s_err_data  : std_logic_vector(2 downto 0);
	signal test_data   : std_logic_vector(tracelength-1 downto 0);
	signal err_data    : std_logic_vector(119 downto 0);
	signal out_decode  : std_logic;
	signal expect_code : std_logic;
	signal code_lat    : std_logic_vector(tracelength+19 downto 0); 
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
	
	process
	begin
	s_valid <= '0';
	wait for one_period*15;
	s_valid <= '1';
	wait;
	end process;
	
	process
	begin
	s_hclock <= '0';
	wait for one_period;
	s_hclock <= '1';
	wait for one_period;
	end process;

	process(s_hclock, s_reset)
	begin
	if s_reset = '1' then 
		test_data <= vector_test;
	elsif s_hclock'event and s_hclock = '1' then
		 for j in tracelength-1 downto 1 LOOP
                test_data(j) <= test_data(j-1);
            END LOOP;
                test_data(0) <= test_data(tracelength-1);
	end if;
	end process;

	process(s_hclock, s_reset)
	begin
	if s_reset = '1' then 
		err_data <= error_vector;
	elsif s_hclock'event and s_hclock = '1' then
		 for j in 119 downto 3 LOOP
                err_data(j) <= err_data(j-3);
            END LOOP;
                err_data(2) <= err_data(119);
                err_data(1) <= err_data(118);
                err_data(0) <= err_data(117);
	end if;
	end process;
    
	s_err_data(2) <= err_data(119) xor s_conv_data(2);
	s_err_data(1) <= err_data(118) xor s_conv_data(1);
	s_err_data(0) <= err_data(117) xor s_conv_data(0);
	
	
    process(s_hclock, s_reset)
	begin
	if s_reset = '1' then 
		code_lat <= (others => '0');
	elsif s_hclock'event and s_hclock = '1' then
		 for j in tracelength+19 downto 1 LOOP
                code_lat(j) <= code_lat(j-1);
            END LOOP;
        code_lat(0) <= s_data;    
        expect_code <= code_lat(tracelength+19);
        assert out_decode = expect_code
        report "ERROR: FALSE DATA RECEIVED"
        severity warning;
   --     assert out_decode /= expect_code
   --     report "CORRECT DATA RECEIVED "
   --     severity note;
	end if;
	end process;
	
	--s_valid <= s_hclock and s_clock;
        

	s_data <= test_data(tracelength-1);
	
	ENC : encoder_top
    port map (
        clock   => s_hclock,
        reset   => s_reset,
        datain  => s_data,
        dataout => s_conv_data
		);
    
    -- ER : error_generator 
    -- generic map(error_vector => error_vector)
    -- port map(
        -- clock    => s_hclock,
        -- reset    => s_reset,
        -- datain   => s_conv_data,
        -- dataout  => s_err_data
        -- );
        
    DUT : decoder_top
    port map(
        reset	 => s_reset,
		clock    => s_clock,
        datain   => s_err_data,
		valid    => s_valid,
		dataout  => out_decode
        );
        

end architecture;       