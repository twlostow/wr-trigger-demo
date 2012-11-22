library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.trigger_pkg.all;
use work.wishbone_pkg.all;
use work.trx_wbgen2_pkg.all;
use work.genram_pkg.all;

entity trigger_rx is
  port(
    clk_sys_i : in std_logic;
    rst_n_i   : in std_logic;

    ts_o : out t_timestamp;

    tm_time_valid_i : in std_logic;
    tm_seconds_i    : in std_logic_vector(39 downto 0);
    tm_cycles_i     : in std_logic_vector(27 downto 0);

    rx_data_i  : in  std_logic_vector(c_packed_trigger_size - 1 downto 0);
    rx_valid_i : in  std_logic;
    rx_dreq_o  : out std_logic;

    slave_i : in  t_wishbone_slave_in;
    slave_o : out t_wishbone_slave_out
    );

end trigger_rx;

architecture rtl of trigger_rx is

  component trigger_rx_wb
    port (
      rst_n_i            : in  std_logic;
      clk_sys_i          : in  std_logic;
      wb_adr_i           : in  std_logic_vector(9 downto 0);
      wb_dat_i           : in  std_logic_vector(31 downto 0);
      wb_dat_o           : out std_logic_vector(31 downto 0);
      wb_cyc_i           : in  std_logic;
      wb_sel_i           : in  std_logic_vector(3 downto 0);
      wb_stb_i           : in  std_logic;
      wb_we_i            : in  std_logic;
      wb_ack_o           : out std_logic;
      wb_stall_o         : out std_logic;
      trx_dhb_ram_addr_i : in  std_logic_vector(8 downto 0);
      trx_dhb_ram_data_o : out std_logic_vector(31 downto 0);
      trx_dhb_ram_rd_i   : in  std_logic;
      trx_dhb_ram_data_i : in  std_logic_vector(31 downto 0);
      trx_dhb_ram_wr_i   : in  std_logic;
      regs_i             : in  t_trx_in_registers;
      regs_o             : out t_trx_out_registers);
  end component;

  component delay_histogram
    generic (
      g_num_bins    : integer;
      g_input_width : integer);
    port (
      clk_sys_i      : in  std_logic;
      rst_n_i        : in  std_logic;
      sample_i       : in  std_logic_vector(g_input_width-1 downto 0);
      sample_valid_i : in  std_logic;
      ram_addr_o     : out std_logic_vector(f_log2_size(g_num_bins)-1 downto 0);
      ram_data_o     : out std_logic_vector(31 downto 0);
      ram_data_i     : in  std_logic_vector(31 downto 0);
      ram_wr_o       : out std_logic;
      regs_i         : in  t_trx_out_registers);
  end component;


  signal dhb_ram_addr     : std_logic_vector(8 downto 0);
  signal dhb_ram_data_out : std_logic_vector(31 downto 0);
  signal dhb_ram_data_in  : std_logic_vector(31 downto 0);
  signal dhb_ram_wr       : std_logic;

  signal regs_in  : t_trx_in_registers;
  signal regs_out : t_trx_out_registers;

  signal adjusted_ts                     : t_timestamp;
  signal decoded_trig, decoded_trig_comb : t_trigger;
  signal trigger_valid, trigger_valid_d0 : std_logic;

  signal rx_count : unsigned(31 downto 0);

  signal delay : unsigned(27 downto 0);
  
begin  -- rtl

  U_WB_Slave : trigger_rx_wb
    port map (
      rst_n_i            => rst_n_i,
      clk_sys_i          => clk_sys_i,
      wb_adr_i           => slave_i.adr(11 downto 2),
      wb_dat_i           => slave_i.dat,
      wb_dat_o           => slave_o.dat,
      wb_cyc_i           => slave_i.cyc,
      wb_sel_i           => slave_i.sel,
      wb_stb_i           => slave_i.stb,
      wb_we_i            => slave_i.we,
      wb_ack_o           => slave_o.ack,
      wb_stall_o         => slave_o.stall,
      trx_dhb_ram_addr_i => dhb_ram_addr,
      trx_dhb_ram_data_o => dhb_ram_data_out,
      trx_dhb_ram_rd_i   => '1',
      trx_dhb_ram_data_i => dhb_ram_data_in,
      trx_dhb_ram_wr_i   => dhb_ram_wr,
      regs_i             => regs_in,
      regs_o             => regs_out);

  p_calculate_delay : process(clk_sys_i)
  begin
    if rising_edge(clk_sys_i) then

      trigger_valid_d0 <= trigger_valid;

      if trigger_valid = '1' then
        if(tm_seconds_i(0) /= decoded_trig.ts.seconds(0)) then
          delay <= unsigned(tm_cycles_i) - unsigned(decoded_trig.ts.cycles) + to_unsigned(125000000, 28);
        else
          delay <= unsigned(tm_cycles_i) - unsigned(decoded_trig.ts.cycles);
        end if;
      end if;
    end if;
  end process;


  U_Histogrammer : delay_histogram
    generic map (
      g_num_bins    => 512,
      g_input_width => 18)
    port map (
      clk_sys_i      => clk_sys_i,
      rst_n_i        => rst_n_i,
      sample_i       => std_logic_vector(delay(17 downto 0)),
      sample_valid_i => trigger_valid_d0,
      ram_addr_o     => dhb_ram_addr,
      ram_data_o     => dhb_ram_data_in,
      ram_data_i     => dhb_ram_data_out,
      ram_wr_o       => dhb_ram_wr,
      regs_i         => regs_out);

  U_Add_Delay : fd_ts_adder
    generic map (
      g_frac_bits    => 12,
      g_coarse_bits  => 28,
      g_utc_bits     => 40,
      g_coarse_range => 125000000)
    port map (
      clk_i      => clk_sys_i,
      rst_n_i    => rst_n_i,
      valid_i    => trigger_valid,
      enable_i   => '1',
      a_utc_i    => decoded_trig.ts.seconds,
      a_coarse_i => decoded_trig.ts.cycles,
      a_frac_i   => decoded_trig.ts.frac,
      b_utc_i    => x"0000000000",
      b_coarse_i => regs_out.delay_c_o,
      b_frac_i   => regs_out.delay_f_o,
      valid_o    => adjusted_ts.valid,
      q_utc_o    => adjusted_ts.seconds,
      q_coarse_o => adjusted_ts.cycles,
      q_frac_o   => adjusted_ts.frac);

  decoded_trig_comb <= f_unpack(rx_data_i);

  p_fsm : process(clk_sys_i)
  begin
    if rising_edge(clk_sys_i) then
      if rst_n_i = '0' then
        trigger_valid <= '0';
      else
        if(regs_out.cr_rst_cnt_o = '1') then
          rx_count <= (others => '0');
        elsif(rx_valid_i = '1' and decoded_trig_comb.source_id = regs_out.cr_id_o) then
          rx_count <= rx_count + 1;
        end if;

        -- got a trigger for us?
        if(rx_valid_i = '1' and decoded_trig_comb.source_id = regs_out.cr_id_o) then
          decoded_trig  <= decoded_trig_comb;
          trigger_valid <= '1';
        else
          trigger_valid <= '0';
        end if;
      end if;
    end if;
  end process;

  rx_dreq_o <= '1';

  ts_o <= adjusted_ts;
  
end rtl;
