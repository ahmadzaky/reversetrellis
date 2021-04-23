library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity output_reg is
  port(
    clock    : in  std_logic;
    reset    : in  std_logic;
    datain	 : in  std_logic;
    dataout  : out std_logic
    );
end entity;

architecture rtl of output_reg is

begin
	
	process(clock, reset)
	begin
	if reset = '1' then
		dataout <= '0';
	elsif clock'event and clock = '1' then
		dataout <= datain;
	end if;
	end process;
	
end rtl;
	