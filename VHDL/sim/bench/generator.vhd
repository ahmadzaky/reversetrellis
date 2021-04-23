library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity generator is
  generic ( one_period   : Time := 120 ns);
  port(
    clock   : in std_logic;
    reset   : in std_logic;
    out_gen : out std_logic_vector (2 downto 0));
  end entity;                                                                                                                             --
    
architecture struct of generator is
	signal count     : std_logic_vector(5 downto 0);
	signal buff      : std_logic_vector(2 downto 0);
begin       

	process(clock, reset)
	begin
	if reset = '1' then 
		count <= (others => '0');
	elsif clock'event and clock = '0' then	
		count <= count + 1;
	end if;
	end process;
	
	
	buff(2) <= clock xor count(0) xor count(4) xor count(2) xor count(0); --1 110101 165
	buff(1) <= clock xor count(0) xor count(4) xor count(3) xor count(0); --1 111001 171
	buff(0) <= clock xor count(0) xor count(3) xor count(1) xor count(0); --1 011011 133

	out_gen <= buff;
end architecture;       