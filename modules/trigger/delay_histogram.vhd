library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

use work.genram_pkg.all;

entity delay_histogram is

  generic(
    g_num : integer;
    g_input_width: integer);

  port(
    clk_sys_i: in std_logic;
    rst_n_i : in std_logic;

    sample_i: in std_logic_vector(g_input_width-1 downto 0);
    sample_valid_i: in std_logic;

    clear_i: in std_logic;

    ram_addr_o: out std_logic_vector(f_log2_size(g_num)-1 downto 0);
    ram_data_o: out std_logic_vector(31 downto 0);
    ram_data_i: in std_logic_vector(31 downto 0);
    ram_wr_o: out std_logic);
  
end delay_histogram;

architecture rtl of delay_histogram is

begin  -- rtl

  

end rtl;
