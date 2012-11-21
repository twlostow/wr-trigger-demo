---------------------------------------------------------------------------------------
-- Title          : Wishbone slave core for Trigger TX module
---------------------------------------------------------------------------------------
-- File           : trigger_tx_wb.vhd
-- Author         : auto-generated by wbgen2 from trigger_tx_wb.wb
-- Created        : Mon Nov 19 17:43:10 2012
-- Standard       : VHDL'87
---------------------------------------------------------------------------------------
-- THIS FILE WAS GENERATED BY wbgen2 FROM SOURCE FILE trigger_tx_wb.wb
-- DO NOT HAND-EDIT UNLESS IT'S ABSOLUTELY NECESSARY!
---------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.ttx_wbgen2_pkg.all;


entity trigger_tx_wb is
  port (
    rst_n_i                                  : in     std_logic;
    clk_sys_i                                : in     std_logic;
    wb_adr_i                                 : in     std_logic_vector(1 downto 0);
    wb_dat_i                                 : in     std_logic_vector(31 downto 0);
    wb_dat_o                                 : out    std_logic_vector(31 downto 0);
    wb_cyc_i                                 : in     std_logic;
    wb_sel_i                                 : in     std_logic_vector(3 downto 0);
    wb_stb_i                                 : in     std_logic;
    wb_we_i                                  : in     std_logic;
    wb_ack_o                                 : out    std_logic;
    wb_stall_o                               : out    std_logic;
    regs_i                                   : in     t_ttx_in_registers;
    regs_o                                   : out    t_ttx_out_registers
  );
end trigger_tx_wb;

architecture syn of trigger_tx_wb is

signal ttx_cr_enable_int                        : std_logic      ;
signal ttx_cr_rst_cnt_dly0                      : std_logic      ;
signal ttx_cr_rst_cnt_int                       : std_logic      ;
signal ttx_cr_id_int                            : std_logic_vector(15 downto 0);
signal ttx_adj_c_int                            : std_logic_vector(27 downto 0);
signal ttx_adj_f_int                            : std_logic_vector(11 downto 0);
signal ack_sreg                                 : std_logic_vector(9 downto 0);
signal rddata_reg                               : std_logic_vector(31 downto 0);
signal wrdata_reg                               : std_logic_vector(31 downto 0);
signal bwsel_reg                                : std_logic_vector(3 downto 0);
signal rwaddr_reg                               : std_logic_vector(1 downto 0);
signal ack_in_progress                          : std_logic      ;
signal wr_int                                   : std_logic      ;
signal rd_int                                   : std_logic      ;
signal allones                                  : std_logic_vector(31 downto 0);
signal allzeros                                 : std_logic_vector(31 downto 0);

begin
-- Some internal signals assignments. For (foreseen) compatibility with other bus standards.
  wrdata_reg <= wb_dat_i;
  bwsel_reg <= wb_sel_i;
  rd_int <= wb_cyc_i and (wb_stb_i and (not wb_we_i));
  wr_int <= wb_cyc_i and (wb_stb_i and wb_we_i);
  allones <= (others => '1');
  allzeros <= (others => '0');
