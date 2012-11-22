-------------------------------------------------------------------------------
-- Title      : Fine Delay FMC SPEC (Simple PCI-Express FMC Carrier) top level
-- Project    : Fine Delay FMC (fmc-delay-1ns-4cha)
-------------------------------------------------------------------------------
-- File       : spec_top.vhd
-- Author     : Tomasz Wlostowski
-- Company    : CERN
-- Created    : 2011-08-24
-- Last update: 2012-11-21
-- Platform   : FPGA-generic
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: Top level for the SPEC 1.1 (and later releases) cards with
-- one Fine Delay FMC.
-- Supports:
-- - SDB enumeration (SDB descriptor at 0x00000)
-- - White Rabbit and Etherbone
-- - Interrupts (via WR VIC)
-------------------------------------------------------------------------------
--
-- Copyright (c) 2011 - 2012 CERN / BE-CO-HT
--
-- This source file is free software; you can redistribute it   
-- and/or modify it under the terms of the GNU Lesser General   
-- Public License as published by the Free Software Foundation; 
-- either version 2.1 of the License, or (at your option) any   
-- later version.                                               
--
-- This source is distributed in the hope that it will be       
-- useful, but WITHOUT ANY WARRANTY; without even the implied   
-- warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR      
-- PURPOSE.  See the GNU Lesser General Public License for more 
-- details.                                                     
--
-- You should have received a copy of the GNU Lesser General    
-- Public License along with this source; if not, download it   
-- from http://www.gnu.org/licenses/lgpl-2.1.html
--
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

use work.gn4124_core_pkg.all;
use work.gencores_pkg.all;
use work.wrcore_pkg.all;
use work.wr_fabric_pkg.all;
use work.wishbone_pkg.all;
use work.etherbone_pkg.all;
use work.wr_xilinx_pkg.all;
use work.trigger_pkg.all;
use work.etherbone_pkg.all;

library UNISIM;
use UNISIM.vcomponents.all;

