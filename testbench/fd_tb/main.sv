`timescale 1ns/1ps

`include "gn4124_bfm.svh"
`include "if_wb_master.svh"

`include "fdelay_board.svh"
`include "simdrv_fine_delay.svh"

`include "regs/trigger_tx_regs.vh"
`include "regs/trigger_rx_regs.vh"
`include "regs/trigger_shared_regs.vh"

const uint64_t BASE_TRIG_DIST = 'h0080000;

module main;
   reg clk_125m_pllref = 0;
   reg clk_20m_vcxo = 0;
   reg clk_sys = 0;
   reg rst_n = 0;
   
   always #4ns clk_125m_pllref <= ~clk_125m_pllref;
   always #8ns clk_sys <= ~clk_sys;
   always #20ns clk_20m_vcxo <= ~clk_20m_vcxo;

   initial #200ns rst_n = 1;
   

   reg [4:0] dio_in_a = 0;
   reg [4:0] dio_in_b= 0;
   wire [4:0] dio_out_a;
   wire [4:0] dio_out_b;   
   wire [9:0] a2b, b2a;
      

   assign DUT_A.sim_wb_cyc = I_WBA.cyc;
   assign DUT_A.sim_wb_stb = I_WBA.stb;
   assign DUT_A.sim_wb_we = I_WBA.we;
   assign DUT_A.sim_wb_adr = I_WBA.adr;
   assign DUT_A.sim_wb_dat_in = I_WBA.dat_o;

   assign I_WBA.ack = DUT_A.sim_wb_ack;
   assign I_WBA.stall = DUT_A.sim_wb_stall;
   assign I_WBA.dat_i = DUT_A.sim_wb_dat_out;

   assign DUT_B.sim_wb_cyc = I_WBB.cyc;
   assign DUT_B.sim_wb_stb = I_WBB.stb;
   assign DUT_B.sim_wb_we = I_WBB.we;
   assign DUT_B.sim_wb_adr = I_WBB.adr;
   assign DUT_B.sim_wb_dat_in = I_WBB.dat_o;

   assign I_WBB.ack = DUT_B.sim_wb_ack;
   assign I_WBB.stall = DUT_B.sim_wb_stall;
   assign I_WBB.dat_i = DUT_B.sim_wb_dat_out;
   
   IFineDelayFMC I_fmc0(), I_fmc1();

   reg        trig_a, trig_b = 0;
   wire [3:0] out_a, out_b;
   
   
   fdelay_board U_BoardA
     (
      .trig_i(trig_a),
      .out_o(out_a),
      .fmc(I_fmc0.board)
      );

   fdelay_board U_BoardB
     (
      .trig_i(trig_b),
      .out_o(out_b),
      .fmc(I_fmc1.board)
      );

   spec_top
     #(
       .g_simulation(1)
      )
     DUT_A (
          .clk_125m_pllref_p_i(clk_125m_pllref),
          .clk_125m_pllref_n_i(~clk_125m_pllref),          

          .clk_125m_gtp_p_i(clk_125m_pllref),
          .clk_125m_gtp_n_i(~clk_125m_pllref),
          
          .clk_20m_vcxo_i(clk_20m_vcxo),
          .l_rst_n(1'b1),

//          `GENNUM_WIRE_SPEC_PINS(I_GennumA),
          `WIRE_FINE_DELAY_PINS_SINGLE(I_fmc0),


       
          .tbi_td_o(a2b),
          .tbi_rd_i(b2a)
	  );

      spec_top
     #(
       .g_simulation(1)
      )
     DUT_B (
          .clk_125m_pllref_p_i(clk_125m_pllref),
          .clk_125m_pllref_n_i(~clk_125m_pllref),          

          .clk_125m_gtp_p_i(clk_125m_pllref),
          .clk_125m_gtp_n_i(~clk_125m_pllref),
          
          .clk_20m_vcxo_i(clk_20m_vcxo),
          .l_rst_n(1'b1),
  //        `GENNUM_WIRE_SPEC_PINS(I_GennumB),
          `WIRE_FINE_DELAY_PINS_SINGLE(I_fmc1),

          .tbi_rd_i(a2b),
          .tbi_td_o(b2a)

	  );

   IWishboneMaster #(32, 32) I_WBA (DUT_A.clk_sys, rst_n);
   IWishboneMaster #(32, 32) I_WBB (DUT_B.clk_sys, rst_n);
   
   task init_ttx(CBusAccessor acc, int base, int id, int enable, int adjust_c = 0, int adjust_f = 0);
      
      acc.write(base + `ADDR_TTX_ADJ_C, adjust_c);
      acc.write(base + `ADDR_TTX_ADJ_F, adjust_f);
      
      acc.write(base + `ADDR_TTX_CR, 
                (enable ? `TTX_CR_ENABLE  : 0) | `TTX_CR_RST_CNT
                | (id << `TTX_CR_ID_OFFSET));
      
   endtask // init_ttx

   task init_trx(CBusAccessor acc, int base, int id, int enable, int delay_c = 0, int delay_f = 0);
      
      acc.write(base + `ADDR_TRX_DELAY_C, delay_c);
      acc.write(base + `ADDR_TRX_DELAY_F, delay_f);
      acc.write(base + `ADDR_TRX_RX_HIST_BIAS, 0);
      acc.write(base + `ADDR_TRX_RX_HIST_SCALE, 1 << 14);
      
      $display("TrigID: %x", id);
      
      acc.write(base + `ADDR_TRX_CR, 
                (enable ? `TRX_CR_ENABLE  : 0) | `TRX_CR_RST_CNT | `TRX_CR_RST_HIST 
                | (id << `TRX_CR_ID_OFFSET));

      
   endtask // init_trx
   

   time ts_in_a[$], ts_in_b[$];
   
   
   initial begin
      CWishboneAccessor acc_a, acc_b;
      CSimDrv_FineDelay drv_a, drv_b;
      Timestamp dly;

      trig_a = 0;

      #1us;

      trig_a = 1;

      #1us;

      trig_a = 0;
      
      I_WBA.settings.cyc_on_stall = 1;
      I_WBB.settings.cyc_on_stall = 1;
      I_WBA.settings.addr_gran = BYTE;
      I_WBB.settings.addr_gran = BYTE;
      
      acc_a = I_WBA.get_accessor();
      acc_b = I_WBB.get_accessor();
      acc_a.set_mode(PIPELINED);
      acc_b.set_mode(PIPELINED);

      #6us;

//      acc_a.write('h1234, 'hdeadbeef);
      
      
      drv_a = new(acc_a, 'h90000);
      drv_a.init();
      drv_b = new(acc_b, 'h90000);
      drv_b.init();
      
      dly=new;
      dly.from_ps(500000);
      drv_b.config_output(0, CSimDrv_FineDelay::DELAY, 1, dly, 200000);
      
      init_ttx(acc_a, BASE_TRIG_DIST + 'h1000, 11, 1);
      init_trx(acc_b, BASE_TRIG_DIST + 'h2000, 11, 1, 2000, 0);

      #100us;
      
      forever begin
         trig_a = 1;
         #1us;
         trig_a = 0;
         #6us;
      end
      
           
      
   end
   
   
endmodule // main
