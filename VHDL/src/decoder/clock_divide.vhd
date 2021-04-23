library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity clock_divide is
    port(
        reset	 : in  std_logic;
		clock    : in  std_logic;
        clock2	 : out std_logic;
        clock6	 : out std_logic;
		clk_count: out std_logic_vector(1 downto 0)
        );
    end entity;
    
architecture rtl of clock_divide is

signal clk2 : std_logic;
signal clk6 : std_logic;
signal ccount : std_logic_vector(1 downto 0);

begin       

    process(reset, clock)
	begin
	if reset = '1' then
		clk2 <= '0';
	elsif clock'event and clock = '1' then
		clk2 <= not clk2;
	end if;
	end process;
	
    process(reset, clock)
	begin
	if reset = '1' then
		ccount <= "00";
	elsif clock'event and clock = '1' then
		if ccount = "10" then
			ccount <= "00";
		else
			ccount <= ccount+1;
		end if;
	end if;
	end process;
    
	
    process(reset, clock, ccount)
	begin
	if reset = '1' then
		clk6 <= '0';
	elsif clock'event and clock = '1' then
		if ccount = "00" then
			clk6 <= not clk6;
		end if;
	end if;
	end process;
	
	clock2 	  <= clk2;
	clock6 	  <= clk6;
    clk_count <= ccount;
	
end architecture;       