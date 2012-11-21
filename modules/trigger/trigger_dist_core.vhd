library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.trigger_pkg.all;
use work.gencores_pkg.all;
use work.wishbone_pkg.all;
use work.wr_fabric_pkg.all;

entity trigger_dist_core is
  generic(
    g_num_inputs  : integer := 5;
    g_num_outputs : integer := 5;
    g_core_type   : integer := 0);

  port (
    clk_sys_i : in std_logic;
    rst_n_i   : in std_logic;

    timestamps_i : in  t_timestamp_array(g_num_inputs-1 downto 0);
    timestamps_o : out t_timestamp_array(g_num_outputs-1 downto 0);

    input_sel_o : out std_logic_vector(g_num_inputs-1 downto 0);

    snk_i : in t_wrf_sink_in;
    snk_o : out t_wrf_sink_out;

    src_i : in t_wrf_source_in;
    src_o : out t_wrf_source_out;

    slave_i : in t_wishbone_slave_in;
    slave_o : out t_wishbone_slave_out

    );


end trigger_dist_core;

architecture rtl of trigger_dist_core is


  component trigger_tx
    port (
      clk_sys_i : in  std_logic;
      rst_n_i   : in  std_logic;
      ts_i      : in  t_timestamp;
      tx_data_o : out std_logic_vector(c_packed_trigger_size - 1 downto 0);
      tx_req_o  : out std_logic;
      tx_ack_i  : in  std_logic;
      enable_o  : out std_logic;
      slave_i   : in  t_wishbone_slave_in;
      slave_o   : out t_wishbone_slave_out); 
  end component;
  
  component trigger_rx
    port (
      clk_sys_i  : in  std_logic;
      rst_n_i    : in  std_logic;
      ts_o       : out t_timestamp;
      rx_data_i  : in  std_logic_vector(c_packed_trigger_size - 1 downto 0);
      rx_valid_i : in  std_logic;
      rx_dreq_o  : out std_logic;
      slave_i    : in  t_wishbone_slave_in;
      slave_o    : out t_wishbone_slave_out);
  end component;
  
  component xtx_streamer
    generic (
      g_data_width    : integer;
      g_tx_block_size : integer;
      g_tx_timeout    : integer);
    port (
      clk_sys_i        : in  std_logic;
      rst_n_i          : in  std_logic;
      src_i            : in  t_wrf_source_in;
      src_o            : out t_wrf_source_out;
      tx_flush_i       : in  std_logic;
      tx_last_i        : in  std_logic;
      tx_data_i        : in  std_logic_vector(g_data_width-1 downto 0);
      tx_reset_seq_i   : in  std_logic;
      tx_valid_i       : in  std_logic;
      tx_dreq_o        : out std_logic;
      cfg_mac_local_i  : in  std_logic_vector(47 downto 0);
      cfg_mac_target_i : in  std_logic_vector(47 downto 0);
      cfg_ethertype_i  : in  std_logic_vector(15 downto 0));
  end component;

  component xrx_streamer
    generic (
      g_data_width        : integer;
      g_buffer_size       : integer;
      g_filter_remote_mac : boolean);
    port (
      clk_sys_i               : in  std_logic;
      rst_n_i                 : in  std_logic;
      snk_i                   : in  t_wrf_sink_in;
      snk_o                   : out t_wrf_sink_out;
      rx_sync_o               : out std_logic;
      rx_last_o               : out std_logic;
      rx_data_o               : out std_logic_vector(g_data_width-1 downto 0);
      rx_valid_o              : out std_logic;
      rx_dreq_i               : in  std_logic;
      rx_lost_o               : out std_logic;
      cfg_mac_local_i         : in  std_logic_vector(47 downto 0);
      cfg_mac_remote_i        : in  std_logic_vector(47 downto 0);
      cfg_ethertype_i         : in  std_logic_vector(15 downto 0);
      cfg_accept_broadcasts_i : in  std_logic := '0');
  end component;

  constant c_xwb_trigdist_tx_sdb : t_sdb_device := (
    abi_class     => x"0000",              -- undocumented device
    abi_ver_major => x"01",
    abi_ver_minor => x"01",
    wbd_endian    => c_sdb_endian_big,
    wbd_width     => x"7",                 -- 8/16/32-bit port granularity
    sdb_component => (
      addr_first  => x"0000000000000000",
      addr_last   => x"0000000000000fff",
      product     => (
        vendor_id => x"000000000000CE42",  -- CERN
        device_id => x"00000201",
        version   => x"00000001",
        date      => x"20121119",
        name      => "WB-TrigDist-TX     ")));

  constant c_xwb_trigdist_rx_sdb : t_sdb_device := (
    abi_class     => x"0000",              -- undocumented device
    abi_ver_major => x"01",
    abi_ver_minor => x"01",
    wbd_endian    => c_sdb_endian_big,
    wbd_width     => x"7",                 -- 8/16/32-bit port granularity
    sdb_component => (
      addr_first  => x"0000000000000000",
      addr_last   => x"0000000000000fff",
      product     => (
        vendor_id => x"000000000000CE42",  -- CERN
        device_id => x"00000202",
        version   => x"00000001",
        date      => x"20121119",
        name      => "WB-TrigDist-RX     ")));

  constant c_xwb_trigdist_detect_sdb : t_sdb_device := (
    abi_class     => x"0000",              -- undocumented device
    abi_ver_major => x"01",
    abi_ver_minor => x"01",
    wbd_endian    => c_sdb_endian_big,
    wbd_width     => x"7",                 -- 8/16/32-bit port granularity
    sdb_component => (
      addr_first  => x"0000000000000000",
      addr_last   => x"0000000000000fff",
      product     => (
        vendor_id => x"000000000000CE42",  -- CERN
        device_id => x"00000203",
        version   => x"00000001",
        date      => x"20121119",
        name      => "WB-TrigDist-Detect ")));

  constant c_num_wb_masters      : integer := g_num_inputs + g_num_outputs + 1;
  constant c_slave_tx_base_index : integer := 1;
  constant c_slave_rx_base_index : integer := c_slave_tx_base_index + g_num_inputs;
  constant c_slave_detector      : integer := 0;

  impure function f_gen_interconnect
    return t_sdb_record_array is
    variable sdb : t_sdb_record_array(c_num_wb_masters-1 downto 0);
  begin
    sdb(0) := f_sdb_embed_device(c_xwb_trigdist_detect_sdb, x"00000000");
    for i in 0 to g_num_inputs-1 loop
      sdb(i+1) := f_sdb_embed_device(c_xwb_trigdist_tx_sdb, std_logic_vector(to_unsigned((i+1) * 4096, 32)));
    end loop;  -- i

    for i in 0 to g_num_outputs-1 loop
      sdb(i+1+g_num_inputs) := f_sdb_embed_device(c_xwb_trigdist_rx_sdb, std_logic_vector(to_unsigned((i+1+g_num_inputs) * 4096, 32)));
    end loop;  -- i

    return sdb;
  end f_gen_interconnect;

  constant c_INTERCONNECT_LAYOUT : t_sdb_record_array (c_num_wb_masters-1 downto 0) :=
    f_gen_interconnect;

  signal cnx_master_out : t_wishbone_master_out_array (c_num_wb_masters-1 downto 0);
  signal cnx_master_in  : t_wishbone_master_in_array (c_num_wb_masters-1 downto 0);

  signal requests_packed              : std_logic_vector(g_num_inputs * c_packed_trigger_size -1 downto 0);
  signal requests_valid, requests_ack : std_logic_vector(g_num_inputs-1 downto 0);


  signal rq_muxed, rx_data : std_logic_vector(c_packed_trigger_size-1 downto 0);
  signal rq_muxed_valid, rx_valid: std_logic;
  signal decoded_trig: t_trigger ;
  
