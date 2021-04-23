library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity input_reg is
  port(
    clock    : in  std_logic;
    reset    : in  std_logic;
    datain	 : in  std_logic_vector(2 downto 0);
    dataout  : out std_logic_vector(2 downto 0)
    );
end entity;

architecture rtl of input_reg is

begin
    process(clock, reset)
	begin
	if reset = '1' then
       dataout <= "ZZZ";
	elsif clock'event and clock = '1' then
	  dataout <= datain;
	end if;
	end process;	

end rtl;
