library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.trigger_pkg.all;
use work.wishbone_pkg.all;
use work.ttx_wbgen2_pkg.all;

entity trigger_tx is
  port(
    clk_sys_i : in std_logic;
    rst_n_i   : in std_logic;

    ts_i : in t_timestamp;

    tx_data_o : out std_logic_vector(c_packed_trigger_size - 1 downto 0);
    tx_req_o  : out std_logic;
    tx_ack_i  : in  std_logic;

    enable_o : out std_logic;

    slave_i : in t_wishbone_slave_in;
    slave_o : out t_wishbone_slave_out
);
end trigger_tx;

architecture rtl of trigger_tx is

  component trigger_tx_wb
    port (
      rst_n_i    : in  std_logic;
      clk_sys_i  : in  std_logic;
      wb_adr_i   : in  std_logic_vector(1 downto 0);
      wb_dat_i   : in  std_logic_vector(31 downto 0);
      wb_dat_o   : out std_logic_vector(31 downto 0);
      wb_cyc_i   : in  std_logic;
      wb_sel_i   : in  std_logic_vector(3 downto 0);
      wb_stb_i   : in  std_logic;
      wb_we_i    : in  std_logic;
      wb_ack_o   : out std_logic;
      wb_stall_o : out std_logic;
      regs_i     : in  t_ttx_in_registers;
      regs_o     : out t_ttx_out_registers);
  end component;

  signal regs_in  : t_ttx_in_registers;
  signal regs_out : t_ttx_out_registers;

  signal ts_adjusted : t_timestamp;
  signal trig_packet : t_trigger;

  type t_state is (WAIT_TRIGGER, WAIT_SENT);

  signal state : t_state;

  signal counter : unsigned(31 downto 0);
  
begin  -- rtl
  
  U_WB_Slave : trigger_tx_wb
    port map (
      rst_n_i    => rst_n_i,
      clk_sys_i  => clk_sys_i,
      wb_adr_i   => slave_i.adr(3 downto 2),
      wb_dat_i   => slave_i.dat,
      wb_dat_o   => slave_o.dat,
      wb_cyc_i   => slave_i.cyc,
      wb_sel_i   => slave_i.sel,
      wb_stb_i   => slave_i.stb,
      wb_we_i    => slave_i.we,
      wb_ack_o   => slave_o.ack,
      wb_stall_o => slave_o.stall,
      regs_i     => regs_in,
      regs_o     => regs_out);


  U_Adjust_Delay : fd_ts_adder
    generic map (
      g_frac_bits    => 12,
      g_coarse_bits  => 28,
      g_utc_bits     => 40,
      g_coarse_range => 125000000)
    port map (
      clk_i      => clk_sys_i,
      rst_n_i    => rst_n_i,
      valid_i    => ts_i.valid,
      enable_i   => '1',
      a_utc_i    => ts_i.seconds,
      a_coarse_i => ts_i.cycles,
      a_frac_i   => ts_i.frac,
      b_utc_i    => x"0000000000",
      b_coarse_i => regs_out.adj_c_o,
      b_frac_i   => regs_out.adj_f_o,
      valid_o    => ts_adjusted.valid,
      q_utc_o    => ts_adjusted.seconds,
      q_coarse_o => ts_adjusted.cycles,
      q_frac_o   => ts_adjusted.frac);


  p_counter : process(clk_sys_i)
  begin
    if rising_edge(clk_sys_i) then
      if rst_n_i = '0' or regs_out.cr_rst_cnt_o = '1' then
        counter <= (others => '0');
      elsif(state = WAIT_TRIGGER and ts_adjusted.valid = '1' and regs_out.cr_enable_o = '1') then
        counter <= counter + 1;
      end if;
    end if;
  end process;

  regs_in.cntr_i <= std_logic_vector(counter);
  
  p_fsm : process(clk_sys_i)
  begin
    if rising_edge(clk_sys_i) then
      if rst_n_i = '0' then
        state      <= WAIT_TRIGGER;
        tx_req_o   <= '0';
      else
        
        case state is

          when WAIT_TRIGGER =>

            if(ts_adjusted.valid = '1' and regs_out.cr_enable_o = '1') then
              trig_packet.ts        <= ts_adjusted;
              trig_packet.source_id <= regs_out.cr_id_o;
              trig_packet.seq_id    <= std_logic_vector(counter);
              tx_req_o              <= '1';
              state                 <= WAIT_SENT;
            end if;

          when WAIT_SENT =>
            if(tx_ack_i = '1') then
              tx_req_o <= '0';
              state    <= WAIT_TRIGGER;
            end if;

        end case;
        
      end if;
    end if;
  end process;

  enable_o <= regs_out.cr_enable_o;
  tx_data_o <= f_pack(trig_packet);
  
end rtl;
