library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


library work;
use work.viterbi_package.all;

entity minrute_selector is
    port(
        clock     : in  std_logic;
        reset     : in  std_logic;
        valid     : in  std_logic;
        rute_a	  : in  std_logic_vector(5 downto 0);
        rute_b    : in  std_logic_vector(5 downto 0);
        cost_a    : in  std_logic_vector(distmax-1 downto 0);
        cost_b    : in  std_logic_vector(distmax-1 downto 0);
        min_cost  : out std_logic_vector(distmax-1 downto 0);
        rute_min  : out std_logic_vector(5 downto 0)
        );
    end entity;
    
architecture rtl of minrute_selector is
	
begin       	
	
    -- process(reset, clock)
    -- begin
        -- if reset = '1' then
            -- min_cost  <= (others => '0');
            -- rute_min  <= (others => '0');
        -- elsif clock'event and clock = '1' then
			-- if (cost_a < cost_b) then
				-- min_cost <= cost_a;
				-- rute_min <= rute_a;
			-- else
				-- min_cost <= cost_b;
				-- rute_min <= rute_b;
			-- end if;
        -- end if;
    -- end process;
	
				min_cost <= cost_a when (cost_a < cost_b) else cost_b;
				rute_min <= rute_a when (cost_a < cost_b) else rute_b;
	
     
end architecture;       