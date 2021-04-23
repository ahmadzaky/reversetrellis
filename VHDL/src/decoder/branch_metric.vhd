library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity branch_metric is
    port(
        PE_ID        : in  std_logic_vector(47 downto 0);   
	    weight_000_0 : out std_logic_vector(2 downto 0);
	    weight_000_1 : out std_logic_vector(2 downto 0);	
	    weight_001_0 : out std_logic_vector(2 downto 0);	
	    weight_001_1 : out std_logic_vector(2 downto 0);
        weight_010_0 : out std_logic_vector(2 downto 0);
	    weight_010_1 : out std_logic_vector(2 downto 0);	
	    weight_011_0 : out std_logic_vector(2 downto 0);
	    weight_011_1 : out std_logic_vector(2 downto 0);	
	    weight_100_0 : out std_logic_vector(2 downto 0);	 
	    weight_100_1 : out std_logic_vector(2 downto 0); 
	    weight_101_0 : out std_logic_vector(2 downto 0); 
	    weight_101_1 : out std_logic_vector(2 downto 0);	 
	    weight_110_0 : out std_logic_vector(2 downto 0);
	    weight_110_1 : out std_logic_vector(2 downto 0);
	    weight_111_0 : out std_logic_vector(2 downto 0);
	    weight_111_1 : out std_logic_vector(2 downto 0)
		);
    end entity;
    
architecture rtl of branch_metric is


begin
	
	weight_000_0  <= PE_ID(47 downto 45);
	weight_000_1  <= PE_ID(44 downto 42);	
	weight_001_0  <= PE_ID(41 downto 39);	
	weight_001_1  <= PE_ID(38 downto 36);
    weight_010_0  <= PE_ID(35 downto 33);
	weight_010_1  <= PE_ID(32 downto 30);	
	weight_011_0  <= PE_ID(29 downto 27);
	weight_011_1  <= PE_ID(26 downto 24);	
	weight_100_0  <= PE_ID(23 downto 21);	 
	weight_100_1  <= PE_ID(20 downto 18); 
	weight_101_0  <= PE_ID(17 downto 15); 
	weight_101_1  <= PE_ID(14 downto 12);	 
	weight_110_0  <= PE_ID(11 downto 9);
	weight_110_1  <= PE_ID( 8 downto 6);
	weight_111_0  <= PE_ID( 5 downto 3);
	weight_111_1  <= PE_ID( 2 downto 0);
	
end rtl;