entity spec_top is
  generic
    (
      g_standalone : boolean := true;
      g_simulation : integer := 0
      );
  port
    (
      -------------------------------------------------------------------------
      -- Standard SPEC ports (Gennum bridge, LEDS, Etc. Do not modify
      -------------------------------------------------------------------------

      clk_20m_vcxo_i : in std_logic;    -- 20MHz VCXO clock

      clk_125m_pllref_p_i : in std_logic;  -- 125 MHz PLL reference
      clk_125m_pllref_n_i : in std_logic;

      clk_125m_gtp_n_i : in std_logic;  -- 125 MHz GTP reference
      clk_125m_gtp_p_i : in std_logic;

      l_rst_n : in std_logic;           -- reset from gn4124 (rstout18_n)

      -- general purpose interface
      gpio       : inout std_logic_vector(1 downto 0);  -- gpio[0] -> gn4124 gpio8
                                        -- gpio[1] -> gn4124 gpio9
      -- pcie to local [inbound data] - rx
      p2l_rdy    : out   std_logic;     -- rx buffer full flag
      p2l_clkn   : in    std_logic;     -- receiver source synchronous clock-
      p2l_clkp   : in    std_logic;     -- receiver source synchronous clock+
      p2l_data   : in    std_logic_vector(15 downto 0);  -- parallel receive data
      p2l_dframe : in    std_logic;     -- receive frame
      p2l_valid  : in    std_logic;     -- receive data valid

      -- inbound buffer request/status
      p_wr_req : in  std_logic_vector(1 downto 0);  -- pcie write request
      p_wr_rdy : out std_logic_vector(1 downto 0);  -- pcie write ready
      rx_error : out std_logic;                     -- receive error

      -- local to parallel [outbound data] - tx
      l2p_data   : out std_logic_vector(15 downto 0);  -- parallel transmit data
      l2p_dframe : out std_logic;       -- transmit data frame
      l2p_valid  : out std_logic;       -- transmit data valid
      l2p_clkn   : out std_logic;  -- transmitter source synchronous clock-
      l2p_clkp   : out std_logic;  -- transmitter source synchronous clock+
      l2p_edb    : out std_logic;       -- packet termination and discard

      -- outbound buffer status
      l2p_rdy    : in std_logic;        -- tx buffer full flag
      l_wr_rdy   : in std_logic_vector(1 downto 0);  -- local-to-pcie write
      p_rd_d_rdy : in std_logic_vector(1 downto 0);  -- pcie-to-local read response data ready
      tx_error   : in std_logic;        -- transmit error
      vc_rdy     : in std_logic_vector(1 downto 0);  -- channel ready

      -- font panel leds
      led_red   : out std_logic;
      led_green : out std_logic;

      -------------------------------------------------------------------------
      -- PLL VCXO DAC Drive
      -------------------------------------------------------------------------

      dac_sclk_o  : out std_logic;
      dac_din_o   : out std_logic;
      --dac_clr_n_o : out std_logic;
      dac_cs1_n_o : out std_logic;
      dac_cs2_n_o : out std_logic;

      button1_i : in std_logic := '1';
      button2_i : in std_logic := '1';

      fmc_scl_b : inout std_logic := '1';
      fmc_sda_b : inout std_logic := '1';

      carrier_onewire_b : inout std_logic := '1';
      fmc_prsnt_m2c_l_i : in    std_logic;

      -------------------------------------------------------------------------
      -- SFP pins
      -------------------------------------------------------------------------

      sfp_txp_o : out std_logic;
      sfp_txn_o : out std_logic;

      sfp_rxp_i : in std_logic := '0';
      sfp_rxn_i : in std_logic := '1';

      sfp_mod_def0_b    : in    std_logic;  -- detect pin
      sfp_mod_def1_b    : inout std_logic;  -- scl
      sfp_mod_def2_b    : inout std_logic;  -- sda
      sfp_rate_select_b : inout std_logic := '0';
      sfp_tx_fault_i    : in    std_logic := '0';
      sfp_tx_disable_o  : out   std_logic;
      sfp_los_i         : in    std_logic := '0';

      -------------------------------------------------------------------------
      -- Digital I/O FMC Pins
      -------------------------------------------------------------------------

--      dio_clk_p_i : in std_logic;
--      dio_clk_n_i : in std_logic;

      dio_n_i : in std_logic_vector(4 downto 0);
      dio_p_i : in std_logic_vector(4 downto 0);

      dio_n_o : out std_logic_vector(4 downto 0);
      dio_p_o : out std_logic_vector(4 downto 0);

      dio_oe_n_o    : out std_logic_vector(4 downto 0);
      dio_term_en_o : out std_logic_vector(4 downto 0);

--      dio_onewire_b  : inout std_logic;
      dio_sdn_n_o    : out std_logic;
      dio_sdn_ck_n_o : out std_logic;

      dio_led_top_o : out std_logic;
      dio_led_bot_o : out std_logic;

      -----------------------------------------
      -- UART
      -----------------------------------------

      uart_rxd_i : in  std_logic := '1';
      uart_txd_o : out std_logic;

      -------------------------------------------------------------------------
      -- TBI I/F (simulation only)
      -------------------------------------------------------------------------

      tbi_td_o : out std_logic_vector(9 downto 0);
      tbi_rd_i : in  std_logic_vector(9 downto 0)

      );

end spec_top;

architecture rtl of spec_top is

  component wr_tbi_phy
    port (
      serdes_rst_i          : in  std_logic;
      serdes_loopen_i       : in  std_logic;
      serdes_prbsen_i       : in  std_logic;
      serdes_enable_i       : in  std_logic;
      serdes_syncen_i       : in  std_logic;
      serdes_tx_data_i      : in  std_logic_vector(7 downto 0);
      serdes_tx_k_i         : in  std_logic;
      serdes_tx_disparity_o : out std_logic;
      serdes_tx_enc_err_o   : out std_logic;
      serdes_rx_data_o      : out std_logic_vector(7 downto 0);
      serdes_rx_k_o         : out std_logic;
      serdes_rx_enc_err_o   : out std_logic;
      serdes_rx_bitslide_o  : out std_logic_vector(3 downto 0);
      tbi_refclk_i          : in  std_logic;
      tbi_rbclk_i           : in  std_logic;
      tbi_td_o              : out std_logic_vector(9 downto 0);
      tbi_rd_i              : in  std_logic_vector(9 downto 0);
      tbi_syncen_o          : out std_logic;
      tbi_loopen_o          : out std_logic;
      tbi_prbsen_o          : out std_logic;
      tbi_enable_o          : out std_logic);
  end component;

  component spec_serial_dac_arb
    generic(
      g_invert_sclk    : boolean;
      g_num_extra_bits : integer);
    port (
      clk_i       : in  std_logic;
      rst_n_i     : in  std_logic;
      val1_i      : in  std_logic_vector(15 downto 0);
      load1_i     : in  std_logic;
      val2_i      : in  std_logic_vector(15 downto 0);
      load2_i     : in  std_logic;
      dac_cs_n_o  : out std_logic_vector(1 downto 0);
      dac_clr_n_o : out std_logic;
      dac_sclk_o  : out std_logic;
      dac_din_o   : out std_logic);
  end component;

  component spec_reset_gen
    port (
      clk_sys_i        : in  std_logic;
      rst_pcie_n_a_i   : in  std_logic;
      rst_button_n_a_i : in  std_logic;
      rst_n_o          : out std_logic);
  end component;

  component serdes_pulse_gen
    port (
      clk_ref_i       : in  std_logic;
      clk_sys_i       : in  std_logic;
      rst_n_i         : in  std_logic;
      pll_locked_i    : in  std_logic;
      pulse_a_o       : out std_logic;
      tm_time_valid_i : in  std_logic;
      tm_utc_i        : in  std_logic_vector(39 downto 0);
      tm_cycles_i     : in  std_logic_vector(27 downto 0);
      trig_ready_o    : out std_logic;
      trig_seconds_i  : in  std_logic_vector(39 downto 0);
      trig_cycles_i   : in  std_logic_vector(27 downto 0);
      trig_frac_i     : in  std_logic_vector(11 downto 0);
      trig_valid_p1_i : in  std_logic;
      duration_i      : in  std_logic_vector(27 downto 0);
      -- Spartan-6 specific signals (from a BUFPLL)
      clk_ioclk_i     : in  std_logic;
      serdes_strobe_i : in  std_logic
      );
  end component;

  component serdes_pulse_stamper
    generic (
      g_ref_clk_rate : integer);
    port (
      rst_n_i         : in  std_logic;
      clk_ref_i       : in  std_logic;
      clk_sys_i       : in  std_logic;
      pll_locked_i    : in  std_logic;
      pulse_a_i       : in  std_logic;
      tm_time_valid_i : in  std_logic;
      tm_utc_i        : in  std_logic_vector(39 downto 0);
      tm_cycles_i     : in  std_logic_vector(27 downto 0);
      tag_utc_o       : out std_logic_vector(39 downto 0);
      tag_cycles_o    : out std_logic_vector(27 downto 0);
      tag_frac_o      : out std_logic_vector(11 downto 0);
      tag_valid_p1_o  : out std_logic;
      -- Spartan-6 specific signals (from a BUFPLL)
      clk_ioclk_i     : in  std_logic;
      serdes_strobe_i : in  std_logic
      );
  end component;

  function f_resize_slv (x : std_logic_vector; len : integer) return std_logic_vector is
    variable tmp : std_logic_vector(len-1 downto 0);
  begin
    if(len > x'length) then
      tmp(x'length-1 downto 0)   := x;
      tmp(len-1 downto x'length) := (others => '0');
    elsif(len < x'length) then
      tmp := x(len-1 downto 0);
    else
      tmp := x;
    end if;
    return tmp;
  end f_resize_slv;

  function f_int2bool (x : integer) return boolean is
  begin
    if(x = 0) then
      return false;
    else
      return true;
    end if;
  end f_int2bool;

  constant c_NUM_WB_MASTERS : integer := 2;
  constant c_NUM_WB_SLAVES  : integer := 2;

  constant c_MASTER_GENNUM    : integer := 0;
  constant c_MASTER_ETHERBONE : integer := 1;

  constant c_SLAVE_TRIG_DIST : integer := 0;
  constant c_SLAVE_WRCORE    : integer := 1;

  constant c_WRCORE_BRIDGE_SDB   : t_sdb_bridge := f_xwb_bridge_manual_sdb(x"0003ffff", x"00030000");
  constant c_TRIGDIST_BRIDGE_SDB : t_sdb_bridge := f_xwb_bridge_manual_sdb(x"0000ffff", x"0000f000");

  constant c_INTERCONNECT_LAYOUT : t_sdb_record_array(c_NUM_WB_MASTERS-1 downto 0) :=
    (c_SLAVE_WRCORE    => f_sdb_embed_bridge(c_WRCORE_BRIDGE_SDB, x"000c0000"),
     c_SLAVE_TRIG_DIST => f_sdb_embed_bridge(c_TRIGDIST_BRIDGE_SDB, x"00080000"));

  constant c_SDB_ADDRESS : t_wishbone_address := x"00000000";

  signal pllout_clk_sys       : std_logic;
  signal pllout_clk_ref       : std_logic;
  signal pllout_clk_ref8x     : std_logic;
  signal pllout_clk_dmtd      : std_logic;
  signal pllout_clk_fb_pllref : std_logic;
  signal pllout_clk_fb_dmtd   : std_logic;

  signal clk_20m_vcxo_buf : std_logic;
  signal clk_125m_pllref  : std_logic;
  signal clk_ref8x        : std_logic;
  signal clk_125m_gtp     : std_logic;
  signal clk_sys          : std_logic;
  signal clk_dmtd         : std_logic;
  signal clk_ref          : std_logic;

  signal dac_hpll_load_p1 : std_logic;
  signal dac_dpll_load_p1 : std_logic;
  signal dac_hpll_data    : std_logic_vector(15 downto 0);
  signal dac_dpll_data    : std_logic_vector(15 downto 0);

  signal phy_tx_data      : std_logic_vector(7 downto 0);
  signal phy_tx_k         : std_logic;
  signal phy_tx_disparity : std_logic;
  signal phy_tx_enc_err   : std_logic;
  signal phy_rx_data      : std_logic_vector(7 downto 0);
  signal phy_rx_rbclk     : std_logic;
  signal phy_rx_k         : std_logic;
  signal phy_rx_enc_err   : std_logic;
  signal phy_rx_bitslide  : std_logic_vector(3 downto 0);
  signal phy_rst          : std_logic;
  signal phy_loopen       : std_logic;

  signal local_reset_n : std_logic;

  signal cnx_master_out : t_wishbone_master_out_array(c_NUM_WB_MASTERS-1 downto 0);
  signal cnx_master_in  : t_wishbone_master_in_array(c_NUM_WB_MASTERS-1 downto 0);

  signal cnx_slave_out : t_wishbone_slave_out_array(c_NUM_WB_SLAVES-1 downto 0);
  signal cnx_slave_in  : t_wishbone_slave_in_array(c_NUM_WB_SLAVES-1 downto 0);


  signal tm_seconds    : std_logic_vector(39 downto 0);
  signal tm_cycles     : std_logic_vector(27 downto 0);
  signal tm_time_valid : std_logic;

  signal wrc_scl_out, wrc_scl_in, wrc_sda_out, wrc_sda_in : std_logic;
  signal sfp_scl_out, sfp_scl_in, sfp_sda_out, sfp_sda_in : std_logic;
  signal wrc_owr_en, wrc_owr_in                           : std_logic_vector(1 downto 0);

  signal gn_wb_adr : std_logic_vector(31 downto 0);

  signal pps : std_logic;

  signal etherbone_rst_n   : std_logic;
  signal etherbone_src_out : t_wrf_source_out;
  signal etherbone_src_in  : t_wrf_source_in;
  signal etherbone_snk_out : t_wrf_sink_out;
  signal etherbone_snk_in  : t_wrf_sink_in;

  signal streamer_src_out : t_wrf_source_out;
  signal streamer_src_in  : t_wrf_source_in;
  signal streamer_snk_out : t_wrf_sink_out;
  signal streamer_snk_in  : t_wrf_sink_in;

  signal mux_src_out : t_wrf_source_out;
  signal mux_src_in  : t_wrf_source_in;
  signal mux_snk_out : t_wrf_sink_out;
  signal mux_snk_in  : t_wrf_sink_in;

  signal etherbone_cfg_in  : t_wishbone_slave_in;
  signal etherbone_cfg_out : t_wishbone_slave_out;

  signal vic_irqs : std_logic_vector(31 downto 0);

  attribute buffer_type                    : string;  --" {bufgdll | ibufg | bufgp | ibuf | bufr | none}";
  attribute buffer_type of clk_125m_pllref : signal is "BUFG";

-------------------------------------------------------------------------------
-- Trigger Distribution Core signals
-------------------------------------------------------------------------------

  signal dio_in                        : std_logic_vector(4 downto 0);
  signal dio_out                       : std_logic_vector(4 downto 0);
  signal input_sel                     : std_logic_vector(4 downto 0);
  signal timestamps_in, timestamps_out : t_timestamp_array(4 downto 0);
  signal pll_locked                    : std_logic;
  signal iserdes_ioclk, iserdes_strobe : std_logic_vector(4 downto 0);
  signal oserdes_ioclk, oserdes_strobe : std_logic_vector(4 downto 0);

  signal bank0_serdes_ioclk, bank0_serdes_strobe : std_logic;
  signal bank2_serdes_ioclk, bank2_serdes_strobe : std_logic;
  
  
begin

  U_Reset_Generator : spec_reset_gen
    port map (
      clk_sys_i        => clk_sys,
      rst_pcie_n_a_i   => l_rst_n,
      rst_button_n_a_i => button1_i,
      rst_n_o          => local_reset_n);

  U_Buf_CLK_PLL : IBUFGDS
    generic map (
      DIFF_TERM    => true,
      IBUF_LOW_PWR => true  -- Low power (TRUE) vs. performance (FALSE) setting for referenced
      )
    port map (
      O  => clk_125m_pllref,            -- Buffer output
      I  => clk_125m_pllref_p_i,  -- Diff_p buffer input (connect directly to top-level port)
      IB => clk_125m_pllref_n_i  -- Diff_n buffer input (connect directly to top-level port)
      );

  U_Buf_CLK_GTP : IBUFDS
    generic map (
      DIFF_TERM    => true,
      IBUF_LOW_PWR => false  -- Low power (TRUE) vs. performance (FALSE) setting for referenced
      )
    port map (
      O  => clk_125m_gtp,
      I  => clk_125m_gtp_p_i,
      IB => clk_125m_gtp_n_i
      );


  cmp_sys_clk_pll : PLL_BASE
    generic map (
      BANDWIDTH          => "OPTIMIZED",
      CLK_FEEDBACK       => "CLKFBOUT",
      COMPENSATION       => "INTERNAL",
      DIVCLK_DIVIDE      => 1,
      CLKFBOUT_MULT      => 8,
      CLKFBOUT_PHASE     => 0.000,
      CLKOUT0_DIVIDE     => 8,          -- 125 MHz
      CLKOUT0_PHASE      => 0.000,
      CLKOUT0_DUTY_CYCLE => 0.500,
      CLKOUT1_DIVIDE     => 1,          -- 1 GHz
      CLKOUT1_PHASE      => 0.000,
      CLKOUT1_DUTY_CYCLE => 0.500,
      CLKOUT2_DIVIDE     => 16,         -- 62.5 MHz
      CLKOUT2_PHASE      => 0.000,
      CLKOUT2_DUTY_CYCLE => 0.500,
      CLKIN_PERIOD       => 8.0,
      REF_JITTER         => 0.016)
    port map (
      CLKFBOUT => pllout_clk_fb_pllref,
      CLKOUT0  => pllout_clk_ref,
      CLKOUT1  => pllout_clk_ref8x,
      CLKOUT2  => pllout_clk_sys,
      CLKOUT3  => open,
      CLKOUT4  => open,
      CLKOUT5  => open,
      LOCKED   => pll_locked,
      RST      => '0',
      CLKFBIN  => pllout_clk_fb_pllref,
      CLKIN    => clk_125m_pllref);

  cmp_dmtd_clk_pll : PLL_BASE
    generic map (
      BANDWIDTH          => "OPTIMIZED",
      CLK_FEEDBACK       => "CLKFBOUT",
      COMPENSATION       => "INTERNAL",
      DIVCLK_DIVIDE      => 1,
      CLKFBOUT_MULT      => 50,
      CLKFBOUT_PHASE     => 0.000,
      CLKOUT0_DIVIDE     => 16,         -- 62.5 MHz
      CLKOUT0_PHASE      => 0.000,
      CLKOUT0_DUTY_CYCLE => 0.500,
      CLKOUT1_DIVIDE     => 16,         -- 62.5 MHz
      CLKOUT1_PHASE      => 0.000,
      CLKOUT1_DUTY_CYCLE => 0.500,
      CLKOUT2_DIVIDE     => 8,
      CLKOUT2_PHASE      => 0.000,
      CLKOUT2_DUTY_CYCLE => 0.500,
      CLKIN_PERIOD       => 50.0,
      REF_JITTER         => 0.016)
    port map (
      CLKFBOUT => pllout_clk_fb_dmtd,
      CLKOUT0  => pllout_clk_dmtd,
      CLKOUT1  => open,                 --pllout_clk_sys,
      CLKOUT2  => open,
      CLKOUT3  => open,
      CLKOUT4  => open,
      CLKOUT5  => open,
      LOCKED   => open,
      RST      => '0',
      CLKFBIN  => pllout_clk_fb_dmtd,
      CLKIN    => clk_20m_vcxo_buf);

  cmp_clk_sys_buf : BUFG
    port map (
      O => clk_sys,
      I => pllout_clk_sys);

  --cmp_clk_ref8x_buf : BUFG
  --  port map (
  --    O => clk_ref8x,
  --    I => pllout_clk_ref8x);

  cmp_clk_ref_buf : BUFG
    port map (
      O => clk_ref,
      I => pllout_clk_ref);

  cmp_clk_dmtd_buf : BUFG
    port map (
      O => clk_dmtd,
      I => pllout_clk_dmtd);

  cmp_clk_vcxo : BUFG
    port map (
      O => clk_20m_vcxo_buf,
      I => clk_20m_vcxo_i);

-------------------------------------------------------------------------------
-- Gennum core
-------------------------------------------------------------------------------

  cmp_gn4124_core : gn4124_core
    port map
    (
      ---------------------------------------------------------
      -- Control and status
      rst_n_a_i => L_RST_N,
      status_o  => open,

      ---------------------------------------------------------
      -- P2L Direction
      --
      -- Source Sync DDR related signals
      p2l_clk_p_i  => P2L_CLKp,
      p2l_clk_n_i  => P2L_CLKn,
      p2l_data_i   => P2L_DATA,
      p2l_dframe_i => P2L_DFRAME,
      p2l_valid_i  => P2L_VALID,
      -- P2L Control
      p2l_rdy_o    => P2L_RDY,
      p_wr_req_i   => P_WR_REQ,
      p_wr_rdy_o   => P_WR_RDY,
      rx_error_o   => RX_ERROR,
      vc_rdy_i     => VC_RDY,

      ---------------------------------------------------------
      -- L2P Direction
      --
      -- Source Sync DDR related signals
      l2p_clk_p_o  => L2P_CLKp,
      l2p_clk_n_o  => L2P_CLKn,
      l2p_data_o   => L2P_DATA,
      l2p_dframe_o => L2P_DFRAME,
      l2p_valid_o  => L2P_VALID,
      -- L2P Control
      l2p_edb_o    => L2P_EDB,
      l2p_rdy_i    => L2P_RDY,
      l_wr_rdy_i   => L_WR_RDY,
      p_rd_d_rdy_i => P_RD_D_RDY,
      tx_error_i   => TX_ERROR,

      ---------------------------------------------------------
      -- Interrupt interface
      dma_irq_o => open,
      irq_p_i   => '0',
      irq_p_o   => open,

      dma_reg_clk_i => clk_sys,

      ---------------------------------------------------------
      -- CSR wishbone interface (master pipelined)
      csr_clk_i   => clk_sys,
      csr_adr_o   => gn_wb_adr,
      csr_dat_o   => cnx_slave_in(c_MASTER_GENNUM).dat,
      csr_sel_o   => cnx_slave_in(c_MASTER_GENNUM).sel,
      csr_stb_o   => cnx_slave_in(c_MASTER_GENNUM).stb,
      csr_we_o    => cnx_slave_in(c_MASTER_GENNUM).we,
      csr_cyc_o   => cnx_slave_in(c_MASTER_GENNUM).cyc,
      csr_dat_i   => cnx_slave_out(c_MASTER_GENNUM).dat,
      csr_ack_i   => cnx_slave_out(c_MASTER_GENNUM).ack,
      csr_stall_i => cnx_slave_out(c_MASTER_GENNUM).stall,

      dma_clk_i   => clk_sys,
      dma_ack_i   => '1',
      dma_stall_i => '0',
      dma_dat_i   => (others => '0'),

      dma_reg_adr_i => (others => '0'),
      dma_reg_dat_i => (others => '0'),
      dma_reg_sel_i => (others => '0'),
      dma_reg_stb_i => '0',
      dma_reg_cyc_i => '0',
      dma_reg_we_i  => '0'
      );

  cnx_slave_in(c_MASTER_GENNUM).adr <= gn_wb_adr(29 downto 0) & "00";

-------------------------------------------------------------------------------
-- Top level interconnect and interrupt controller
-------------------------------------------------------------------------------

  U_Intercon : xwb_sdb_crossbar
    generic map (
      g_num_masters => c_NUM_WB_SLAVES,
      g_num_slaves  => c_NUM_WB_MASTERS,
      g_registered  => true,
      g_wraparound  => true,
      g_layout      => c_INTERCONNECT_LAYOUT,
      g_sdb_addr    => c_SDB_ADDRESS)
    port map (
      clk_sys_i => clk_sys,
      rst_n_i   => local_reset_n,
      slave_i   => cnx_slave_in,
      slave_o   => cnx_slave_out,
      master_i  => cnx_master_in,
      master_o  => cnx_master_out);

-------------------------------------------------------------------------------
-- White Rabbit Core + PHY
-------------------------------------------------------------------------------

  -- Tristates for FMC EEPROM
  fmc_scl_b  <= '0' when (wrc_scl_out = '0') else 'Z';
  fmc_sda_b  <= '0' when (wrc_sda_out = '0') else 'Z';
  wrc_scl_in <= fmc_scl_b;
  wrc_sda_in <= fmc_sda_b;

  -- Tristates for SFP EEPROM
  sfp_mod_def1_b <= '0' when sfp_scl_out = '0' else 'Z';
  sfp_mod_def2_b <= '0' when sfp_sda_out = '0' else 'Z';
  sfp_scl_in     <= sfp_mod_def1_b;
  sfp_sda_in     <= sfp_mod_def2_b;

  carrier_onewire_b <= '0' when wrc_owr_en(0) = '1' else 'Z';
  wrc_owr_in(0)     <= carrier_onewire_b;

  U_WR_CORE : xwr_core
    generic map (
      g_simulation                => g_simulation,
      g_phys_uart                 => true,
      g_virtual_uart              => true,
      g_with_external_clock_input => false,
      g_aux_clks                  => 0,
      g_ep_rxbuf_size             => 1024,
      g_dpram_initf               => "wrc.ram",
      g_dpram_size                => 90112/4,
      g_interface_mode            => PIPELINED,
      g_address_granularity       => BYTE,
      g_aux_sdb                   => c_etherbone_sdb)
    port map (
      clk_sys_i  => clk_sys,
      clk_dmtd_i => clk_dmtd,
      clk_ref_i  => clk_ref,
      rst_n_i    => local_reset_n,

      dac_hpll_load_p1_o => dac_hpll_load_p1,
      dac_hpll_data_o    => dac_hpll_data,
      dac_dpll_load_p1_o => dac_dpll_load_p1,
      dac_dpll_data_o    => dac_dpll_data,

      phy_ref_clk_i      => clk_ref,
      phy_tx_data_o      => phy_tx_data,
      phy_tx_k_o         => phy_tx_k,
      phy_tx_disparity_i => phy_tx_disparity,
      phy_tx_enc_err_i   => phy_tx_enc_err,
      phy_rx_data_i      => phy_rx_data,
      phy_rx_rbclk_i     => phy_rx_rbclk,
      phy_rx_k_i         => phy_rx_k,
      phy_rx_enc_err_i   => phy_rx_enc_err,
      phy_rx_bitslide_i  => phy_rx_bitslide,
      phy_rst_o          => phy_rst,
      phy_loopen_o       => phy_loopen,

      led_red_o   => LED_RED,
      led_green_o => LED_GREEN,

      scl_o     => wrc_scl_out,
      scl_i     => wrc_scl_in,
      sda_o     => wrc_sda_out,
      sda_i     => wrc_sda_in,
      sfp_scl_o => sfp_scl_out,
      sfp_scl_i => sfp_scl_in,
      sfp_sda_o => sfp_sda_out,
      sfp_sda_i => sfp_sda_in,
      sfp_det_i => sfp_mod_def0_b,

      uart_rxd_i => uart_rxd_i,
      uart_txd_o => uart_txd_o,

      owr_en_o => wrc_owr_en,
      owr_i    => wrc_owr_in,

      slave_i => cnx_master_out(c_SLAVE_WRCORE),
      slave_o => cnx_master_in(c_SLAVE_WRCORE),

      aux_master_o => etherbone_cfg_in,
      aux_master_i => etherbone_cfg_out,

      wrf_src_o => mux_snk_in,
      wrf_src_i => mux_snk_out,
      wrf_snk_o => mux_src_in,
      wrf_snk_i => mux_src_out,

--      tm_link_up_o    => tm_link_up,
      tm_time_valid_o      => tm_time_valid,
      tm_utc_o             => tm_seconds,
      tm_cycles_o          => tm_cycles,
      tm_clk_aux_lock_en_i => '0',

      btn1_i => '1',
      btn2_i => '1',

      rst_aux_n_o => etherbone_rst_n,
      pps_p_o     => pps
      );


  gen_real_phy : if (g_simulation = 0) generate
    
    U_GTP : wr_gtp_phy_spartan6
      generic map (
        g_simulation => g_simulation,
        g_enable_ch0 => 0,
        g_enable_ch1 => 1)
      port map (
        gtp_clk_i          => clk_125m_gtp,
        ch0_ref_clk_i      => clk_ref,
        ch0_tx_data_i      => x"00",
        ch0_tx_k_i         => '0',
        ch0_tx_disparity_o => open,
        ch0_tx_enc_err_o   => open,
        ch0_rx_rbclk_o     => open,
        ch0_rx_data_o      => open,
        ch0_rx_k_o         => open,
        ch0_rx_enc_err_o   => open,
        ch0_rx_bitslide_o  => open,
        ch0_rst_i          => '1',
        ch0_loopen_i       => '0',

        ch1_ref_clk_i      => clk_ref,
        ch1_tx_data_i      => phy_tx_data,
        ch1_tx_k_i         => phy_tx_k,
        ch1_tx_disparity_o => phy_tx_disparity,
        ch1_tx_enc_err_o   => phy_tx_enc_err,
        ch1_rx_data_o      => phy_rx_data,
        ch1_rx_rbclk_o     => phy_rx_rbclk,
        ch1_rx_k_o         => phy_rx_k,
        ch1_rx_enc_err_o   => phy_rx_enc_err,
        ch1_rx_bitslide_o  => phy_rx_bitslide,
        ch1_rst_i          => phy_rst,
        ch1_loopen_i       => '0',      --phy_loopen,
        pad_txn0_o         => open,
        pad_txp0_o         => open,
        pad_rxn0_i         => '0',
        pad_rxp0_i         => '0',
        pad_txn1_o         => sfp_txn_o,
        pad_txp1_o         => sfp_txp_o,
        pad_rxn1_i         => sfp_rxn_i,
        pad_rxp1_i         => sfp_rxp_i);

  end generate gen_real_phy;

  gen_tbi_phy : if (g_simulation /= 0) generate

    phy_rx_rbclk <= clk_ref;            -- after 1ns;

    U_TBI_PHY : wr_tbi_phy
      port map (
        serdes_rst_i          => phy_rst,
        serdes_loopen_i       => '0',
        serdes_prbsen_i       => '0',
        serdes_enable_i       => '1',
        serdes_syncen_i       => '1',
        serdes_tx_data_i      => phy_tx_data,
        serdes_tx_k_i         => phy_tx_k,
        serdes_tx_disparity_o => phy_tx_disparity,
        serdes_tx_enc_err_o   => phy_tx_enc_err,
        serdes_rx_data_o      => phy_rx_data,
        serdes_rx_k_o         => phy_rx_k,
        serdes_rx_enc_err_o   => phy_rx_enc_err,
        serdes_rx_bitslide_o  => open,
        tbi_refclk_i          => clk_ref,
        tbi_rbclk_i           => clk_ref,
        tbi_td_o              => tbi_td_o,
        tbi_rd_i              => tbi_rd_i);
  end generate gen_tbi_phy;

  U_Packet_Mux : xwrf_mux
    generic map (
      g_muxed_ports => 2)
    port map (
      clk_sys_i => clk_sys,
      rst_n_i   => local_reset_n,

      ep_src_o => mux_src_out,
      ep_src_i => mux_src_in,
      ep_snk_o => mux_snk_out,
      ep_snk_i => mux_snk_in,

      mux_src_o(0) => etherbone_snk_in,
      mux_src_o(1) => streamer_snk_in,
      mux_src_i(0) => etherbone_snk_out,
      mux_src_i(1) => streamer_snk_out,
      mux_snk_o(0) => etherbone_src_in,
      mux_snk_o(1) => streamer_src_in,
      mux_snk_i(0) => etherbone_src_out,
      mux_snk_i(1) => streamer_src_out,

      mux_class_i(0) => "10000000",
      mux_class_i(1) => "01000000");

  
  U_Etherbone : eb_slave_core
    generic map (
      g_sdb_address => f_resize_slv(c_sdb_address, 64))
    port map (
      clk_i       => clk_sys,
      nRst_i      => etherbone_rst_n,
      src_o       => etherbone_src_out,
      src_i       => etherbone_src_in,
      snk_o       => etherbone_snk_out,
      snk_i       => etherbone_snk_in,
      cfg_slave_o => etherbone_cfg_out,
      cfg_slave_i => etherbone_cfg_in,
      master_o    => cnx_slave_in(c_MASTER_ETHERBONE),
      master_i    => cnx_slave_out(c_MASTER_ETHERBONE));


  U_DAC_ARB : spec_serial_dac_arb
    generic map (
      g_invert_sclk    => false,
      g_num_extra_bits => 8)

    port map (
      clk_i   => clk_sys,
      rst_n_i => local_reset_n,

      val1_i  => dac_dpll_data,
      load1_i => dac_dpll_load_p1,

      val2_i  => dac_hpll_data,
      load2_i => dac_hpll_load_p1,

      dac_cs_n_o(0) => dac_cs1_n_o,
      dac_cs_n_o(1) => dac_cs2_n_o,
--      dac_clr_n_o   => open,
      dac_sclk_o    => dac_sclk_o,
      dac_din_o     => dac_din_o);

--  dac_clr_n_o <= '1';

  sfp_tx_disable_o <= '0';

-------------------------------------------------------------------------------
-- Trigger Distribution Core -- DIO Version
-------------------------------------------------------------------------------


  U_TrigDist_Core : trigger_dist_core
    generic map (
      g_num_inputs  => 5,
      g_num_outputs => 5,
      g_core_type   => 0)
    port map (
      clk_sys_i       => clk_sys,
      rst_n_i         => local_reset_n,
      tm_time_valid_i => tm_time_valid,
      tm_seconds_i    => tm_seconds,
      tm_cycles_i     => tm_cycles,
      timestamps_i    => timestamps_in,
      timestamps_o    => timestamps_out,
      input_sel_o     => input_sel,
      snk_i           => streamer_snk_in,
      snk_o           => streamer_snk_out,
      src_i           => streamer_src_in,
      src_o           => streamer_src_out,
      slave_i         => cnx_master_out(c_SLAVE_TRIG_DIST),
      slave_o         => cnx_master_in(c_SLAVE_TRIG_DIST));

  --streamer_src_in.ack <= '1';
  --streamer_src_in.stall <= '0';
  --streamer_src_in.err <= '0';
  --streamer_src_in.rty <= '0';

  U_BufPLL_Bank0 : BUFPLL
    generic map (
      DIVIDE => 8)
    port map (
      IOCLK        => bank0_serdes_ioclk,
      LOCK         => open,
      SERDESSTROBE => bank0_serdes_strobe,
      GCLK         => clk_ref,
      LOCKED       => pll_locked,
      PLLIN        => pllout_clk_ref8x);

  U_BufPLL_Bank2 : BUFPLL
    generic map (
      DIVIDE => 8)
    port map (
      IOCLK        => bank2_serdes_ioclk,
      LOCK         => open,
      SERDESSTROBE => bank2_serdes_strobe,
      GCLK         => clk_ref,
      LOCKED       => pll_locked,
      PLLIN        => pllout_clk_ref8x);

  iserdes_ioclk(4 downto 1) <= (others => bank2_serdes_ioclk);
  oserdes_ioclk(4 downto 1) <= (others => bank2_serdes_ioclk);
  iserdes_strobe(4 downto 1) <= (others => bank2_serdes_strobe);
  oserdes_strobe(4 downto 1) <= (others => bank2_serdes_strobe);

  iserdes_ioclk(0) <= bank0_serdes_ioclk;
  oserdes_ioclk(0) <= bank2_serdes_ioclk;
  iserdes_strobe(0) <= bank0_serdes_strobe;
  oserdes_strobe(0) <= bank2_serdes_strobe;
  
  gen_stampers : for i in 1 to 4 generate

    U_StamperX : serdes_pulse_stamper
      generic map (
        g_ref_clk_rate => 125000000)
      port map (
        rst_n_i         => local_reset_n,
        clk_ref_i       => clk_ref,
        clk_sys_i       => clk_sys,
        pll_locked_i    => pll_locked,
        pulse_a_i       => dio_in(i),
        tm_time_valid_i => tm_time_valid,
        tm_utc_i        => tm_seconds,
        tm_cycles_i     => tm_cycles,
        tag_utc_o       => timestamps_in(i).seconds,
        tag_cycles_o    => timestamps_in(i).cycles,
        tag_frac_o      => timestamps_in(i).frac,
        tag_valid_p1_o  => timestamps_in(i).valid,
        clk_ioclk_i     => iserdes_ioclk(i),
        serdes_strobe_i => iserdes_strobe(i));

  end generate gen_stampers;

  gen_pulse_generators : for i in 1 to 4 generate
    U_PulseGen_X : serdes_pulse_gen
      port map (
        clk_ref_i       => clk_ref,
        clk_sys_i       => clk_sys,
        rst_n_i         => local_reset_n,
        pll_locked_i    => pll_locked,
        pulse_a_o       => dio_out(i),
        tm_time_valid_i => tm_time_valid,
        tm_utc_i        => tm_seconds,
        tm_cycles_i     => tm_cycles,
        trig_ready_o    => open,
        trig_seconds_i  => timestamps_out(i).seconds,
        trig_cycles_i   => timestamps_out(i).cycles,
        trig_frac_i     => timestamps_out(i).frac,
        trig_valid_p1_i => timestamps_out(i).valid,
        duration_i      => x"000007c",
        clk_ioclk_i     => oserdes_ioclk(i),
        serdes_strobe_i => oserdes_strobe(i)
        );
  end generate gen_pulse_generators;

  gen_dio_iobufs : for i in 0 to 4 generate

    U_ibuf : IBUFDS
      generic map (
        DIFF_TERM => true)
      port map (
        O  => dio_in(i),
        I  => dio_p_i(i),
        IB => dio_n_i(i)
        );

    U_obuf : OBUFDS
      port map (
        I  => dio_out(i),
        O  => dio_p_o(i),
        OB => dio_n_o(i)
        );

    dio_oe_n_o (i)    <= input_sel(i);
    dio_term_en_o (i) <= input_sel(i);
  end generate gen_dio_iobufs;

  dio_led_top_o <= pps;
  dio_led_bot_o <= '0';

  dio_sdn_ck_n_o <= '1';
  dio_sdn_n_o    <= '1';
  
end rtl;


