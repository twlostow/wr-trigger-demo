`include "regs/fd_main_regs.vh"
`include "regs/fd_channel_regs.vh"

`include "wb/simdrv_defs.svh"
`include "timestamp.svh"

const int SPI_PLL  = 0;
const int SPI_GPIO  = 1;
const int SPI_DAC  = 2;

int dly_seed= 10;

class CSimDrv_FineDelay;
   protected CBusAccessor m_acc;
   protected Timestamp ts_queue[$];
   protected uint64_t m_base;

   
   const real c_acam_bin               = 27.012; // [ps]
   const real c_ref_period             = 8000; // [ps]
   const int c_frac_bits               = 12;
   const int c_scaler_shift            = 12;
   const int c_acam_start_offset       = 10000;
   const int c_acam_merge_c_threshold  = 1;
   const int c_acam_merge_f_threshold  = 2000;

   task writel(uint64_t addr, uint64_t data);
      m_acc.write(addr + m_base, data);
   endtask // writel

   task readl(uint64_t addr, ref uint64_t data);
      m_acc.read(addr + m_base, data);
   endtask // writel
   
   
   function new(CBusAccessor acc, uint64_t base_addr);
      m_acc  = acc;
      m_base = base_addr;
      
   endfunction // new

   
   /* fixme - maybe use real mcp23s17 model instead of this stub? */
   task sgpio_write(int value);
      uint64_t scr;
      
      scr = `FD_SCR_SEL_GPIO | `FD_SCR_CPOL | (value << `FD_SCR_DATA_OFFSET);
      writel(`ADDR_FD_SCR, scr);
      writel(`ADDR_FD_SCR, scr | `FD_SCR_START);
      
      while(1)
        begin
           readl(`ADDR_FD_SCR, scr);
           if(scr & `FD_SCR_READY)
             break;
        end
   endtask // sgpio_write

   
   task acam_write(int addr, int value);
      sgpio_write(addr);
      #10ns;
      writel(`ADDR_FD_TDR, value);
      writel(`ADDR_FD_TDCSR, `FD_TDCSR_WRITE);
   endtask // acam_write

   task acam_read(int addr, output int value);
      uint64_t rval;
      sgpio_write(addr);
      #10ns;
      writel(`ADDR_FD_TDR, (addr<<28)); 
      writel(`ADDR_FD_TDCSR, `FD_TDCSR_READ);
      #(500ns);
      readl(`ADDR_FD_TDR, rval);
      value           = rval;
   endtask // acam_read


   task get_time(ref Timestamp t);
      uint64_t tcr, secl, sech, cycles;
      
      readl(`ADDR_FD_TCR, tcr);
      writel(`ADDR_FD_TCR, tcr | `FD_TCR_CAP_TIME);
      readl(`ADDR_FD_TM_SECL, secl);
      readl(`ADDR_FD_TM_SECH, sech);
      readl(`ADDR_FD_TM_CYCLES, cycles);
      
      t.utc = (sech << 32) | secl;
      t.coarse = cycles;
      t.frac = 0;
   endtask // get_time

   task set_time(Timestamp t);
      uint64_t tcr;
      
      readl(`ADDR_FD_TCR, tcr);
      writel(`ADDR_FD_TM_SECL, t.utc & 32'hffffffff);
      writel(`ADDR_FD_TM_SECH, t.utc >> 32);
      writel(`ADDR_FD_TM_CYCLES, t.coarse);
      writel(`ADDR_FD_TCR, tcr | `FD_TCR_SET_TIME);
   endtask // set_time
   

   task set_reference(int wr);
      if(wr)
        begin
           uint64_t rval;
           
           $display("Enabling White Rabbit time reference...");
           writel(`ADDR_FD_TCR, `FD_TCR_WR_ENABLE);
           forever begin
              readl(`ADDR_FD_TCR, rval);
              if(rval & `FD_TCR_WR_LOCKED) break;
           end
           $display("WR Locked");
        end
      else begin
         Timestamp t = new(0,0,0);
         set_time(t);
         end
      endtask // set_reference
   

   task rbuf_update();
      Timestamp ts;
      uint64_t utc, coarse, seq_frac, stat, sech, secl;

      readl(`ADDR_FD_TSBCR, stat);

      if((stat & `FD_TSBCR_EMPTY) == 0) begin

         writel(`ADDR_FD_TSBR_ADVANCE, 1);
         
         readl(`ADDR_FD_TSBR_SECH, sech);
         readl(`ADDR_FD_TSBR_SECL, secl);
         readl(`ADDR_FD_TSBR_CYCLES,   coarse);
         readl(`ADDR_FD_TSBR_FID,  seq_frac);
         
         ts         = new (0,0,0);

         ts.source = seq_frac & 'h7;
         ts.utc     = (sech << 32) | secl;
         ts.coarse  = coarse & 'hfffffff;
         ts.seq_id  = (seq_frac >> 16) & 'hffff;
         ts.frac    = (seq_frac>>4) & 'hfff;
         ts_queue.push_back(ts);
         
      end
   endtask // rbuf_read

   function int poll();
      return (ts_queue.size() > 0);
   endfunction // poll

   function Timestamp get();
      return ts_queue.pop_front();
   endfunction // get
   
    
   typedef enum 
        {
         DELAY = 0,
         PULSE_GEN = 1
         } channel_mode_t;
      
  
   task config_output( int channel,channel_mode_t mode, int enable, Timestamp start_delay, uint64_t width_ps, uint64_t delta_ps=0, int rep_count=1);
      uint64_t dcr, base, rep;
      Timestamp t_start, t_end, t_delta, t_width;

      t_width = new;
      t_width.unflatten(int'(real'(width_ps) * 4096.0 / 8000.0));
      t_start  = start_delay;
      t_end  = start_delay.add(t_width);
      t_delta  = new;
      t_delta.unflatten(int'(real'(delta_ps) * 4096.0 / 8000.0));

      base = 'h100 + 'h100 * channel;
      
      writel(base + `ADDR_FD_FRR, 800);
      writel(base + `ADDR_FD_U_STARTH, t_start.utc >> 32);
      writel(base + `ADDR_FD_U_STARTL, t_start.utc & 'hffffffff);
      writel(base + `ADDR_FD_C_START, t_start.coarse);
      writel(base + `ADDR_FD_F_START, t_start.frac);
      writel(base + `ADDR_FD_U_ENDH, t_end.utc >> 32);
      writel(base + `ADDR_FD_U_ENDL, t_end.utc & 'hffffffff);
      writel(base + `ADDR_FD_C_END, t_end.coarse);
      writel(base + `ADDR_FD_F_END, t_end.frac);
      writel(base + `ADDR_FD_U_DELTA, t_delta.utc & 'hf);
      writel(base + `ADDR_FD_C_DELTA, t_delta.coarse);
      writel(base + `ADDR_FD_F_DELTA, t_delta.frac);

      if(rep_count < 0)
        rep = `FD_RCR_CONT;
      else
        rep = (rep_count-1) << `FD_RCR_REP_CNT_OFFSET;
  
      writel(base + `ADDR_FD_RCR, rep);
      

      dcr  = (enable? `FD_DCR_ENABLE : 0) | `FD_DCR_UPDATE ;
      if(mode == PULSE_GEN)
                  dcr |= `FD_DCR_MODE;
      if((width_ps < 200000) || (((delta_ps-width_ps) < 150000) && (rep_count > 1)))
        dcr |= `FD_DCR_NO_FINE;
      
      writel('h100 + 'h100 * channel + `ADDR_FD_DCR, dcr);
      if(mode == PULSE_GEN)
        writel('h100 + 'h100 * channel + `ADDR_FD_DCR, dcr | `FD_DCR_PG_ARM);
   endtask // config_output
   
   task init();
      int rval;
      uint64_t idr;
      
      Timestamp t = new;

      readl(`ADDR_FD_IDR, idr); /* Un-reset the card */

      $display("FD @ 0x%x: idr = 0x%x", m_base, idr);

      if(idr != 32'hf19ede1a)
        $error("Can't detect an FD core @ 0x%x\n", m_base);
      
      
      writel(`ADDR_FD_RSTR, 'hdeadffff); /* Un-reset the card */

      
      writel(`ADDR_FD_TDCSR, `FD_TDCSR_START_DIS | `FD_TDCSR_STOP_DIS);
      writel(`ADDR_FD_GCR, `FD_GCR_BYPASS);

      acam_write(5, c_acam_start_offset); // set StartOffset
      acam_read(5, rval);

      sgpio_write(8); /* permanently select FIFO1 */

      // Clear the ring buffer
      writel(`ADDR_FD_TSBCR, `FD_TSBCR_ENABLE | `FD_TSBCR_PURGE | `FD_TSBCR_RST_SEQ | (3 << `FD_TSBCR_CHAN_MASK_OFFSET));

      writel(`ADDR_FD_ADSFR, int' (real'(1<< (c_frac_bits + c_scaler_shift)) * c_acam_bin / c_ref_period));

      writel(`ADDR_FD_ASOR, c_acam_start_offset * 3);
      writel(`ADDR_FD_ATMCR, c_acam_merge_c_threshold | (c_acam_merge_f_threshold << 4));
      
      // Enable trigger input
      writel(`ADDR_FD_GCR,  0);
      
      t.utc = 0;
      t.coarse = 0;
      set_time(t);
      
      // Enable trigger input
      writel(`ADDR_FD_GCR,  `FD_GCR_INPUT_EN);
   endtask // init

   task force_cal_pulse(int channel, int delay_setpoint);
      writel(`ADDR_FD_FRR + (channel * 'h20), delay_setpoint);
      writel(`ADDR_FD_DCR + (channel * 'h20), `FD_DCR_FORCE_DLY);
      writel(`ADDR_FD_CALR, `FD_CALR_CAL_PULSE | ((1<<channel) << `FD_CALR_PSEL_OFFSET));
   endtask // force_cal_pulse
   
endclass // CSimDrv_FineDelay


