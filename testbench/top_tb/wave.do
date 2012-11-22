onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/g_num_triggers
add wave -noupdate -expand -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/clk_sys_i
add wave -noupdate -expand -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/rst_n_i
add wave -noupdate -expand -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/trig_id_i
add wave -noupdate -expand -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/trig_id_valid_i
add wave -noupdate -expand -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/ram_addr_o
add wave -noupdate -expand -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/ram_data_o
add wave -noupdate -expand -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/ram_data_i
add wave -noupdate -expand -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/ram_we_o
add wave -noupdate -expand -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/regs_i
add wave -noupdate -expand -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/state
add wave -noupdate -expand -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/addr
add wave -noupdate -expand -group ScanTrig0 /main/DUT_B/U_TrigDist_Core/U_ScanTriggers/trig_bit
add wave -noupdate -expand -group Histo1 /main/DUT_B/U_TrigDist_Core/gen_receivers(1)/U_RXn/U_Histogrammer/g_num_bins
add wave -noupdate -expand -group Histo1 /main/DUT_B/U_TrigDist_Core/gen_receivers(1)/U_RXn/U_Histogrammer/g_input_width
add wave -noupdate -expand -group Histo1 /main/DUT_B/U_TrigDist_Core/gen_receivers(1)/U_RXn/U_Histogrammer/clk_sys_i
add wave -noupdate -expand -group Histo1 /main/DUT_B/U_TrigDist_Core/gen_receivers(1)/U_RXn/U_Histogrammer/rst_n_i
add wave -noupdate -expand -group Histo1 /main/DUT_B/U_TrigDist_Core/gen_receivers(1)/U_RXn/U_Histogrammer/sample_i
add wave -noupdate -expand -group Histo1 /main/DUT_B/U_TrigDist_Core/gen_receivers(1)/U_RXn/U_Histogrammer/sample_valid_i
add wave -noupdate -expand -group Histo1 /main/DUT_B/U_TrigDist_Core/gen_receivers(1)/U_RXn/U_Histogrammer/ram_addr_o
add wave -noupdate -expand -group Histo1 /main/DUT_B/U_TrigDist_Core/gen_receivers(1)/U_RXn/U_Histogrammer/ram_data_o
add wave -noupdate -expand -group Histo1 /main/DUT_B/U_TrigDist_Core/gen_receivers(1)/U_RXn/U_Histogrammer/ram_data_i
add wave -noupdate -expand -group Histo1 /main/DUT_B/U_TrigDist_Core/gen_receivers(1)/U_RXn/U_Histogrammer/ram_wr_o
add wave -noupdate -expand -group Histo1 /main/DUT_B/U_TrigDist_Core/gen_receivers(1)/U_RXn/U_Histogrammer/regs_i
add wave -noupdate -expand -group Histo1 /main/DUT_B/U_TrigDist_Core/gen_receivers(1)/U_RXn/U_Histogrammer/rescaled
add wave -noupdate -expand -group Histo1 /main/DUT_B/U_TrigDist_Core/gen_receivers(1)/U_RXn/U_Histogrammer/addr
add wave -noupdate -expand -group Histo1 /main/DUT_B/U_TrigDist_Core/gen_receivers(1)/U_RXn/U_Histogrammer/bin_cnt
add wave -noupdate -expand -group Histo1 /main/DUT_B/U_TrigDist_Core/gen_receivers(1)/U_RXn/U_Histogrammer/state
add wave -noupdate -expand -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/clk_sys_i
add wave -noupdate -expand -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/rst_n_i
add wave -noupdate -expand -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/ts_o
add wave -noupdate -expand -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/rx_data_i
add wave -noupdate -expand -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/rx_valid_i
add wave -noupdate -expand -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/rx_dreq_o
add wave -noupdate -expand -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/slave_i
add wave -noupdate -expand -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/slave_o
add wave -noupdate -expand -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/dhb_ram_addr
add wave -noupdate -expand -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/dhb_ram_data_out
add wave -noupdate -expand -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/dhb_ram_data_in
add wave -noupdate -expand -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/dhb_ram_wr
add wave -noupdate -expand -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/regs_in
add wave -noupdate -expand -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/regs_out
add wave -noupdate -expand -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/adjusted_ts
add wave -noupdate -expand -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/decoded_trig
add wave -noupdate -expand -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/decoded_trig_comb
add wave -noupdate -expand -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/trigger_valid
add wave -noupdate -expand -group Rx0 /main/DUT_B/U_TrigDist_Core/gen_receivers(0)/U_RXn/rx_count
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/g_with_vlans
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/g_with_dpi_classifier
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/g_with_rtu
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/g_with_rx_buffer
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/g_rx_buffer_size
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/clk_sys_i
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/clk_rx_i
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/rst_n_sys_i
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/rst_n_rx_i
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/pcs_fab_i
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/pcs_fifo_almostfull_o
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/pcs_busy_i
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/src_wb_o
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/src_wb_i
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/fc_pause_p_o
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/fc_pause_delay_o
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/fc_buffer_occupation_o
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/rmon_o
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/regs_i
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/regs_o
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/rtu_rq_o
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/rtu_full_i
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/rtu_rq_valid_o
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/state
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/gap_cntr
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/counter
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/rxdata_saved
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/next_hdr
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/is_pause
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/data_firstword
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/flush_stall
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/stb_int
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/fab_int
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/dreq_int
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/ack_count
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/src_out_int
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/tmp_sel
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/tmp_dat
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/fab_pipe
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/dreq_pipe
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/ematch_done
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/ematch_is_hp
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/ematch_is_pause
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/ematch_pause_quanta
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/pfilter_pclass
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/pfilter_drop
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/pfilter_done
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/vlan_tclass
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/vlan_vid
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/vlan_tag_done
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/pcs_fifo_almostfull
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/mbuf_rd
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/mbuf_valid
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/mbuf_we
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/mbuf_pf_drop
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/mbuf_is_hp
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/mbuf_is_pause
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/mbuf_full
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/mbuf_we_d0
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/mbuf_we_d1
add wave -noupdate -group RXPathB /main/DUT_B/U_WR_CORE/WRPC/U_Endpoint/U_Wrapped_Endpoint/U_Rx_Path/mbuf_pf_class
add wave -noupdate -expand -group PMux_B /main/DUT_B/U_Packet_Mux/g_muxed_ports
add wave -noupdate -expand -group PMux_B /main/DUT_B/U_Packet_Mux/clk_sys_i
add wave -noupdate -expand -group PMux_B /main/DUT_B/U_Packet_Mux/rst_n_i
add wave -noupdate -expand -group PMux_B /main/DUT_B/U_Packet_Mux/ep_src_o
add wave -noupdate -expand -group PMux_B /main/DUT_B/U_Packet_Mux/ep_src_i
add wave -noupdate -expand -group PMux_B /main/DUT_B/U_Packet_Mux/ep_snk_o
add wave -noupdate -expand -group PMux_B /main/DUT_B/U_Packet_Mux/ep_snk_i
add wave -noupdate -expand -group PMux_B /main/DUT_B/U_Packet_Mux/mux_src_o
add wave -noupdate -expand -group PMux_B /main/DUT_B/U_Packet_Mux/mux_src_i
add wave -noupdate -expand -group PMux_B /main/DUT_B/U_Packet_Mux/mux_snk_o
add wave -noupdate -expand -group PMux_B /main/DUT_B/U_Packet_Mux/mux_snk_i
add wave -noupdate -expand -group PMux_B /main/DUT_B/U_Packet_Mux/mux_class_i
add wave -noupdate -expand -group PMux_B /main/DUT_B/U_Packet_Mux/mux
add wave -noupdate -expand -group PMux_B /main/DUT_B/U_Packet_Mux/mux_cycs
add wave -noupdate -expand -group PMux_B /main/DUT_B/U_Packet_Mux/mux_rrobin
add wave -noupdate -expand -group PMux_B /main/DUT_B/U_Packet_Mux/mux_select
add wave -noupdate -expand -group PMux_B /main/DUT_B/U_Packet_Mux/demux
add wave -noupdate -expand -group PMux_B /main/DUT_B/U_Packet_Mux/dmux_sel
add wave -noupdate -expand -group PMux_B /main/DUT_B/U_Packet_Mux/dmux_status_reg
add wave -noupdate -expand -group PMux_B /main/DUT_B/U_Packet_Mux/dmux_select
add wave -noupdate -expand -group PMux_B /main/DUT_B/U_Packet_Mux/dmux_sel_zero
add wave -noupdate -expand -group PMux_B /main/DUT_B/U_Packet_Mux/dmux_snd_stat
add wave -noupdate -expand -group PMux_B /main/DUT_B/U_Packet_Mux/ep_stall_mask
add wave -noupdate -expand -group PMux_B /main/DUT_B/U_Packet_Mux/ep_snk_out_stall
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_rst_i
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_loopen_i
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_prbsen_i
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_enable_i
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_syncen_i
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_tx_data_i
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_tx_k_i
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_tx_disparity_o
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_tx_enc_err_o
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_rx_data_o
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_rx_k_o
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_rx_enc_err_o
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_rx_bitslide_o
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/tbi_refclk_i
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/tbi_rbclk_i
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/tbi_td_o
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/tbi_rd_i
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/tbi_syncen_o
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/tbi_loopen_o
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/tbi_prbsen_o
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/tbi_enable_o
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/rx_reg
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/tx_reg
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/txdata_encoded
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/dec_err_enc
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/dec_err_rdisp
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/rst_synced_rbclk
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/rst_synced_rbclk_n
add wave -noupdate -expand -group PHY_B /main/DUT_B/gen_tbi_phy/U_TBI_PHY/serdes_rst_n
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_rst_i
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_loopen_i
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_prbsen_i
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_enable_i
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_syncen_i
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_tx_data_i
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_tx_k_i
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_tx_disparity_o
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_tx_enc_err_o
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_rx_data_o
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_rx_k_o
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_rx_enc_err_o
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_rx_bitslide_o
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/tbi_refclk_i
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/tbi_rbclk_i
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/tbi_td_o
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/tbi_rd_i
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/tbi_syncen_o
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/tbi_loopen_o
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/tbi_prbsen_o
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/tbi_enable_o
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/rx_reg
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/tx_reg
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/txdata_encoded
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/dec_err_enc
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/dec_err_rdisp
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/rst_synced_rbclk
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/rst_synced_rbclk_n
add wave -noupdate -expand -group PHY_A /main/DUT_A/gen_tbi_phy/U_TBI_PHY/serdes_rst_n
add wave -noupdate -expand -group PMux /main/DUT_A/U_Packet_Mux/g_muxed_ports
add wave -noupdate -expand -group PMux /main/DUT_A/U_Packet_Mux/clk_sys_i
add wave -noupdate -expand -group PMux /main/DUT_A/U_Packet_Mux/rst_n_i
add wave -noupdate -expand -group PMux /main/DUT_A/U_Packet_Mux/ep_src_o
add wave -noupdate -expand -group PMux /main/DUT_A/U_Packet_Mux/ep_src_i
add wave -noupdate -expand -group PMux /main/DUT_A/U_Packet_Mux/ep_snk_o
add wave -noupdate -expand -group PMux /main/DUT_A/U_Packet_Mux/ep_snk_i
add wave -noupdate -expand -group PMux /main/DUT_A/U_Packet_Mux/mux_src_o
add wave -noupdate -expand -group PMux /main/DUT_A/U_Packet_Mux/mux_src_i
add wave -noupdate -expand -group PMux /main/DUT_A/U_Packet_Mux/mux_snk_o
add wave -noupdate -expand -group PMux /main/DUT_A/U_Packet_Mux/mux_snk_i
add wave -noupdate -expand -group PMux /main/DUT_A/U_Packet_Mux/mux_class_i
add wave -noupdate -expand -group PMux /main/DUT_A/U_Packet_Mux/mux
add wave -noupdate -expand -group PMux /main/DUT_A/U_Packet_Mux/mux_cycs
add wave -noupdate -expand -group PMux /main/DUT_A/U_Packet_Mux/mux_rrobin
add wave -noupdate -expand -group PMux /main/DUT_A/U_Packet_Mux/mux_select
add wave -noupdate -expand -group PMux /main/DUT_A/U_Packet_Mux/demux
add wave -noupdate -expand -group PMux /main/DUT_A/U_Packet_Mux/dmux_sel
add wave -noupdate -expand -group PMux /main/DUT_A/U_Packet_Mux/dmux_status_reg
add wave -noupdate -expand -group PMux /main/DUT_A/U_Packet_Mux/dmux_select
add wave -noupdate -expand -group PMux /main/DUT_A/U_Packet_Mux/dmux_sel_zero
add wave -noupdate -expand -group PMux /main/DUT_A/U_Packet_Mux/dmux_snd_stat
add wave -noupdate -expand -group PMux /main/DUT_A/U_Packet_Mux/ep_stall_mask
add wave -noupdate -expand -group PMux /main/DUT_A/U_Packet_Mux/ep_snk_out_stall
add wave -noupdate -expand -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/clk_sys_i
add wave -noupdate -expand -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/rst_n_i
add wave -noupdate -expand -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/ts_i
add wave -noupdate -expand -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/tx_data_o
add wave -noupdate -expand -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/tx_req_o
add wave -noupdate -expand -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/tx_ack_i
add wave -noupdate -expand -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/enable_o
add wave -noupdate -expand -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/slave_i
add wave -noupdate -expand -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/slave_o
add wave -noupdate -expand -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/regs_in
add wave -noupdate -expand -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/regs_out
add wave -noupdate -expand -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/ts_adjusted
add wave -noupdate -expand -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/trig_packet
add wave -noupdate -expand -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/state
add wave -noupdate -expand -group Xmit-0 /main/DUT_A/U_TrigDist_Core/gen_transmitters(0)/U_TXn/counter
add wave -noupdate /main/DUT_A/U_TrigDist_Core/g_num_inputs
add wave -noupdate /main/DUT_A/U_TrigDist_Core/g_num_outputs
add wave -noupdate /main/DUT_A/U_TrigDist_Core/g_core_type
add wave -noupdate /main/DUT_A/U_TrigDist_Core/clk_sys_i
add wave -noupdate /main/DUT_A/U_TrigDist_Core/rst_n_i
add wave -noupdate -expand -subitemconfig {/main/DUT_A/U_TrigDist_Core/timestamps_i(0) -expand} /main/DUT_A/U_TrigDist_Core/timestamps_i
add wave -noupdate /main/DUT_A/U_TrigDist_Core/timestamps_o
add wave -noupdate /main/DUT_A/U_TrigDist_Core/input_sel_o
add wave -noupdate /main/DUT_A/U_TrigDist_Core/snk_i
add wave -noupdate /main/DUT_A/U_TrigDist_Core/snk_o
add wave -noupdate /main/DUT_A/U_TrigDist_Core/src_i
add wave -noupdate -expand /main/DUT_A/U_TrigDist_Core/src_o
add wave -noupdate /main/DUT_A/U_TrigDist_Core/slave_i
add wave -noupdate /main/DUT_A/U_TrigDist_Core/slave_o
add wave -noupdate /main/DUT_A/U_TrigDist_Core/cnx_master_out
add wave -noupdate /main/DUT_A/U_TrigDist_Core/cnx_master_in
add wave -noupdate /main/DUT_A/U_TrigDist_Core/requests_packed
add wave -noupdate /main/DUT_A/U_TrigDist_Core/requests_valid
add wave -noupdate -expand /main/DUT_A/U_TrigDist_Core/requests_ack
add wave -noupdate /main/DUT_A/U_TrigDist_Core/rq_muxed
add wave -noupdate /main/DUT_A/U_TrigDist_Core/rx_data
add wave -noupdate /main/DUT_A/U_TrigDist_Core/rq_muxed_valid
add wave -noupdate /main/DUT_A/U_TrigDist_Core/rx_valid
add wave -noupdate /main/DUT_A/U_TrigDist_Core/decoded_trig
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {111069364 ps} 0}
configure wave -namecolwidth 427
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
WaveRestoreZoom {0 ps} {304075145 ps}
