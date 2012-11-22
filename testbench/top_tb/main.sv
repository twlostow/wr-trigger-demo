`timescale 1ns/1ps

`include "gn4124_bfm.svh"
`include "if_wb_master.svh"

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
   
   
   IGN4124PCIMaster I_GennumA ();
   IGN4124PCIMaster I_GennumB ();

   reg [4:0] dio_in_a = 0;
   reg [4:0] dio_in_b= 0;
   wire [4:0] dio_out_a;
   wire [4:0] dio_out_b;   
   wire [9:0] a2b, b2a;

   
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

          `GENNUM_WIRE_SPEC_PINS(I_GennumA),

          .dio_n_i(~dio_in_a),
          .dio_p_i(dio_in_a),

          .dio_p_o(dio_out_a),

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

          `GENNUM_WIRE_SPEC_PINS(I_GennumB),

          .dio_n_i(~dio_in_b),
          .dio_p_i(dio_in_b),

          .dio_p_o(dio_out_b),

          .tbi_rd_i(a2b),
          .tbi_td_o(b2a)

	  );

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
      CBusAccessor acc_a, acc_b;
      
      acc_a = I_GennumA.get_accessor();
      acc_b = I_GennumB.get_accessor();
      
      @(posedge I_GennumA.ready);

      if(!I_GennumB.ready)
        @(posedge I_GennumB.ready);
      

      #100us;
      init_ttx(acc_a, BASE_TRIG_DIST + 'h2000, 11, 1);
      init_ttx(acc_a, BASE_TRIG_DIST + 'h3000, 43, 1);
      init_trx(acc_b, BASE_TRIG_DIST + 'h7000, 11, 1, 2000, 0);
      init_trx(acc_b, BASE_TRIG_DIST + 'h8000, 43, 1, 1000, 0);
      #70us;

      fork
         
         forever begin
            #1us;
            ts_in_a.push_back($time);
            dio_in_a[1] = 1;
            #100ns;
            dio_in_a[1] = 0;
            #11us;
         end
         
         forever begin
            #2us;
            ts_in_b.push_back($time);
            dio_in_a[2] = 1;
            #100ns;
            dio_in_a[2] = 0;
            #11us;
         end

      join
   end

   always@(posedge dio_out_b[1])
     begin
        time t;
        t = ts_in_a.pop_front();
        
        $display("DelayA : %d", $time - t);
        
     end
   always@(posedge dio_out_b[1])
     begin
        time t;
        t = ts_in_b.pop_front();
        
        $display("DelayB : %d", $time - t);
        
     end
   
   
   
endmodule // main
