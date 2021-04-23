library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.viterbi_package.all;

entity encoder_top is
    port(
        clock  : in  std_logic;
        reset  : in  std_logic;
        datain : in  std_logic;
        dataout: out std_logic_vector(2 downto 0));
    end entity;
    
architecture struct of encoder_top is
	signal clock2  	 : std_logic;
	signal clock6 	 : std_logic;
	signal clk_count : std_logic_vector(1 downto 0);
	--signal s_pardata : std_logic_vector(2 downto 0); 
	
begin       

	i_clkdiv : clock_divide
    port map(
        reset	  => reset,
		clock     => clock,
        clock2	  => clock2,
        clock6	  => clock6,
		clk_count => clk_count
        );
	
	i_cnvlt : convo_encod
    port map(
        clock   => clock,
        reset   => reset,
        datain  => datain,
        dataout => dataout
        );
	
	-- i_par_ser : par_ser
    -- port map(
        -- reset	   => reset,
		-- clock      => clock2,
		-- stream_clk => clock6,
		-- clk_count  => clk_count,
        -- datain     => s_pardata,
		-- dataout    => dataout
        -- );

end architecture;       