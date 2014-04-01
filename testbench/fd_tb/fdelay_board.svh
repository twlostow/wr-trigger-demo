`timescale 10fs/10fs

`include "acam_model.svh"
`include "tunable_clock_gen.svh"
`include "random_pulse_gen.svh"
`include "jittery_delay.svh"
`include "mc100ep195.vh"

`include "wb/simdrv_defs.svh"
`include "wb/if_wb_master.svh"

`timescale 10fs/10fs

module trivial_spi_gpio(input sclk, cs_n, mosi, output reg [7:0] gpio);

   int bit_count = 0;
   reg [7:0] sreg;
   
   always@(negedge cs_n)
     bit_count <= 0;

   always@(posedge sclk)
     begin
        bit_count <= bit_count + 1;
        sreg <= { sreg[6:0], mosi };
     end

   always@(posedge cs_n)
     if(bit_count == 24)
       gpio <= sreg[7:0];

   initial gpio = 0;
   
endmodule // trivial_spi


/* Board-level wrapper */

interface IFineDelayFMC;

   wire tdc_start_p;
   wire tdc_start_n;
   wire clk_ref_p;
   wire clk_ref_n;
   wire trig_a;
   wire tdc_cal_pulse;
   wire [27:0] tdc_d;
   wire        tdc_emptyf;
   wire        tdc_alutrigger;
   wire        tdc_wr_n;
   wire        tdc_rd_n;
   wire        tdc_oe_n;
   wire        led_trig;
   wire        tdc_start_dis;
   wire        tdc_stop_dis;
   wire        spi_cs_dac_n;
   wire        spi_cs_pll_n;
   wire        spi_cs_gpio_n;
   wire        spi_sclk;
   wire        spi_mosi;
   wire        spi_miso;
   wire [3:0]  delay_len;
   wire [9:0]  delay_val;
   wire [3:0]  delay_pulse;

   wire dmtd_clk;
   wire dmtd_fb_in;
   wire dmtd_fb_out;
   
   wire pll_status;
   wire ext_rst_n;
   wire onewire;

   modport board
     (
      output tdc_start_p, tdc_start_n, clk_ref_p, clk_ref_n, trig_a, spi_miso, 
      tdc_emptyf, dmtd_fb_in, dmtd_fb_out, pll_status,
      input  tdc_cal_pulse, tdc_wr_n, tdc_rd_n, tdc_oe_n, tdc_alutrigger, led_trig, tdc_start_dis, 
      tdc_stop_dis, spi_cs_dac_n, spi_cs_pll_n, spi_cs_gpio_n, spi_sclk, spi_mosi, 
      delay_len, delay_val, delay_pulse, dmtd_clk, ext_rst_n,
      inout  onewire, tdc_d);

   modport core
     (
      input tdc_start_p, tdc_start_n, clk_ref_p, clk_ref_n, trig_a, spi_miso, 
      tdc_emptyf, dmtd_fb_in, dmtd_fb_out, pll_status,
      output  tdc_cal_pulse, tdc_wr_n, tdc_rd_n, tdc_oe_n, tdc_alutrigger, led_trig, tdc_start_dis, 
      tdc_stop_dis, spi_cs_dac_n, spi_cs_pll_n, spi_cs_gpio_n, spi_sclk, spi_mosi, 
      delay_len, delay_val, delay_pulse, dmtd_clk, ext_rst_n,
      inout  onewire, tdc_d);
   
endinterface // IFineDelayFMC


module fdelay_board (
                     input        trig_i,
                     output [3:0] out_o,
                     IFineDelayFMC.board fmc
);

   reg                            clk_ref_250 = 0;
   reg                            clk_ref_125 = 0;
   reg                            clk_tdc = 0;
   reg [3:0]                      tdc_start_div = 0;
   reg                            tdc_start;
   
   

   always #(4ns / 2) clk_ref_250 <= ~clk_ref_250;
   always@(posedge clk_ref_250) clk_ref_125 <= ~clk_ref_125;

   always #(32ns / 2) clk_tdc <= ~clk_tdc;
   
   assign fmc.clk_ref_p = clk_ref_125;
   assign fmc.clk_ref_n = ~clk_ref_125;
   
   always@(posedge clk_ref_125) begin
      tdc_start_div <= tdc_start_div + 1;
      tdc_start    <= tdc_start_div[3];
   end

   assign fmc.tdc_start_p = tdc_start;
   assign fmc.tdc_start_n = ~tdc_start;
   
   wire trig_a_muxed;
   wire [7:0] spi_gpio_out;

   wire       trig_cal_sel = 1'b1;
   
   
   assign trig_a_muxed = (trig_cal_sel ? trig_i : fmc.tdc_cal_pulse);

   trivial_spi_gpio
     SPI_GPIO (
               .sclk(fmc.spi_sclk),
               .cs_n(fmc.spi_cs_gpio_n),
               .mosi(fmc.spi_mosi),
               .gpio(spi_gpio_out));

   acam_model
     #(
       .g_verbose(0)
       ) ACAM (
      .PuResN(fmc.ext_rst_n),
      .Alutrigger(fmc.tdc_alutrigger),
      .RefClk (clk_tdc),

      .WRN(fmc.tdc_wr_n),
      .RDN(fmc.tdc_rd_n),
      .CSN(1'b0),
      .OEN(fmc.tdc_oe_n),

      .Adr(spi_gpio_out[3:0]),
      .D(fmc.tdc_d),
	       
      .DStart(tdc_start_delayed),
      .DStop1(trig_a_muxed),
      .DStop2(1'b0),
	       
      .TStart(1'b0),
      .TStop(1'b0),

      .StartDis(fmc.tdc_start_dis),
      .StopDis(fmc.tdc_stop_dis),

      .IrFlag(),
      .ErrFlag(),

      .EF1 (fmc.tdc_emptyf),
      .LF1 ()

   );
   
   jittery_delay 
     #(
       .g_delay(3ns),
       .g_jitter(10ps)
       ) 
   DLY_TRIG 
     (
      .in_i(trig_a_muxed),
      .out_o(fmc.trig_a) //trig_a_n_delayed)
      );


//   assign fmc.trig_a = trig_a_n_delayed;
   
   
   jittery_delay 
     #(
       .g_delay(2.2ns),
       .g_jitter(10ps)
       ) 
   DLY_TDC_START
     (
      .in_i(tdc_start),
      .out_o(tdc_start_delayed)
      );

   genvar     gg;
   
   generate
      for(gg=0;gg<4;gg++)
        begin
//           assign out_o[gg] = fmc.delay_pulse[gg];
           
           mc100ep195
             U_delay_line(
                 .len(fmc.delay_len[gg]),
                 .i(fmc.delay_pulse[gg]),
                 .delay(fmc.delay_val),
                 .o(out_o[gg])
                 ); 
               end
      endgenerate
   
endmodule // main

`define WIRE_FINE_DELAY_PINS(fmc_index,iface) \
.fd``fmc_index``_tdc_start_p_i (iface.core.tdc_start_p),    \
.fd``fmc_index``_tdc_start_n_i (iface.core.tdc_start_n),    \
.fd``fmc_index``_clk_ref_p_i   (iface.core.clk_ref_p),    \
.fd``fmc_index``_clk_ref_n_i   (iface.core.clk_ref_n),    \
.fd``fmc_index``_trig_a_i    (iface.core.trig_a),    \
.fd``fmc_index``_tdc_cal_pulse_o (iface.core.tdc_cal_pulse),    \
.fd``fmc_index``_tdc_d_b        (iface.core.tdc_d),    \
.fd``fmc_index``_tdc_emptyf_i   (iface.core.tdc_emptyf),    \
.fd``fmc_index``_tdc_alutrigger_o (iface.core.tdc_alutrigger),    \
.fd``fmc_index``_tdc_wr_n_o      (iface.core.tdc_wr_n),    \
.fd``fmc_index``_tdc_rd_n_o      (iface.core.tdc_rd_n),    \
.fd``fmc_index``_tdc_oe_n_o      (iface.core.tdc_oe_n),    \
.fd``fmc_index``_led_trig_o      (iface.core.led_trig),    \
.fd``fmc_index``_tdc_start_dis_o (iface.core.tdc_start_dis),    \
.fd``fmc_index``_tdc_stop_dis_o  (iface.core.tdc_stop_dis),    \
.fd``fmc_index``_spi_cs_dac_n_o  (iface.core.spi_cs_dac_n),    \
.fd``fmc_index``_spi_cs_pll_n_o  (iface.core.spi_cs_pll_n),    \
.fd``fmc_index``_spi_cs_gpio_n_o  (iface.core.spi_cs_gpio_n),    \
.fd``fmc_index``_spi_sclk_o       (iface.core.spi_sclk),    \
.fd``fmc_index``_spi_mosi_o       (iface.core.spi_mosi),    \
.fd``fmc_index``_spi_miso_i       (iface.core.spi_miso),    \
.fd``fmc_index``_delay_len_o     (iface.core.delay_len),    \
.fd``fmc_index``_delay_val_o      (iface.core.delay_val),    \
.fd``fmc_index``_delay_pulse_o    (iface.core.delay_pulse),    \
.fd``fmc_index``_dmtd_clk_o    (iface.core.dmtd_clk),    \
.fd``fmc_index``_dmtd_fb_in_i  (iface.core.dmtd_fb_in),    \
.fd``fmc_index``_dmtd_fb_out_i (iface.core.dmtd_fb_out),    \
.fd``fmc_index``_pll_status_i (iface.core.pll_status),    \
.fd``fmc_index``_ext_rst_n_o  (iface.core.ext_rst_n),    \
.fd``fmc_index``_onewire_b (iface.core.onewire)

  `define WIRE_FINE_DELAY_PINS_SINGLE(iface) \
.fd_tdc_start_p_i (iface.core.tdc_start_p),    \
.fd_tdc_start_n_i (iface.core.tdc_start_n),    \
.fd_clk_ref_p_i   (iface.core.clk_ref_p),    \
.fd_clk_ref_n_i   (iface.core.clk_ref_n),    \
.fd_trig_a_i    (iface.core.trig_a),    \
.fd_tdc_cal_pulse_o (iface.core.tdc_cal_pulse),    \
.fd_tdc_d_b        (iface.core.tdc_d),    \
.fd_tdc_emptyf_i   (iface.core.tdc_emptyf),    \
.fd_tdc_alutrigger_o (iface.core.tdc_alutrigger),    \
.fd_tdc_wr_n_o      (iface.core.tdc_wr_n),    \
.fd_tdc_rd_n_o      (iface.core.tdc_rd_n),    \
.fd_tdc_oe_n_o      (iface.core.tdc_oe_n),    \
.fd_led_trig_o      (iface.core.led_trig),    \
.fd_tdc_start_dis_o (iface.core.tdc_start_dis),    \
.fd_tdc_stop_dis_o  (iface.core.tdc_stop_dis),    \
.fd_spi_cs_dac_n_o  (iface.core.spi_cs_dac_n),    \
.fd_spi_cs_pll_n_o  (iface.core.spi_cs_pll_n),    \
.fd_spi_cs_gpio_n_o  (iface.core.spi_cs_gpio_n),    \
.fd_spi_sclk_o       (iface.core.spi_sclk),    \
.fd_spi_mosi_o       (iface.core.spi_mosi),    \
.fd_spi_miso_i       (iface.core.spi_miso),    \
.fd_delay_len_o     (iface.core.delay_len),    \
.fd_delay_val_o      (iface.core.delay_val),    \
.fd_delay_pulse_o    (iface.core.delay_pulse),    \
.fd_dmtd_clk_o    (iface.core.dmtd_clk),    \
.fd_dmtd_fb_in_i  (iface.core.dmtd_fb_in),    \
.fd_dmtd_fb_out_i (iface.core.dmtd_fb_out),    \
.fd_pll_status_i (iface.core.pll_status),    \
.fd_ext_rst_n_o  (iface.core.ext_rst_n),    \
.fd_onewire_b (iface.core.onewire)

