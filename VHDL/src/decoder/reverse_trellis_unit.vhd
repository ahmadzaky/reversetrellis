library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


library work;
use work.viterbi_package.all;

entity reverse_trellis_unit is
    port(
        clock        : in  std_logic;
        reset        : in  std_logic;
        valid        : in  std_logic;
        data_i       : in  std_logic_vector(2 downto 0);
        start_rute	 : in  std_logic_vector (11 downto 0);
        path_cost    : out std_logic_vector (distmax-1 downto 0)
        );
    end entity;
    
architecture rtl of reverse_trellis_unit is
        
	function distance_calc (x: std_logic_vector (2 downto 0)) return std_logic_vector is
	variable temp : std_logic_vector (1 downto 0):= "00";
	variable dist : std_logic_vector (distmax-1 downto 0) := (others => '0');
	begin
		temp(0)   := x(2) xor x(1) xor x(0);
		temp(1)   := (x(2) and x(1)) or (x(2) and x(0)) or (x(1) and x(0));
		dist	  := ("0000" & temp);
		return dist ;
	end function distance_calc;
	
	
	
	signal s_rute  : std_logic_vector (11 downto 0);
    signal cost    : std_logic_vector (distmax-1 downto 0);
	signal clear   : std_logic;
	
begin       	
	process(reset, clock)
	begin
	if reset = '1' then 
		s_rute <= (others => '0');
	elsif clock'event and clock = '1' then 
		if valid = '0' then
			s_rute <= start_rute;
		else
			for j in 11 downto 1 LOOP
                s_rute(j) <= s_rute(j-1);
            END LOOP;
			s_rute(0) <= 'Z';
		end if;
	end if;	
	end process;
	
	process(reset, clock)
	begin
	if reset = '1' then 
		clear <= '0';
	elsif clock'event and clock = '1' then 
		clear <= valid;
	end if;
	end process;	
	
    process(reset, clock)
    variable v_dist      : std_logic_vector(distmax-1 downto 0);
	variable temp_cost 	  : std_logic_vector(2 downto 0);
    begin
        if reset = '1' then
            cost       <= (others => '0');
            v_dist     := (others => '0');
            temp_cost  := (others => '0');
        elsif clock'event and clock = '1' then
			if valid = '1' then
				temp_cost(2)   := s_rute(11) xor s_rute(9)  xor s_rute(8) xor s_rute(6) xor s_rute(5) xor data_i(2); --1011011
				temp_cost(1)   := s_rute(11) xor s_rute(10) xor s_rute(9) xor s_rute(8) xor s_rute(5) xor data_i(1); --1111001
				temp_cost(0)   := s_rute(11) xor s_rute(10) xor s_rute(9) xor s_rute(7) xor s_rute(5) xor data_i(0); --1110101
				v_dist		   := distance_calc(temp_cost);
				cost 		   <= v_dist + cost;
			elsif clear = '0' then
				cost <=  (others => '0');
			end if;
        end if;
    end process;
      
	path_cost <= cost;	  
		
end architecture;       