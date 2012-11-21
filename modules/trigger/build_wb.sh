#!/bin/bash

mkdir -p doc
wbgen2 -D ./doc/ttx.html -V trigger_tx_wb.vhd -C ../../software/include/hw/trigger_tx_regs.h --cstyle defines --lang vhdl -K ../../sim/regs/trigger_tx_regs.vh -p ttx_wbgen2_pkg.vhd -H record trigger_tx_wb.wb
wbgen2 -D ./doc/trx.html -V trigger_rx_wb.vhd -C ../../software/include/hw/trigger_rx_regs.h --cstyle defines --lang vhdl -K ../../sim/regs/trigger_rx_regs.vh -p trx_wbgen2_pkg.vhd -H record trigger_rx_wb.wb