-- 
-- Main register bank access process.
  process (clk_sys_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      ack_sreg <= "0000000000";
      ack_in_progress <= '0';
      rddata_reg <= "00000000000000000000000000000000";
      ttx_cr_enable_int <= '0';
      ttx_cr_rst_cnt_int <= '0';
      ttx_cr_id_int <= "0000000000000000";
      ttx_adj_c_int <= "0000000000000000000000000000";
      ttx_adj_f_int <= "000000000000";
    elsif rising_edge(clk_sys_i) then
-- advance the ACK generator shift register
      ack_sreg(8 downto 0) <= ack_sreg(9 downto 1);
      ack_sreg(9) <= '0';
      if (ack_in_progress = '1') then
        if (ack_sreg(0) = '1') then
          ttx_cr_rst_cnt_int <= '0';
          ack_in_progress <= '0';
        else
        end if;
      else
        if ((wb_cyc_i = '1') and (wb_stb_i = '1')) then
          case rwaddr_reg(1 downto 0) is
          when "00" => 
            if (wb_we_i = '1') then
              ttx_cr_enable_int <= wrdata_reg(0);
              ttx_cr_rst_cnt_int <= wrdata_reg(1);
              ttx_cr_id_int <= wrdata_reg(17 downto 2);
            end if;
            rddata_reg(0) <= ttx_cr_enable_int;
            rddata_reg(1) <= 'X';
            rddata_reg(17 downto 2) <= ttx_cr_id_int;
            rddata_reg(18) <= 'X';
            rddata_reg(19) <= 'X';
            rddata_reg(20) <= 'X';
            rddata_reg(21) <= 'X';
            rddata_reg(22) <= 'X';
            rddata_reg(23) <= 'X';
            rddata_reg(24) <= 'X';
            rddata_reg(25) <= 'X';
            rddata_reg(26) <= 'X';
            rddata_reg(27) <= 'X';
            rddata_reg(28) <= 'X';
            rddata_reg(29) <= 'X';
            rddata_reg(30) <= 'X';
            rddata_reg(31) <= 'X';
            ack_sreg(2) <= '1';
            ack_in_progress <= '1';
          when "01" => 
            if (wb_we_i = '1') then
            end if;
            rddata_reg(31 downto 0) <= regs_i.cntr_i;
            ack_sreg(0) <= '1';
            ack_in_progress <= '1';
          when "10" => 
            if (wb_we_i = '1') then
              ttx_adj_c_int <= wrdata_reg(27 downto 0);
            end if;
            rddata_reg(27 downto 0) <= ttx_adj_c_int;
            rddata_reg(28) <= 'X';
            rddata_reg(29) <= 'X';
            rddata_reg(30) <= 'X';
            rddata_reg(31) <= 'X';
            ack_sreg(0) <= '1';
            ack_in_progress <= '1';
          when "11" => 
            if (wb_we_i = '1') then
              ttx_adj_f_int <= wrdata_reg(11 downto 0);
            end if;
            rddata_reg(11 downto 0) <= ttx_adj_f_int;
            rddata_reg(12) <= 'X';
            rddata_reg(13) <= 'X';
            rddata_reg(14) <= 'X';
            rddata_reg(15) <= 'X';
            rddata_reg(16) <= 'X';
            rddata_reg(17) <= 'X';
            rddata_reg(18) <= 'X';
            rddata_reg(19) <= 'X';
            rddata_reg(20) <= 'X';
            rddata_reg(21) <= 'X';
            rddata_reg(22) <= 'X';
            rddata_reg(23) <= 'X';
            rddata_reg(24) <= 'X';
            rddata_reg(25) <= 'X';
            rddata_reg(26) <= 'X';
            rddata_reg(27) <= 'X';
            rddata_reg(28) <= 'X';
            rddata_reg(29) <= 'X';
            rddata_reg(30) <= 'X';
            rddata_reg(31) <= 'X';
            ack_sreg(0) <= '1';
            ack_in_progress <= '1';
          when others =>
-- prevent the slave from hanging the bus on invalid address
            ack_in_progress <= '1';
            ack_sreg(0) <= '1';
          end case;
        end if;
      end if;
    end if;
  end process;
  
  
-- Drive the data output bus
  wb_dat_o <= rddata_reg;
-- Enable
  regs_o.cr_enable_o <= ttx_cr_enable_int;
-- Reset counter
  process (clk_sys_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      ttx_cr_rst_cnt_dly0 <= '0';
      regs_o.cr_rst_cnt_o <= '0';
    elsif rising_edge(clk_sys_i) then
      ttx_cr_rst_cnt_dly0 <= ttx_cr_rst_cnt_int;
      regs_o.cr_rst_cnt_o <= ttx_cr_rst_cnt_int and (not ttx_cr_rst_cnt_dly0);
    end if;
  end process;
  
  
-- Broadcast Trigger ID
  regs_o.cr_id_o <= ttx_cr_id_int;
-- Trigger count
-- Reference clock cycles
  regs_o.adj_c_o <= ttx_adj_c_int;
-- Fractional part
  regs_o.adj_f_o <= ttx_adj_f_int;
  rwaddr_reg <= wb_adr_i;
  wb_stall_o <= (not ack_sreg(0)) and (wb_stb_i and wb_cyc_i);
-- ACK signal generation. Just pass the LSB of ACK counter.
  wb_ack_o <= ack_sreg(0);
end syn;
