library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.trigger_pkg.all;
use work.tts_wbgen2_pkg.all;

entity trigger_detect is
  
  generic (
    g_num_triggers : integer);

  port (
    clk_sys_i : in std_logic;
    rst_n_i   : in std_logic;

    trig_id_i       : in std_logic_vector(11 downto 0);
    trig_id_valid_i : in std_logic;

    ram_addr_o : out  std_logic_vector(6 downto 0);
    ram_data_o : out std_logic_vector(31 downto 0);
    ram_data_i : in  std_logic_vector(31 downto 0);
    ram_we_o   : out std_logic;

    regs_i : in t_tts_out_registers
    );

end trigger_detect;

architecture rtl of trigger_detect is
  
  type t_state is (CLEAR_MEM, WAIT_SAMPLE, FETCH1,FETCH2, UPDATE);

  signal state    : t_state;
  signal addr     : unsigned(6 downto 0);
  signal trig_bit : std_logic_vector(4 downto 0);

  function f_onehot_encode(x : std_logic_vector) return std_logic_vector is
    variable tmp : std_logic_vector(2**x'length-1 downto 0);
  begin
    tmp                          := (others => '0');
    tmp(to_integer(unsigned(x))) := '1';
    return tmp;
  end f_onehot_encode;
  
begin  -- rtl

  ram_data_o <= (others => '0') when (state = CLEAR_MEM or state = FETCH1 or state = FETCH2)
                else ram_data_i or f_onehot_encode(trig_bit(4 downto 0));

  p_fsm : process(clk_sys_i)
  begin
    if rising_edge(clk_sys_i) then
      if rst_n_i = '0' or regs_i.cr_clear_tdb_o = '1' then
        state    <= CLEAR_MEM;
        addr     <= to_unsigned(1, addr'length);
        ram_we_o <= '0';
      else
        case state is
          when CLEAR_MEM =>
            ram_we_o <= '1';
            addr     <= addr + 1;
            if(addr = 0) then
              state <= WAIT_SAMPLE;
            end if;

          when WAIT_SAMPLE =>
            ram_we_o <= '0';

            if(trig_id_valid_i = '1') then
              addr     <= unsigned(trig_id_i(11 downto 5));
              trig_bit <= trig_id_i(4 downto 0);
              state    <= FETCH1;
            end if;

          when FETCH1 =>
            state <= FETCH2;

          when FETCH2 =>
            state <= UPDATE;

          when UPDATE =>
            ram_we_o <= '1';
            state <= WAIT_SAMPLE;
         
        end case;
      end if;
    end if;
  end process;

  ram_addr_o <= std_logic_vector(addr);

end rtl;
