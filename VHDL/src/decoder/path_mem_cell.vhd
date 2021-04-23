library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.viterbi_package.all;

entity path_mem_cell is
	generic	(start_state : std_logic_vector(5 downto 0) := "000000");
    port(
        ram_reset	   : in  std_logic;
		clock    	   : in  std_logic;
        store_vld 	   : in  std_logic;
        buff_vld 	   : in  std_logic;
        buff_end 	   : in  std_logic;
        rute	 	   : in  std_logic;
        bit_in	 	   : in  std_logic;
        datcount       : in  integer range 0 to tracelength-1;
        data_0   	   : in  path;
        data_1  	   : in  path;
        buff_0   	   : in  buff;
        buff_1  	   : in  buff;
        buff_out   	   : out buff;
        data_out 	   : out path
        );            
    end entity;
    
architecture rtl of path_mem_cell is
	signal s_data_out : path;
begin
	process(clock, ram_reset)
	variable v_data : std_logic_vector(tracelength-7 downto 0);
	variable v_buff : std_logic_vector(bufflength-1 downto 0);
	begin
		if ram_reset = '1' then
            v_data := (others => 'Z');
            v_buff := (others => 'Z');
			buff_out.start <= start_state;
			buff_out.list  <= (others => 'Z');
			--data_out.start <= start_state;
		elsif clock'event and clock = '1' then
			if store_vld = '1' then
				if buff_end	= '1' then
					if rute = '1' then 
						v_data(bufflength-1 downto 0) := buff_1.list;
						v_data(datcount-6)   := bit_in;
						s_data_out.start     <= buff_1.start;
					--	s_data_out.start     <= start_state;
					else
						v_data(bufflength-1 downto 0) := buff_0.list;
						v_data(datcount-6)   := bit_in;
						s_data_out.start     <= buff_0.start;
					--	s_data_out.start     <= start_state;
					end if;
				else						
					if rute = '1' then 
						v_data 		     := data_1.list;
						v_data(datcount-6) := bit_in;
						s_data_out.start   <= data_1.start;
					else
						v_data 		     := data_0.list;
						v_data(datcount-6) := bit_in;
						s_data_out.start   <= data_0.start;
					end if;
				end if;
				s_data_out.list <= v_data;
			elsif buff_vld = '1' then					
				if rute = '1' then 
					v_buff 		     := buff_1.list;
					v_buff(datcount-6) := bit_in;
					buff_out.start   <= buff_1.start;
				else
					v_buff 		     := buff_0.list;
					v_buff(datcount-6) := bit_in;
					buff_out.start   <= buff_0.start;
				end if;
				buff_out.list <= v_buff;
			end if;
		end if;
	end process;
	
    data_out <= s_data_out;
	
	end rtl;