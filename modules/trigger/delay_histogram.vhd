library ieee;
use ieee.std_logic_1164.all;
use ieee.NUMERIC_STD.all;

use work.genram_pkg.all;
use work.trx_wbgen2_pkg.all;

entity delay_histogram is

  generic(
    g_num_bins    : integer;
    g_input_width : integer);

  port(
    clk_sys_i : in std_logic;
    rst_n_i   : in std_logic;

    sample_i       : in std_logic_vector(g_input_width-1 downto 0);
    sample_valid_i : in std_logic;


    ram_addr_o : out std_logic_vector(f_log2_size(g_num_bins)-1 downto 0);
    ram_data_o : out std_logic_vector(31 downto 0);
    ram_data_i : in  std_logic_vector(31 downto 0);
    ram_wr_o   : out std_logic;

    regs_i : in t_trx_out_registers);

end delay_histogram;

architecture rtl of delay_histogram is
  constant c_mem_width : integer := f_log2_size(g_num_bins);

  signal rescaled : unsigned(c_mem_width-1 downto 0);
  signal addr     : unsigned(c_mem_width-1 downto 0);
  signal bin_cnt  : unsigned(31 downto 0);

  type   t_state is (WAIT_SAMPLE, FETCH1, FETCH2, FETCH3, INCREASE, CLEAR_MEM);
  signal state : t_state;
  
begin  -- rtl

  p_rescale : process(clk_sys_i)
  begin
    if rising_edge(clk_sys_i) then
      rescaled <= resize(((resize(unsigned(sample_i), 18) - resize(unsigned(regs_i.rx_hist_bias_o), 18)) * unsigned(regs_i.rx_hist_scale_o)) srl 17, c_mem_width);
    end if;
  end process;

  p_fsm : process(clk_sys_i)
  begin
    if rising_edge(clk_sys_i) then
      if rst_n_i = '0' or regs_i.cr_rst_hist_o = '1' then
        state    <= CLEAR_MEM;
        addr     <= to_unsigned(1, addr'length);
        ram_wr_o <= '0';
      else
        case state is
          when CLEAR_MEM =>
            ram_wr_o <= '1';
            bin_cnt  <= (others => '0');
            addr     <= addr + 1;
            if(addr = 0) then
              state <= WAIT_SAMPLE;
            end if;

          when WAIT_SAMPLE =>
            ram_wr_o <= '0';
            if(sample_valid_i = '1') then
              state <= FETCH1;
            end if;

          when FETCH1 =>
            addr  <= rescaled;
            state <= FETCH2;

          when FETCH2 =>
            state <= FETCH3;
            
          when FETCH3 =>
            bin_cnt <= unsigned(ram_data_i);
            state   <= INCREASE;

          when INCREASE =>
            bin_cnt  <= bin_cnt + 1;
            ram_wr_o <= '1';
            state    <= WAIT_SAMPLE;
            
            
        end case;
      end if;
    end if;
  end process;

  ram_addr_o <= std_logic_vector(addr);
  ram_data_o <= std_logic_vector(bin_cnt);

end rtl;
