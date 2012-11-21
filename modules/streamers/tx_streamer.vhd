library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.wishbone_pkg.all;
use work.wr_fabric_pkg.all;

entity tx_streamer is
  
  generic (
    g_data_width    : integer := 32;
    g_tx_block_size : integer := 16;
    g_tx_timeout    : integer := 1024
    );

  port (
    clk_sys_i : in std_logic;
    rst_n_i   : in std_logic;

    -- Endpoint/WRC interface 
    src_dat_o   : out std_logic_vector(15 downto 0);
    src_adr_o   : out std_logic_vector(1 downto 0);
    src_sel_o   : out std_logic_vector(1 downto 0);
    src_cyc_o   : out std_logic;
    src_stb_o   : out std_logic;
    src_we_o    : out std_logic;
    src_stall_i : in  std_logic;
    src_ack_i   : in  std_logic;
    src_err_i   : in  std_logic;

    tx_flush_i : in std_logic := '0';
    tx_last_i      : in  std_logic;
    tx_data_i      : in  std_logic_vector(g_data_width-1 downto 0);
    tx_reset_seq_i : in  std_logic;
    tx_valid_i     : in  std_logic;
    tx_dreq_o      : out std_logic;

    -- MAC address
    cfg_mac_local_i  : in std_logic_vector(47 downto 0);
    cfg_mac_target_i : in std_logic_vector(47 downto 0);
    cfg_ethertype_i  : in std_logic_vector(15 downto 0)
    );

end tx_streamer;

architecture rtl of tx_streamer is

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
      tx_flush_i : in std_logic;
      tx_last_i        : in  std_logic;
      tx_data_i        : in  std_logic_vector(g_data_width-1 downto 0);
      tx_reset_seq_i   : in  std_logic;
      tx_valid_i       : in  std_logic;
      tx_dreq_o        : out std_logic;
      cfg_mac_local_i  : in  std_logic_vector(47 downto 0);
      cfg_mac_target_i : in  std_logic_vector(47 downto 0);
      cfg_ethertype_i  : in  std_logic_vector(15 downto 0));
  end component;

  signal src_in  : t_wrf_source_in;
  signal src_out : t_wrf_source_out;
  
begin  -- rtl
  
  U_Wrapped_Streamer : xtx_streamer
    generic map (
      g_data_width    => g_data_width,
      g_tx_block_size => g_tx_block_size,
      g_tx_timeout    => g_tx_timeout)
    port map (
      clk_sys_i        => clk_sys_i,
      rst_n_i          => rst_n_i,
      src_i            => src_in,
      src_o            => src_out,
      tx_last_i        => tx_last_i,
      tx_data_i        => tx_data_i,
      tx_reset_seq_i   => tx_reset_seq_i,
      tx_valid_i       => tx_valid_i,
      tx_dreq_o        => tx_dreq_o,
      tx_flush_i       => tx_flush_i,
      cfg_mac_local_i  => cfg_mac_local_i,
      cfg_mac_target_i => cfg_mac_target_i,
      cfg_ethertype_i  => cfg_ethertype_i);

  src_adr_o    <= src_out.adr;
  src_dat_o    <= src_out.dat;
  src_sel_o    <= src_out.sel;
  src_stb_o    <= src_out.stb;
  src_we_o     <= src_out.we;
  src_cyc_o    <= src_out.cyc;
  src_in.ack   <= src_ack_i;
  src_in.stall <= src_stall_i;
  src_in.err   <= src_err_i;
  
end rtl;
