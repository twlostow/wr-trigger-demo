library ieee;
use ieee.std_logic_1164.all;

use work.trigger_pkg.all;

entity trigger_detect is
  
  generic (
    g_num_triggers : integer);

  port (
    clk_sys_i : in std_logic;
    rst_n_i   : in std_logic;

    trig_id_i       : in std_logic_vector(11 downto 0);
    trig_id_valid_i : in std_logic;

    ram_addr_o : in  std_logic_vector(6 downto 0);
    ram_data_o : out std_logic_vector(31 downto 0);
    ram_data_i : in  std_logic_vector(31 downto 0);
    ram_we_o   : out std_logic
    );

end trigger_detect;

architecture rtl of trigger_detect is

begin  -- rtl

  

end rtl;
