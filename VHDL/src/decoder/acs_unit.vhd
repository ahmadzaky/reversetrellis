library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


library work;
use work.viterbi_package.all;

entity acs_unit is
    port(
        clock        : in  std_logic;
        reset        : in  std_logic;
        valid        : in  std_logic;
        weight_up    : in  std_logic_vector(2 downto 0);
        weight_down  : in  std_logic_vector(2 downto 0);
        data_i       : in  std_logic_vector(2 downto 0);
        rute_up    	 : in  std_logic_vector (distmax-1 downto 0);
        rute_down  	 : in  std_logic_vector (distmax-1 downto 0);
        min_path     : out std_logic_vector (distmax-1 downto 0);
        rute_o       : out std_logic
        );
    end entity;
    
architecture struct of acs_unit is
        
	function distance_calc (x: std_logic_vector (2 downto 0); y: std_logic_vector (distmax-1 downto 0)) return std_logic_vector is
	variable temp : std_logic_vector (1 downto 0):= "00";
	variable dist : std_logic_vector (distmax-1 downto 0) := (others => '0');
	variable zero : std_logic_vector (distmax-4 downto 0) := (others => '0');
	begin
		temp(0)   := x(2) xor x(1) xor x(0);
		temp(1)   := (x(2) and x(1)) or (x(2) and x(0)) or (x(1) and x(0));
		dist	  := y + (zero & temp);
		return dist ;
	end function distance_calc;
	
	--signal temp_up 	    : std_logic_vector(2 downto 0);
	--signal temp_down    : std_logic_vector(2 downto 0);
	
begin       	
	
    process(reset, clock)
    variable dist_up      : std_logic_vector(distmax-1 downto 0);
    variable dist_down    : std_logic_vector(distmax-1 downto 0);
	variable temp_up 	  : std_logic_vector(2 downto 0);
	variable temp_down    : std_logic_vector(2 downto 0);
	variable v_min_path     : std_logic_vector (distmax-1 downto 0);
    begin
        if reset = '1' then
            dist_up      := (others => '0');
            dist_down    := (others => '0');
            v_min_path   := (others => '0');
            temp_up      := (others => '0');
            temp_down    := (others => '0');
            rute_o    	 <= 'Z';
        elsif clock'event and clock = '1' then
			if valid = '1' then
				temp_up(2)   := weight_up(2)   xor data_i(2);
				temp_up(1)   := weight_up(1)   xor data_i(1);
				temp_up(0)   := weight_up(0)   xor data_i(0);
				temp_down(2) := weight_down(2) xor data_i(2);
				temp_down(1) := weight_down(1) xor data_i(1);
				temp_down(0) := weight_down(0) xor data_i(0);
				dist_up      := distance_calc(temp_up,rute_up);
				dist_down    := distance_calc(temp_down,rute_down);
				
				if (dist_up < dist_down) then
					v_min_path := dist_up;
					rute_o	<= '0';
				else
					v_min_path := dist_down;
					rute_o	<= '1';
				end if;
			end if;
        end if;
		min_path <= v_min_path;
    end process;
     
--rute_o <= '0' when (dist_up < dist_down) else '1';
end architecture;       