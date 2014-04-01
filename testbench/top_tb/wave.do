onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /main/DUT_A/p2l_rdy
add wave -noupdate /main/DUT_A/p2l_clkn
add wave -noupdate /main/DUT_A/p2l_clkp
add wave -noupdate /main/DUT_A/p2l_data
add wave -noupdate /main/DUT_A/p2l_dframe
add wave -noupdate /main/DUT_A/p2l_valid
add wave -noupdate /main/DUT_A/p_wr_req
add wave -noupdate /main/DUT_A/p_wr_rdy
add wave -noupdate /main/DUT_A/rx_error
add wave -noupdate /main/DUT_A/l2p_data
add wave -noupdate /main/DUT_A/l2p_dframe
add wave -noupdate /main/DUT_A/l2p_valid
add wave -noupdate /main/DUT_A/l2p_clkn
add wave -noupdate /main/DUT_A/l2p_clkp
add wave -noupdate /main/DUT_A/l2p_edb
add wave -noupdate /main/DUT_A/l2p_rdy
add wave -noupdate /main/DUT_A/l_wr_rdy
add wave -noupdate /main/DUT_A/p_rd_d_rdy
add wave -noupdate /main/DUT_A/tx_error
add wave -noupdate /main/DUT_A/vc_rdy
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20357143 ps} 0}
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
WaveRestoreZoom {0 ps} {210 us}
