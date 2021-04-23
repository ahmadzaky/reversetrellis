library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity shift_reg is
    port(
        clock  : in  std_logic;
        reset  : in  std_logic;
        datain : in  std_logic;
        data0  : out std_logic;
        data1  : out std_logic;
        data2  : out std_logic;
        data3  : out std_logic;
        data4  : out std_logic;
        data5  : out std_logic;
        data6  : out std_logic
        );
    end entity;
    
architecture struct of shift_reg is

signal s_data0 : std_logic;
signal s_data1 : std_logic;
signal s_data2 : std_logic;
signal s_data3 : std_logic;
signal s_data4 : std_logic;
signal s_data5 : std_logic;
signal s_data6 : std_logic;

begin       

    process(reset, clock)
    begin
        if reset = '1' then
            s_data0 <= '0';
            s_data1 <= '0';
            s_data2 <= '0';
            s_data3 <= '0';
            s_data4 <= '0';
            s_data5 <= '0';
            s_data6 <= '0';
        elsif clock'event and clock = '1' then
            s_data0 <= datain;
            s_data1 <= s_data0;
            s_data2 <= s_data1;
            s_data3 <= s_data2;
            s_data4 <= s_data3;
            s_data5 <= s_data4;
            s_data6 <= s_data5;
        end if;
    end process;
     
    data0 <= s_data0;
    data1 <= s_data1;
    data2 <= s_data2;
    data3 <= s_data3; 
    data4 <= s_data4;
    data5 <= s_data5;
    data6 <= s_data6;    
            

end architecture;       