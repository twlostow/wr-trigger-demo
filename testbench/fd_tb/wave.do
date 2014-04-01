onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/g_index
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/clk_ref_i
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/clk_sys_i
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/rst_n_ref_i
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/rst_n_sys_i
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/csync_p1_i
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/csync_utc_i
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/csync_coarse_i
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/gen_cal_i
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/tag_valid_i
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/tag_utc_i
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/tag_coarse_i
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/tag_frac_i
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/pstart_valid_o
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/pstart_utc_o
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/pstart_coarse_o
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/pstart_frac_o
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/delay_pulse0_o
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/delay_pulse1_o
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/delay_value_o
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/delay_load_o
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/delay_load_done_i
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/delay_idle_o
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/wb_i
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/wb_o
add wave -noupdate -group FD-Q0 -expand /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/tb_cntr
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/tag_tdc
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/start_int
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/end_int
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/delta_int
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/rep_n_int
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/pulse_count
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/rep_cont_int
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/no_fine_int
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/pstart
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/pend
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/start_adder_en
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/end_adder_en
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/start_delay_setpoint
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/end_delay_setpoint
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/start_falling
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/end_falling
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/gt_start_stage0
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/hit_start_stage0
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/hit_end_stage0
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/gt_start_stage1
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/hit_start_stage1
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/hit_end_stage1
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/gt_start
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/hit_start
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/hit_end
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/pulse_pending
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/gen_cal_extended
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/state
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/mode_int
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/pending_update
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/first_pulse
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/first_pulse_till_hit
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/sadd_a
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/sadd_b
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/eadd_a
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/eadd_b
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/tag_valid_d
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/dcr_arm_d
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/regs_in
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/regs_out
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/CONTROL
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/CLK
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/TRIG0
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/TRIG1
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/TRIG2
add wave -noupdate -group FD-Q0 /main/DUT_B/U_FineDelay_Core/gen_output_channels(0)/U_Output_ChannelX/TRIG3
add wave -noupdate -group BoardA /main/U_BoardA/trig_i
add wave -noupdate -group BoardA /main/I_fmc0/trig_a
add wave -noupdate -group BoardA /main/U_BoardA/out_o
add wave -noupdate -group BoardA /main/U_BoardA/clk_ref_250
add wave -noupdate -group BoardA /main/U_BoardA/clk_ref_125
add wave -noupdate -group BoardA /main/U_BoardA/clk_tdc
add wave -noupdate -group BoardA /main/U_BoardA/tdc_start_div
add wave -noupdate -group BoardA /main/U_BoardA/tdc_start
add wave -noupdate -group BoardA /main/U_BoardA/trig_a_muxed
add wave -noupdate -group BoardA /main/U_BoardA/spi_gpio_out
add wave -noupdate -group BoardA /main/U_BoardA/trig_cal_sel
add wave -noupdate -group BoardA /main/U_BoardA/tdc_start_delayed
add wave -noupdate -group BoardA /main/U_BoardA/trig_i
add wave -noupdate -group BoardA /main/U_BoardA/out_o
add wave -noupdate -group WB_A /main/I_WBA/g_addr_width
add wave -noupdate -group WB_A /main/I_WBA/g_data_width
add wave -noupdate -group WB_A /main/I_WBA/clk_i
add wave -noupdate -group WB_A /main/I_WBA/rst_n_i
add wave -noupdate -group WB_A /main/I_WBA/adr
add wave -noupdate -group WB_A /main/I_WBA/dat_o
add wave -noupdate -group WB_A /main/I_WBA/sel
add wave -noupdate -group WB_A /main/I_WBA/dat_i
add wave -noupdate -group WB_A /main/I_WBA/ack
add wave -noupdate -group WB_A /main/I_WBA/stall
add wave -noupdate -group WB_A /main/I_WBA/err
add wave -noupdate -group WB_A /main/I_WBA/rty
add wave -noupdate -group WB_A /main/I_WBA/cyc
add wave -noupdate -group WB_A /main/I_WBA/stb
add wave -noupdate -group WB_A /main/I_WBA/we
add wave -noupdate -group WB_A /main/I_WBA/clk
add wave -noupdate -group WB_A /main/I_WBA/rst_n
add wave -noupdate -group WB_A /main/I_WBA/last_access_t
add wave -noupdate -group WB_A /main/I_WBA/settings
add wave -noupdate -group WB_A /main/I_WBA/xf_idle
add wave -noupdate -group WB_A /main/I_WBA/ack_cnt_int
add wave -noupdate -group WB_A /main/I_WBA/clk_i
add wave -noupdate -group WB_A /main/I_WBA/rst_n_i
add wave -noupdate -group TopA /main/DUT_A/g_standalone
add wave -noupdate -group TopA /main/DUT_A/g_simulation
add wave -noupdate -group TopA /main/DUT_A/g_with_gennum
add wave -noupdate -group TopA /main/DUT_A/clk_20m_vcxo_i
add wave -noupdate -group TopA /main/DUT_A/clk_125m_pllref_p_i
add wave -noupdate -group TopA /main/DUT_A/clk_125m_pllref_n_i
add wave -noupdate -group TopA /main/DUT_A/clk_125m_gtp_n_i
add wave -noupdate -group TopA /main/DUT_A/clk_125m_gtp_p_i
add wave -noupdate -group TopA /main/DUT_A/l_rst_n
add wave -noupdate -group TopA /main/DUT_A/gpio
add wave -noupdate -group TopA /main/DUT_A/p2l_rdy
add wave -noupdate -group TopA /main/DUT_A/p2l_clkn
add wave -noupdate -group TopA /main/DUT_A/p2l_clkp
add wave -noupdate -group TopA /main/DUT_A/p2l_data
add wave -noupdate -group TopA /main/DUT_A/p2l_dframe
add wave -noupdate -group TopA /main/DUT_A/p2l_valid
add wave -noupdate -group TopA /main/DUT_A/p_wr_req
add wave -noupdate -group TopA /main/DUT_A/p_wr_rdy
add wave -noupdate -group TopA /main/DUT_A/rx_error
add wave -noupdate -group TopA /main/DUT_A/l2p_data
add wave -noupdate -group TopA /main/DUT_A/l2p_dframe
add wave -noupdate -group TopA /main/DUT_A/l2p_valid
add wave -noupdate -group TopA /main/DUT_A/l2p_clkn
add wave -noupdate -group TopA /main/DUT_A/l2p_clkp
add wave -noupdate -group TopA /main/DUT_A/l2p_edb
add wave -noupdate -group TopA /main/DUT_A/l2p_rdy
add wave -noupdate -group TopA /main/DUT_A/l_wr_rdy
add wave -noupdate -group TopA /main/DUT_A/p_rd_d_rdy
add wave -noupdate -group TopA /main/DUT_A/tx_error
add wave -noupdate -group TopA /main/DUT_A/vc_rdy
add wave -noupdate -group TopA /main/DUT_A/led_red
add wave -noupdate -group TopA /main/DUT_A/led_green
add wave -noupdate -group TopA /main/DUT_A/dac_sclk_o
add wave -noupdate -group TopA /main/DUT_A/dac_din_o
add wave -noupdate -group TopA /main/DUT_A/dac_cs1_n_o
add wave -noupdate -group TopA /main/DUT_A/dac_cs2_n_o
add wave -noupdate -group TopA /main/DUT_A/button1_i
add wave -noupdate -group TopA /main/DUT_A/button2_i
add wave -noupdate -group TopA /main/DUT_A/fmc_scl_b
add wave -noupdate -group TopA /main/DUT_A/fmc_sda_b
add wave -noupdate -group TopA /main/DUT_A/carrier_onewire_b
add wave -noupdate -group TopA /main/DUT_A/fmc_prsnt_m2c_l_i
add wave -noupdate -group TopA /main/DUT_A/sfp_txp_o
add wave -noupdate -group TopA /main/DUT_A/sfp_txn_o
add wave -noupdate -group TopA /main/DUT_A/sfp_rxp_i
add wave -noupdate -group TopA /main/DUT_A/sfp_rxn_i
add wave -noupdate -group TopA /main/DUT_A/sfp_mod_def0_b
add wave -noupdate -group TopA /main/DUT_A/sfp_mod_def1_b
add wave -noupdate -group TopA /main/DUT_A/sfp_mod_def2_b
add wave -noupdate -group TopA /main/DUT_A/sfp_rate_select_b
add wave -noupdate -group TopA /main/DUT_A/sfp_tx_fault_i
add wave -noupdate -group TopA /main/DUT_A/sfp_tx_disable_o
add wave -noupdate -group TopA /main/DUT_A/sfp_los_i
add wave -noupdate -group TopA /main/DUT_A/fd_tdc_start_p_i
add wave -noupdate -group TopA /main/DUT_A/fd_tdc_start_n_i
add wave -noupdate -group TopA /main/DUT_A/fd_clk_ref_p_i
add wave -noupdate -group TopA /main/DUT_A/fd_clk_ref_n_i
add wave -noupdate -group TopA /main/DUT_A/fd_trig_a_i
add wave -noupdate -group TopA /main/DUT_A/fd_tdc_cal_pulse_o
add wave -noupdate -group TopA /main/DUT_A/fd_tdc_d_b
add wave -noupdate -group TopA /main/DUT_A/fd_tdc_emptyf_i
add wave -noupdate -group TopA /main/DUT_A/fd_tdc_alutrigger_o
add wave -noupdate -group TopA /main/DUT_A/fd_tdc_wr_n_o
add wave -noupdate -group TopA /main/DUT_A/fd_tdc_rd_n_o
add wave -noupdate -group TopA /main/DUT_A/fd_tdc_oe_n_o
add wave -noupdate -group TopA /main/DUT_A/fd_led_trig_o
add wave -noupdate -group TopA /main/DUT_A/fd_tdc_start_dis_o
add wave -noupdate -group TopA /main/DUT_A/fd_tdc_stop_dis_o
add wave -noupdate -group TopA /main/DUT_A/fd_spi_cs_dac_n_o
add wave -noupdate -group TopA /main/DUT_A/fd_spi_cs_pll_n_o
add wave -noupdate -group TopA /main/DUT_A/fd_spi_cs_gpio_n_o
add wave -noupdate -group TopA /main/DUT_A/fd_spi_sclk_o
add wave -noupdate -group TopA /main/DUT_A/fd_spi_mosi_o
add wave -noupdate -group TopA /main/DUT_A/fd_spi_miso_i
add wave -noupdate -group TopA /main/DUT_A/fd_delay_len_o
add wave -noupdate -group TopA /main/DUT_A/fd_delay_val_o
add wave -noupdate -group TopA /main/DUT_A/fd_delay_pulse_o
add wave -noupdate -group TopA /main/DUT_A/fd_dmtd_clk_o
add wave -noupdate -group TopA /main/DUT_A/fd_dmtd_fb_in_i
add wave -noupdate -group TopA /main/DUT_A/fd_dmtd_fb_out_i
add wave -noupdate -group TopA /main/DUT_A/fd_pll_status_i
add wave -noupdate -group TopA /main/DUT_A/fd_ext_rst_n_o
add wave -noupdate -group TopA /main/DUT_A/fd_onewire_b
add wave -noupdate -group TopA /main/DUT_A/uart_rxd_i
add wave -noupdate -group TopA /main/DUT_A/uart_txd_o
add wave -noupdate -group TopA /main/DUT_A/tbi_td_o
add wave -noupdate -group TopA /main/DUT_A/tbi_rd_i
add wave -noupdate -group TopA /main/DUT_A/pllout_clk_sys
add wave -noupdate -group TopA /main/DUT_A/pllout_clk_dmtd
add wave -noupdate -group TopA /main/DUT_A/pllout_clk_fb_pllref
add wave -noupdate -group TopA /main/DUT_A/pllout_clk_fb_dmtd
add wave -noupdate -group TopA /main/DUT_A/clk_20m_vcxo_buf
add wave -noupdate -group TopA /main/DUT_A/clk_125m_pllref
add wave -noupdate -group TopA /main/DUT_A/clk_125m_gtp
add wave -noupdate -group TopA /main/DUT_A/clk_sys
add wave -noupdate -group TopA /main/DUT_A/clk_dmtd
add wave -noupdate -group TopA /main/DUT_A/dac_hpll_load_p1
add wave -noupdate -group TopA /main/DUT_A/dac_dpll_load_p1
add wave -noupdate -group TopA /main/DUT_A/dac_hpll_data
add wave -noupdate -group TopA /main/DUT_A/dac_dpll_data
add wave -noupdate -group TopA /main/DUT_A/phy_tx_data
add wave -noupdate -group TopA /main/DUT_A/phy_tx_k
add wave -noupdate -group TopA /main/DUT_A/phy_tx_disparity
add wave -noupdate -group TopA /main/DUT_A/phy_tx_enc_err
add wave -noupdate -group TopA /main/DUT_A/phy_rx_data
add wave -noupdate -group TopA /main/DUT_A/phy_rx_rbclk
add wave -noupdate -group TopA /main/DUT_A/phy_rx_k
add wave -noupdate -group TopA /main/DUT_A/phy_rx_enc_err
add wave -noupdate -group TopA /main/DUT_A/phy_rx_bitslide
add wave -noupdate -group TopA /main/DUT_A/phy_rst
add wave -noupdate -group TopA /main/DUT_A/phy_loopen
add wave -noupdate -group TopA /main/DUT_A/local_reset_n
add wave -noupdate -group TopA /main/DUT_A/cnx_master_out
add wave -noupdate -group TopA /main/DUT_A/cnx_master_in
add wave -noupdate -group TopA /main/DUT_A/cnx_slave_out
add wave -noupdate -group TopA /main/DUT_A/cnx_slave_in
add wave -noupdate -group TopA /main/DUT_A/dcm_clk_ref_0
add wave -noupdate -group TopA /main/DUT_A/dcm_clk_ref_180
add wave -noupdate -group TopA /main/DUT_A/fd_tdc_start
add wave -noupdate -group TopA /main/DUT_A/tdc_data_out
add wave -noupdate -group TopA /main/DUT_A/tdc_data_in
add wave -noupdate -group TopA /main/DUT_A/tdc_data_oe
add wave -noupdate -group TopA /main/DUT_A/tm_link_up
add wave -noupdate -group TopA /main/DUT_A/tm_utc
add wave -noupdate -group TopA /main/DUT_A/tm_cycles
add wave -noupdate -group TopA /main/DUT_A/tm_time_valid
add wave -noupdate -group TopA /main/DUT_A/tm_clk_aux_lock_en
add wave -noupdate -group TopA /main/DUT_A/tm_clk_aux_locked
add wave -noupdate -group TopA /main/DUT_A/tm_dac_value
add wave -noupdate -group TopA /main/DUT_A/tm_dac_wr
add wave -noupdate -group TopA /main/DUT_A/ddr_pll_reset
add wave -noupdate -group TopA /main/DUT_A/ddr_pll_locked
add wave -noupdate -group TopA /main/DUT_A/fd_pll_status
add wave -noupdate -group TopA /main/DUT_A/wrc_scl_out
add wave -noupdate -group TopA /main/DUT_A/wrc_scl_in
add wave -noupdate -group TopA /main/DUT_A/wrc_sda_out
add wave -noupdate -group TopA /main/DUT_A/wrc_sda_in
add wave -noupdate -group TopA /main/DUT_A/fd_scl_out
add wave -noupdate -group TopA /main/DUT_A/fd_scl_in
add wave -noupdate -group TopA /main/DUT_A/fd_sda_out
add wave -noupdate -group TopA /main/DUT_A/fd_sda_in
add wave -noupdate -group TopA /main/DUT_A/sfp_scl_out
add wave -noupdate -group TopA /main/DUT_A/sfp_scl_in
add wave -noupdate -group TopA /main/DUT_A/sfp_sda_out
add wave -noupdate -group TopA /main/DUT_A/sfp_sda_in
add wave -noupdate -group TopA /main/DUT_A/wrc_owr_en
add wave -noupdate -group TopA /main/DUT_A/wrc_owr_in
add wave -noupdate -group TopA /main/DUT_A/fd_owr_en
add wave -noupdate -group TopA /main/DUT_A/fd_owr_in
add wave -noupdate -group TopA /main/DUT_A/fd_irq
add wave -noupdate -group TopA /main/DUT_A/gn_wb_adr
add wave -noupdate -group TopA /main/DUT_A/pps
add wave -noupdate -group TopA /main/DUT_A/etherbone_rst_n
add wave -noupdate -group TopA /main/DUT_A/etherbone_src_out
add wave -noupdate -group TopA /main/DUT_A/etherbone_src_in
add wave -noupdate -group TopA /main/DUT_A/etherbone_snk_out
add wave -noupdate -group TopA /main/DUT_A/etherbone_snk_in
add wave -noupdate -group TopA /main/DUT_A/streamer_src_out
add wave -noupdate -group TopA /main/DUT_A/streamer_src_in
add wave -noupdate -group TopA /main/DUT_A/streamer_snk_out
add wave -noupdate -group TopA /main/DUT_A/streamer_snk_in
add wave -noupdate -group TopA /main/DUT_A/mux_src_out
add wave -noupdate -group TopA /main/DUT_A/mux_src_in
add wave -noupdate -group TopA /main/DUT_A/mux_snk_out
add wave -noupdate -group TopA /main/DUT_A/mux_snk_in
add wave -noupdate -group TopA /main/DUT_A/etherbone_cfg_in
add wave -noupdate -group TopA /main/DUT_A/etherbone_cfg_out
add wave -noupdate -group TopA /main/DUT_A/vic_irqs
add wave -noupdate -group TopA /main/DUT_A/timestamps_in
add wave -noupdate -group TopA /main/DUT_A/timestamps_out
add wave -noupdate -group TopA /main/DUT_A/fd_outx_seconds
add wave -noupdate -group TopA /main/DUT_A/fd_outx_cycles
add wave -noupdate -group TopA /main/DUT_A/fd_outx_frac
add wave -noupdate -group TopA /main/DUT_A/fd_outx_valid
add wave -noupdate -group TopA /main/DUT_A/sim_wb_adr
add wave -noupdate -group TopA /main/DUT_A/sim_wb_dat_in
add wave -noupdate -group TopA /main/DUT_A/sim_wb_dat_out
add wave -noupdate -group TopA /main/DUT_A/sim_wb_cyc
add wave -noupdate -group TopA /main/DUT_A/sim_wb_stb
add wave -noupdate -group TopA /main/DUT_A/sim_wb_we
add wave -noupdate -group TopA /main/DUT_A/sim_wb_ack
add wave -noupdate -group TopA /main/DUT_A/sim_wb_stall
add wave -noupdate -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/g_num_triggers
add wave -noupdate -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/clk_sys_i
add wave -noupdate -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/rst_n_i
add wave -noupdate -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/trig_id_i
add wave -noupdate -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/trig_id_valid_i
add wave -noupdate -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/ram_addr_o
add wave -noupdate -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/ram_data_o
add wave -noupdate -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/ram_data_i
add wave -noupdate -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/ram_we_o
add wave -noupdate -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/regs_i
add wave -noupdate -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/state
add wave -noupdate -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/addr
add wave -noupdate -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/trig_bit
add wave -noupdate -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/clk_sys_i
add wave -noupdate -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/rst_n_i
add wave -noupdate -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/ts_o
add wave -noupdate -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/rx_data_i
add wave -noupdate -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/rx_valid_i
add wave -noupdate -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/rx_dreq_o
add wave -noupdate -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/slave_i
add wave -noupdate -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/slave_o
add wave -noupdate -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/dhb_ram_addr
add wave -noupdate -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/dhb_ram_data_out
add wave -noupdate -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/dhb_ram_data_in
add wave -noupdate -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/dhb_ram_wr
add wave -noupdate -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/regs_in
add wave -noupdate -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/regs_out
add wave -noupdate -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/adjusted_ts
add wave -noupdate -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/decoded_trig
add wave -noupdate -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/decoded_trig_comb
add wave -noupdate -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/trigger_valid
add wave -noupdate -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/rx_count
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/g_with_vlans
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/g_with_dpi_classifier
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/g_with_rtu
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/g_with_rx_buffer
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/g_rx_buffer_size
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/clk_sys_i
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/clk_rx_i
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/rst_n_sys_i
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/rst_n_rx_i
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/pcs_fab_i
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/pcs_fifo_almostfull_o
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/pcs_busy_i
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/src_wb_o
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/src_wb_i
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/fc_pause_p_o
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/fc_pause_delay_o
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/fc_buffer_occupation_o
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/rmon_o
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/regs_i
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/regs_o
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/rtu_rq_o
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/rtu_full_i
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/rtu_rq_valid_o
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/state
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/gap_cntr
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/counter
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/rxdata_saved
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/next_hdr
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/is_pause
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/data_firstword
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/flush_stall
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/stb_int
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/fab_int
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/dreq_int
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/ack_count
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/src_out_int
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/tmp_sel
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/tmp_dat
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/fab_pipe
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/dreq_pipe
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/ematch_done
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/ematch_is_hp
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/ematch_is_pause
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/ematch_pause_quanta
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/pfilter_pclass
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/pfilter_drop
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/pfilter_done
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/vlan_tclass
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/vlan_vid
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/vlan_tag_done
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/pcs_fifo_almostfull
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/mbuf_rd
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/mbuf_valid
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/mbuf_we
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/mbuf_pf_drop
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/mbuf_is_hp
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/mbuf_is_pause
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/mbuf_full
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/mbuf_we_d0
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/mbuf_we_d1
add wave -noupdate -expand -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/mbuf_pf_class
add wave -noupdate -group PMux_B /main/DUT_B/U_Packet_Mux/g_muxed_ports
add wave -noupdate -group PMux_B /main/DUT_B/U_Packet_Mux/clk_sys_i
add wave -noupdate -group PMux_B /main/DUT_B/U_Packet_Mux/rst_n_i
add wave -noupdate -group PMux_B /main/DUT_B/U_Packet_Mux/ep_src_o
add wave -noupdate -group PMux_B /main/DUT_B/U_Packet_Mux/ep_src_i
add wave -noupdate -group PMux_B /main/DUT_B/U_Packet_Mux/ep_snk_o
add wave -noupdate -group PMux_B /main/DUT_B/U_Packet_Mux/ep_snk_i
add wave -noupdate -group PMux_B /main/DUT_B/U_Packet_Mux/mux_src_o
add wave -noupdate -group PMux_B /main/DUT_B/U_Packet_Mux/mux_src_i
add wave -noupdate -group PMux_B /main/DUT_B/U_Packet_Mux/mux_snk_o
add wave -noupdate -group PMux_B /main/DUT_B/U_Packet_Mux/mux_snk_i
add wave -noupdate -group PMux_B /main/DUT_B/U_Packet_Mux/mux_class_i
add wave -noupdate -group PMux_B /main/DUT_B/U_Packet_Mux/mux
add wave -noupdate -group PMux_B /main/DUT_B/U_Packet_Mux/mux_cycs
add wave -noupdate -group PMux_B /main/DUT_B/U_Packet_Mux/mux_rrobin
add wave -noupdate -group PMux_B /main/DUT_B/U_Packet_Mux/mux_select
add wave -noupdate -group PMux_B /main/DUT_B/U_Packet_Mux/demux
add wave -noupdate -group PMux_B /main/DUT_B/U_Packet_Mux/dmux_sel
add wave -noupdate -group PMux_B /main/DUT_B/U_Packet_Mux/dmux_status_reg
add wave -noupdate -group PMux_B /main/DUT_B/U_Packet_Mux/dmux_select
add wave -noupdate -group PMux_B /main/DUT_B/U_Packet_Mux/dmux_sel_zero
add wave -noupdate -group PMux_B /main/DUT_B/U_Packet_Mux/dmux_snd_stat
add wave -noupdate -group PMux_B /main/DUT_B/U_Packet_Mux/ep_stall_mask
add wave -noupdate -group PMux_B /main/DUT_B/U_Packet_Mux/ep_snk_out_stall
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_rst_i
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_loopen_i
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_prbsen_i
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_enable_i
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_syncen_i
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_tx_data_i
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_tx_k_i
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_tx_disparity_o
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_tx_enc_err_o
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_rx_data_o
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_rx_k_o
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_rx_enc_err_o
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_rx_bitslide_o
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/tbi_refclk_i
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/tbi_rbclk_i
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/tbi_td_o
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/tbi_rd_i
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/tbi_syncen_o
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/tbi_loopen_o
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/tbi_prbsen_o
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/tbi_enable_o
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/rx_reg
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/tx_reg
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/txdata_encoded
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/dec_err_enc
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/dec_err_rdisp
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/rst_synced_rbclk
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/rst_synced_rbclk_n
add wave -noupdate -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_rst_n
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_rst_i
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_loopen_i
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_prbsen_i
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_enable_i
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_syncen_i
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_tx_data_i
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_tx_k_i
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_tx_disparity_o
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_tx_enc_err_o
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_rx_data_o
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_rx_k_o
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_rx_enc_err_o
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_rx_bitslide_o
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/tbi_refclk_i
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/tbi_rbclk_i
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/tbi_td_o
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/tbi_rd_i
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/tbi_syncen_o
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/tbi_loopen_o
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/tbi_prbsen_o
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/tbi_enable_o
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/rx_reg
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/tx_reg
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/txdata_encoded
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/dec_err_enc
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/dec_err_rdisp
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/rst_synced_rbclk
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/rst_synced_rbclk_n
add wave -noupdate -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_rst_n
add wave -noupdate -group PMux /main/DUT_A/U_Packet_Mux/g_muxed_ports
add wave -noupdate -group PMux /main/DUT_A/U_Packet_Mux/clk_sys_i
add wave -noupdate -group PMux /main/DUT_A/U_Packet_Mux/rst_n_i
add wave -noupdate -group PMux /main/DUT_A/U_Packet_Mux/ep_src_o
add wave -noupdate -group PMux /main/DUT_A/U_Packet_Mux/ep_src_i
add wave -noupdate -group PMux /main/DUT_A/U_Packet_Mux/ep_snk_o
add wave -noupdate -group PMux /main/DUT_A/U_Packet_Mux/ep_snk_i
add wave -noupdate -group PMux /main/DUT_A/U_Packet_Mux/mux_src_o
add wave -noupdate -group PMux /main/DUT_A/U_Packet_Mux/mux_src_i
add wave -noupdate -group PMux /main/DUT_A/U_Packet_Mux/mux_snk_o
add wave -noupdate -group PMux /main/DUT_A/U_Packet_Mux/mux_snk_i
add wave -noupdate -group PMux /main/DUT_A/U_Packet_Mux/mux_class_i
add wave -noupdate -group PMux /main/DUT_A/U_Packet_Mux/mux
add wave -noupdate -group PMux /main/DUT_A/U_Packet_Mux/mux_cycs
add wave -noupdate -group PMux /main/DUT_A/U_Packet_Mux/mux_rrobin
add wave -noupdate -group PMux /main/DUT_A/U_Packet_Mux/mux_select
add wave -noupdate -group PMux /main/DUT_A/U_Packet_Mux/demux
add wave -noupdate -group PMux /main/DUT_A/U_Packet_Mux/dmux_sel
add wave -noupdate -group PMux /main/DUT_A/U_Packet_Mux/dmux_status_reg
add wave -noupdate -group PMux /main/DUT_A/U_Packet_Mux/dmux_select
add wave -noupdate -group PMux /main/DUT_A/U_Packet_Mux/dmux_sel_zero
add wave -noupdate -group PMux /main/DUT_A/U_Packet_Mux/dmux_snd_stat
add wave -noupdate -group PMux /main/DUT_A/U_Packet_Mux/ep_stall_mask
add wave -noupdate -group PMux /main/DUT_A/U_Packet_Mux/ep_snk_out_stall
add wave -noupdate -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/clk_sys_i
add wave -noupdate -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/rst_n_i
add wave -noupdate -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/ts_i
add wave -noupdate -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/tx_data_o
add wave -noupdate -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/tx_req_o
add wave -noupdate -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/tx_ack_i
add wave -noupdate -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/enable_o
add wave -noupdate -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/slave_i
add wave -noupdate -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/slave_o
add wave -noupdate -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/regs_in
add wave -noupdate -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/regs_out
add wave -noupdate -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/ts_adjusted
add wave -noupdate -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/trig_packet
add wave -noupdate -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/state
add wave -noupdate -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/counter
add wave -noupdate -group DutB /main/DUT_B/g_standalone
add wave -noupdate -group DutB /main/DUT_B/g_simulation
add wave -noupdate -group DutB /main/DUT_B/g_with_gennum
add wave -noupdate -group DutB /main/DUT_B/clk_20m_vcxo_i
add wave -noupdate -group DutB /main/DUT_B/clk_125m_pllref_p_i
add wave -noupdate -group DutB /main/DUT_B/clk_125m_pllref_n_i
add wave -noupdate -group DutB /main/DUT_B/clk_125m_gtp_n_i
add wave -noupdate -group DutB /main/DUT_B/clk_125m_gtp_p_i
add wave -noupdate -group DutB /main/DUT_B/l_rst_n
add wave -noupdate -group DutB /main/DUT_B/gpio
add wave -noupdate -group DutB /main/DUT_B/p2l_rdy
add wave -noupdate -group DutB /main/DUT_B/p2l_clkn
add wave -noupdate -group DutB /main/DUT_B/p2l_clkp
add wave -noupdate -group DutB /main/DUT_B/p2l_data
add wave -noupdate -group DutB /main/DUT_B/p2l_dframe
add wave -noupdate -group DutB /main/DUT_B/p2l_valid
add wave -noupdate -group DutB /main/DUT_B/p_wr_req
add wave -noupdate -group DutB /main/DUT_B/p_wr_rdy
add wave -noupdate -group DutB /main/DUT_B/rx_error
add wave -noupdate -group DutB /main/DUT_B/l2p_data
add wave -noupdate -group DutB /main/DUT_B/l2p_dframe
add wave -noupdate -group DutB /main/DUT_B/l2p_valid
add wave -noupdate -group DutB /main/DUT_B/l2p_clkn
add wave -noupdate -group DutB /main/DUT_B/l2p_clkp
add wave -noupdate -group DutB /main/DUT_B/l2p_edb
add wave -noupdate -group DutB /main/DUT_B/l2p_rdy
add wave -noupdate -group DutB /main/DUT_B/l_wr_rdy
add wave -noupdate -group DutB /main/DUT_B/p_rd_d_rdy
add wave -noupdate -group DutB /main/DUT_B/tx_error
add wave -noupdate -group DutB /main/DUT_B/vc_rdy
add wave -noupdate -group DutB /main/DUT_B/led_red
add wave -noupdate -group DutB /main/DUT_B/led_green
add wave -noupdate -group DutB /main/DUT_B/dac_sclk_o
add wave -noupdate -group DutB /main/DUT_B/dac_din_o
add wave -noupdate -group DutB /main/DUT_B/dac_cs1_n_o
add wave -noupdate -group DutB /main/DUT_B/dac_cs2_n_o
add wave -noupdate -group DutB /main/DUT_B/button1_i
add wave -noupdate -group DutB /main/DUT_B/button2_i
add wave -noupdate -group DutB /main/DUT_B/fmc_scl_b
add wave -noupdate -group DutB /main/DUT_B/fmc_sda_b
add wave -noupdate -group DutB /main/DUT_B/carrier_onewire_b
add wave -noupdate -group DutB /main/DUT_B/fmc_prsnt_m2c_l_i
add wave -noupdate -group DutB /main/DUT_B/sfp_txp_o
add wave -noupdate -group DutB /main/DUT_B/sfp_txn_o
add wave -noupdate -group DutB /main/DUT_B/sfp_rxp_i
add wave -noupdate -group DutB /main/DUT_B/sfp_rxn_i
add wave -noupdate -group DutB /main/DUT_B/sfp_mod_def0_b
add wave -noupdate -group DutB /main/DUT_B/sfp_mod_def1_b
add wave -noupdate -group DutB /main/DUT_B/sfp_mod_def2_b
add wave -noupdate -group DutB /main/DUT_B/sfp_rate_select_b
add wave -noupdate -group DutB /main/DUT_B/sfp_tx_fault_i
add wave -noupdate -group DutB /main/DUT_B/sfp_tx_disable_o
add wave -noupdate -group DutB /main/DUT_B/sfp_los_i
add wave -noupdate -group DutB /main/DUT_B/fd_tdc_start_p_i
add wave -noupdate -group DutB /main/DUT_B/fd_tdc_start_n_i
add wave -noupdate -group DutB /main/DUT_B/fd_clk_ref_p_i
add wave -noupdate -group DutB /main/DUT_B/fd_clk_ref_n_i
add wave -noupdate -group DutB /main/DUT_B/fd_trig_a_i
add wave -noupdate -group DutB /main/DUT_B/fd_tdc_cal_pulse_o
add wave -noupdate -group DutB /main/DUT_B/fd_tdc_d_b
add wave -noupdate -group DutB /main/DUT_B/fd_tdc_emptyf_i
add wave -noupdate -group DutB /main/DUT_B/fd_tdc_alutrigger_o
add wave -noupdate -group DutB /main/DUT_B/fd_tdc_wr_n_o
add wave -noupdate -group DutB /main/DUT_B/fd_tdc_rd_n_o
add wave -noupdate -group DutB /main/DUT_B/fd_tdc_oe_n_o
add wave -noupdate -group DutB /main/DUT_B/fd_led_trig_o
add wave -noupdate -group DutB /main/DUT_B/fd_tdc_start_dis_o
add wave -noupdate -group DutB /main/DUT_B/fd_tdc_stop_dis_o
add wave -noupdate -group DutB /main/DUT_B/fd_spi_cs_dac_n_o
add wave -noupdate -group DutB /main/DUT_B/fd_spi_cs_pll_n_o
add wave -noupdate -group DutB /main/DUT_B/fd_spi_cs_gpio_n_o
add wave -noupdate -group DutB /main/DUT_B/fd_spi_sclk_o
add wave -noupdate -group DutB /main/DUT_B/fd_spi_mosi_o
add wave -noupdate -group DutB /main/DUT_B/fd_spi_miso_i
add wave -noupdate -group DutB /main/DUT_B/fd_delay_len_o
add wave -noupdate -group DutB /main/DUT_B/fd_delay_val_o
add wave -noupdate -group DutB /main/DUT_B/fd_delay_pulse_o
add wave -noupdate -group DutB /main/DUT_B/fd_dmtd_clk_o
add wave -noupdate -group DutB /main/DUT_B/fd_dmtd_fb_in_i
add wave -noupdate -group DutB /main/DUT_B/fd_dmtd_fb_out_i
add wave -noupdate -group DutB /main/DUT_B/fd_pll_status_i
add wave -noupdate -group DutB /main/DUT_B/fd_ext_rst_n_o
add wave -noupdate -group DutB /main/DUT_B/fd_onewire_b
add wave -noupdate -group DutB /main/DUT_B/uart_rxd_i
add wave -noupdate -group DutB /main/DUT_B/uart_txd_o
add wave -noupdate -group DutB /main/DUT_B/tbi_td_o
add wave -noupdate -group DutB /main/DUT_B/tbi_rd_i
add wave -noupdate -group DutB /main/DUT_B/pllout_clk_sys
add wave -noupdate -group DutB /main/DUT_B/pllout_clk_dmtd
add wave -noupdate -group DutB /main/DUT_B/pllout_clk_fb_pllref
add wave -noupdate -group DutB /main/DUT_B/pllout_clk_fb_dmtd
add wave -noupdate -group DutB /main/DUT_B/clk_20m_vcxo_buf
add wave -noupdate -group DutB /main/DUT_B/clk_125m_pllref
add wave -noupdate -group DutB /main/DUT_B/clk_125m_gtp
add wave -noupdate -group DutB /main/DUT_B/clk_sys
add wave -noupdate -group DutB /main/DUT_B/clk_dmtd
add wave -noupdate -group DutB /main/DUT_B/dac_hpll_load_p1
add wave -noupdate -group DutB /main/DUT_B/dac_dpll_load_p1
add wave -noupdate -group DutB /main/DUT_B/dac_hpll_data
add wave -noupdate -group DutB /main/DUT_B/dac_dpll_data
add wave -noupdate -group DutB /main/DUT_B/phy_tx_data
add wave -noupdate -group DutB /main/DUT_B/phy_tx_k
add wave -noupdate -group DutB /main/DUT_B/phy_tx_disparity
add wave -noupdate -group DutB /main/DUT_B/phy_tx_enc_err
add wave -noupdate -group DutB /main/DUT_B/phy_rx_data
add wave -noupdate -group DutB /main/DUT_B/phy_rx_rbclk
add wave -noupdate -group DutB /main/DUT_B/phy_rx_k
add wave -noupdate -group DutB /main/DUT_B/phy_rx_enc_err
add wave -noupdate -group DutB /main/DUT_B/phy_rx_bitslide
add wave -noupdate -group DutB /main/DUT_B/phy_rst
add wave -noupdate -group DutB /main/DUT_B/phy_loopen
add wave -noupdate -group DutB /main/DUT_B/local_reset_n
add wave -noupdate -group DutB /main/DUT_B/cnx_master_out
add wave -noupdate -group DutB /main/DUT_B/cnx_master_in
add wave -noupdate -group DutB /main/DUT_B/cnx_slave_out
add wave -noupdate -group DutB /main/DUT_B/cnx_slave_in
add wave -noupdate -group DutB /main/DUT_B/dcm_clk_ref_0
add wave -noupdate -group DutB /main/DUT_B/dcm_clk_ref_180
add wave -noupdate -group DutB /main/DUT_B/fd_tdc_start
add wave -noupdate -group DutB /main/DUT_B/tdc_data_out
add wave -noupdate -group DutB /main/DUT_B/tdc_data_in
add wave -noupdate -group DutB /main/DUT_B/tdc_data_oe
add wave -noupdate -group DutB /main/DUT_B/tm_link_up
add wave -noupdate -group DutB /main/DUT_B/tm_utc
add wave -noupdate -group DutB /main/DUT_B/tm_cycles
add wave -noupdate -group DutB /main/DUT_B/tm_time_valid
add wave -noupdate -group DutB /main/DUT_B/tm_clk_aux_lock_en
add wave -noupdate -group DutB /main/DUT_B/tm_clk_aux_locked
add wave -noupdate -group DutB /main/DUT_B/tm_dac_value
add wave -noupdate -group DutB /main/DUT_B/tm_dac_wr
add wave -noupdate -group DutB /main/DUT_B/ddr_pll_reset
add wave -noupdate -group DutB /main/DUT_B/ddr_pll_locked
add wave -noupdate -group DutB /main/DUT_B/fd_pll_status
add wave -noupdate -group DutB /main/DUT_B/wrc_scl_out
add wave -noupdate -group DutB /main/DUT_B/wrc_scl_in
add wave -noupdate -group DutB /main/DUT_B/wrc_sda_out
add wave -noupdate -group DutB /main/DUT_B/wrc_sda_in
add wave -noupdate -group DutB /main/DUT_B/fd_scl_out
add wave -noupdate -group DutB /main/DUT_B/fd_scl_in
add wave -noupdate -group DutB /main/DUT_B/fd_sda_out
add wave -noupdate -group DutB /main/DUT_B/fd_sda_in
add wave -noupdate -group DutB /main/DUT_B/sfp_scl_out
add wave -noupdate -group DutB /main/DUT_B/sfp_scl_in
add wave -noupdate -group DutB /main/DUT_B/sfp_sda_out
add wave -noupdate -group DutB /main/DUT_B/sfp_sda_in
add wave -noupdate -group DutB /main/DUT_B/wrc_owr_en
add wave -noupdate -group DutB /main/DUT_B/wrc_owr_in
add wave -noupdate -group DutB /main/DUT_B/fd_owr_en
add wave -noupdate -group DutB /main/DUT_B/fd_owr_in
add wave -noupdate -group DutB /main/DUT_B/fd_irq
add wave -noupdate -group DutB /main/DUT_B/gn_wb_adr
add wave -noupdate -group DutB /main/DUT_B/pps
add wave -noupdate -group DutB /main/DUT_B/etherbone_rst_n
add wave -noupdate -group DutB /main/DUT_B/etherbone_src_out
add wave -noupdate -group DutB /main/DUT_B/etherbone_src_in
add wave -noupdate -group DutB /main/DUT_B/etherbone_snk_out
add wave -noupdate -group DutB /main/DUT_B/etherbone_snk_in
add wave -noupdate -group DutB /main/DUT_B/streamer_src_out
add wave -noupdate -group DutB /main/DUT_B/streamer_src_in
add wave -noupdate -group DutB /main/DUT_B/streamer_snk_out
add wave -noupdate -group DutB /main/DUT_B/streamer_snk_in
add wave -noupdate -group DutB /main/DUT_B/mux_src_out
add wave -noupdate -group DutB /main/DUT_B/mux_src_in
add wave -noupdate -group DutB /main/DUT_B/mux_snk_out
add wave -noupdate -group DutB /main/DUT_B/mux_snk_in
add wave -noupdate -group DutB /main/DUT_B/etherbone_cfg_in
add wave -noupdate -group DutB /main/DUT_B/etherbone_cfg_out
add wave -noupdate -group DutB /main/DUT_B/vic_irqs
add wave -noupdate -group DutB /main/DUT_B/timestamps_in
add wave -noupdate -group DutB /main/DUT_B/timestamps_out
add wave -noupdate -group DutB /main/DUT_B/fd_outx_seconds
add wave -noupdate -group DutB /main/DUT_B/fd_outx_cycles
add wave -noupdate -group DutB /main/DUT_B/fd_outx_frac
add wave -noupdate -group DutB /main/DUT_B/fd_outx_valid
add wave -noupdate -group DutB /main/DUT_B/sim_wb_adr
add wave -noupdate -group DutB /main/DUT_B/sim_wb_dat_in
add wave -noupdate -group DutB /main/DUT_B/sim_wb_dat_out
add wave -noupdate -group DutB /main/DUT_B/sim_wb_cyc
add wave -noupdate -group DutB /main/DUT_B/sim_wb_stb
add wave -noupdate -group DutB /main/DUT_B/sim_wb_we
add wave -noupdate -group DutB /main/DUT_B/sim_wb_ack
add wave -noupdate -group DutB /main/DUT_B/sim_wb_stall
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {252047573 ps} 0}
configure wave -namecolwidth 185
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {195203489 ps} {280253489 ps}
