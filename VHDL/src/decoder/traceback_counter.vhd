library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.viterbi_package.all;

entity traceback_counter is
    port(
        reset	 : in  std_logic;
		clock    : in  std_logic;
		valid    : in  std_logic;
		rute_vld : out std_logic;
		datacount: out integer range 0 to tracelength-1
        );
    end entity;
    
architecture rtl of traceback_counter is


	signal count : integer range 0 to tracelength-1;

begin       
    
    process(reset, clock)
    begin
    if reset = '1' then
        count <= tracelength-1;
    elsif clock'event and clock = '1' then
		if valid = '1' then
			if count = tracelength-1 then
				count <= 0;
			else
				count <= count + 1;
			end if;
		end if;
    end if;
    end process;
    datacount <= count;
    rute_vld  <= '1' when (count = 0) else '0';
    
end architecture;       