library ieee;

use ieee.std_logic_1164.all;
use work.pack_unpack_pkg.all;
use work.wishbone_pkg.all;
use work.wr_fabric_pkg.all;

package trigger_pkg is


  
  type t_timestamp is record
    valid   : std_logic;
    seconds : std_logic_vector(39 downto 0);
    cycles  : std_logic_vector(27 downto 0);
    frac    : std_logic_vector(11 downto 0);
  end record;

  type t_timestamp_array is array(integer range <>) of t_timestamp;

  type t_trigger is record
    ts        : t_timestamp;
    source_id : std_logic_vector(15 downto 0);
    seq_id    : std_logic_vector(31 downto 0);
  end record;

  constant c_packed_trigger_size : integer := 128;

  function f_pack (t : t_trigger) return std_logic_vector;
  function f_unpack(t : std_logic_vector) return t_trigger;


  component fd_ts_adder
    generic (
      g_frac_bits    : integer;
      g_coarse_bits  : integer;
      g_utc_bits     : integer;
      g_coarse_range : integer);
    port (
      clk_i      : in  std_logic;
      rst_n_i    : in  std_logic;
      valid_i    : in  std_logic;
      enable_i   : in  std_logic := '1';
      a_utc_i    : in  std_logic_vector(g_utc_bits-1 downto 0);
      a_coarse_i : in  std_logic_vector(g_coarse_bits-1 downto 0);
      a_frac_i   : in  std_logic_vector(g_frac_bits-1 downto 0);
      b_utc_i    : in  std_logic_vector(g_utc_bits-1 downto 0);
      b_coarse_i : in  std_logic_vector(g_coarse_bits-1 downto 0);
      b_frac_i   : in  std_logic_vector(g_frac_bits-1 downto 0);
      valid_o    : out std_logic;
      q_utc_o    : out std_logic_vector(g_utc_bits-1 downto 0);
      q_coarse_o : out std_logic_vector(g_coarse_bits-1 downto 0);
      q_frac_o   : out std_logic_vector(g_frac_bits-1 downto 0));
  end component;

  component trigger_dist_core
    generic (
      g_num_inputs  : integer;
      g_num_outputs : integer;
      g_core_type   : integer);
    port (
      clk_sys_i       : in  std_logic;
      rst_n_i         : in  std_logic;
      tm_time_valid_i : in  std_logic;
      tm_seconds_i    : in  std_logic_vector(39 downto 0);
      tm_cycles_i     : in  std_logic_vector(27 downto 0);
      timestamps_i    : in  t_timestamp_array(g_num_inputs-1 downto 0);
      timestamps_o    : out t_timestamp_array(g_num_outputs-1 downto 0);
      input_sel_o     : out std_logic_vector(g_num_inputs-1 downto 0);
      snk_i           : in  t_wrf_sink_in;
      snk_o           : out t_wrf_sink_out;
      src_i           : in  t_wrf_source_in;
      src_o           : out t_wrf_source_out;
      slave_i         : in  t_wishbone_slave_in;
      slave_o         : out t_wishbone_slave_out);
  end component;
  
end trigger_pkg;

package body trigger_pkg is

    function f_pack
    (t : t_trigger) return std_logic_vector is
  begin
    return t.ts.seconds & t.ts.cycles & t.ts.frac & t.source_id & t.seq_id;
  end f_pack;

  function f_unpack(t : std_logic_vector) return t_trigger is
    variable tmp : t_trigger;
  begin
    f_unpack5(t, tmp.ts.seconds, tmp.ts.cycles, tmp.ts.frac, tmp.source_id, tmp.seq_id);
    return tmp;
  end f_unpack;


end trigger_pkg;