begin  -- rtl

  U_Intercon: xwb_sdb_crossbar
    generic map (
      g_num_masters => 1,
      g_num_slaves  => c_num_wb_masters,
      g_registered  => true,
      g_wraparound  => true,
      g_layout      => c_INTERCONNECT_LAYOUT,
      g_sdb_addr    => x"0000f000")
    port map (
      clk_sys_i => clk_sys_i,
      rst_n_i   => rst_n_i,
      slave_i(0)   => slave_i,
      slave_o(0)   => slave_o,
      master_i  => cnx_master_in,
      master_o  => cnx_master_out);
  
  gen_transmitters : for i in 0 to g_num_inputs-1 generate
    U_TXn : trigger_tx
      port map (
        clk_sys_i => clk_sys_i,
        rst_n_i   => rst_n_i,
        ts_i      => timestamps_i(i),
        tx_data_o => requests_packed(c_packed_trigger_size * (i+1) - 1 downto c_packed_trigger_size * i),
        tx_req_o  => requests_valid(i),
        tx_ack_i  => requests_ack(i),

        slave_i   => cnx_master_out(c_slave_tx_base_index + i),
        slave_o   => cnx_master_in(c_slave_tx_base_index + i),

        enable_o => input_sel_o(i)
      );


  end generate gen_transmitters;

  U_Mux_Requests : gc_arbitrated_mux
    generic map (
      g_num_inputs => g_num_inputs,
      g_width      => c_packed_trigger_size)
    port map (
      clk_i     => clk_sys_i,
      rst_n_i   => rst_n_i,
      d_i       => requests_packed,
      d_valid_i => requests_valid,
      d_req_o   => requests_ack,
      q_o       => rq_muxed,
      q_valid_o => rq_muxed_valid);

  U_TX_Streamer : xtx_streamer
    generic map (
      g_data_width    => c_packed_trigger_size,
      g_tx_block_size => 2,
      g_tx_timeout    => 256)
    port map (
      clk_sys_i        => clk_sys_i,
      rst_n_i          => rst_n_i,
      src_i            => src_i,
      src_o            => src_o,
      tx_flush_i       => '0',
      tx_last_i        => '1',
      tx_data_i        => rq_muxed,
      tx_reset_seq_i   => '0',
      tx_valid_i       => rq_muxed_valid,
      tx_dreq_o        => open,
      cfg_mac_local_i  => x"000000000000",
      cfg_mac_target_i => x"ffffffffffff",
      cfg_ethertype_i  => x"dbff");

  U_RX_Streamer : xrx_streamer
    generic map (
      g_data_width        => c_packed_trigger_size,
      g_buffer_size       => 16,
      g_filter_remote_mac => false
      )
    port map (
      clk_sys_i               => clk_sys_i,
      rst_n_i                 => rst_n_i,
      snk_i                   => snk_i,
      snk_o                   => snk_o,
      rx_sync_o               => open,
      rx_last_o               => open,
      rx_data_o               => rx_data,
      rx_valid_o              => rx_valid,
      rx_dreq_i               => '1',
      rx_lost_o               => open,
      cfg_mac_local_i         => x"ffffffffffff",
      cfg_mac_remote_i        => x"000000000000",
      cfg_ethertype_i         => x"dbff",
      cfg_accept_broadcasts_i => '1');

  decoded_trig <= f_unpack(rx_data);

  gen_receivers : for i in 0 to g_num_outputs-1 generate
    U_RXn : trigger_rx
      port map (
        clk_sys_i  => clk_sys_i,
        rst_n_i    => rst_n_i,
        ts_o       => timestamps_o(i),
        rx_data_i  => rx_data,
        rx_valid_i => rx_valid,
        rx_dreq_o  => open,
        slave_i    => cnx_master_out(c_slave_rx_base_index + i),
        slave_o    => cnx_master_in(c_slave_rx_base_index + i));
  end generate gen_receivers;
  
end rtl;
