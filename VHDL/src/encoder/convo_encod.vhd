library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.viterbi_package.all;

entity convo_encod is
    port(
        clock  : in  std_logic;
        reset  : in  std_logic;
        datain : in  std_logic;
        dataout: out std_logic_vector(2 downto 0)
        );
    end entity;
    
architecture rtl of convo_encod is

signal s_data0 : std_logic;
signal s_data1 : std_logic;
signal s_data2 : std_logic;
signal s_data3 : std_logic;
signal s_data4 : std_logic;
signal s_data5 : std_logic;
signal s_data6 : std_logic;

begin       
    
    i_shift_reg : shift_reg
    port map
    (   clock  => clock,
        reset  => reset,
        datain => datain,
        data0  => s_data0,
        data1  => s_data1,
        data2  => s_data2,
        data3  => s_data3,
        data4  => s_data4,
        data5  => s_data5,
        data6  => s_data6
    );

    dataout(0) <= s_data0 xor s_data1 xor s_data2 xor s_data4 xor s_data6;			--165 : 1110101
    dataout(1) <= s_data0 xor s_data1 xor s_data2 xor s_data3 xor s_data6;			--171 : 1111001
    dataout(2) <= s_data0 xor s_data2 xor s_data3 xor s_data5 xor s_data6;			--133 : 1011011
            
    
end architecture;       