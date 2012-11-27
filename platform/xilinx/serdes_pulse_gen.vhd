library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.gencores_pkg.all;


entity serdes_pulse_gen is

  port (
    clk_ref_i       : in  std_logic;
    clk_sys_i       : in  std_logic;
    rst_n_i         : in  std_logic;
    pll_locked_i    : in  std_logic;
    pulse_a_o       : out std_logic;
    tm_time_valid_i : in  std_logic;
    tm_utc_i        : in  std_logic_vector(39 downto 0);
    tm_cycles_i     : in  std_logic_vector(27 downto 0);
    trig_ready_o    : out std_logic;
    trig_seconds_i  : in  std_logic_vector(39 downto 0);
    trig_cycles_i   : in  std_logic_vector(27 downto 0);
    trig_frac_i     : in  std_logic_vector(11 downto 0);
    trig_valid_p1_i : in  std_logic;
    duration_i      : in  std_logic_vector(27 downto 0);

    -- Spartan-6 specific signals (from a BUFPLL)
    clk_ioclk_i     : in std_logic;
    serdes_strobe_i : in std_logic
    );

end serdes_pulse_gen;

architecture rtl of serdes_pulse_gen is

  component s6_timing_serdes_output
    generic (
      sys_w : integer;
      dev_w : integer);
    port (
      DATA_OUT_FROM_DEVICE : in  std_logic_vector(dev_w-1 downto 0);
      DATA_OUT_TO_PINS     : out std_logic_vector(sys_w-1 downto 0);
      serdesstrobe         : in  std_logic;
      io_clk               : in  std_logic;
      CLK_DIV_IN           : in  std_logic;
      LOCKED_IN            : in  std_logic;
      LOCKED_OUT           : out std_logic;
      CLK_RESET            : in  std_logic;
      IO_RESET             : in  std_logic);
  end component;

  signal data : std_logic_vector(7 downto 0);

  signal trig_valid_ref                     : std_logic;
  signal trig_seconds_sys, trig_seconds_ref : std_logic_vector(39 downto 0);
  signal trig_cycles_sys, trig_cycles_ref   : std_logic_vector(27 downto 0);
  signal taps_sys, taps_ref                 : std_logic_vector(7 downto 0);


  signal rst, rst_n_ref : std_logic;

  type t_state is (WAIT_INPUT, EXEC_TRIGGER, GEN_PULSE);

  signal state          : t_state;
  signal duration_count : unsigned(27 downto 0);
  
begin  -- rtl

  rst <= not rst_n_i;

  U_Output_Serdes : s6_timing_serdes_output
    generic map (
      sys_w => 1,
      dev_w => 8)
    port map (
      DATA_OUT_FROM_DEVICE => data,
      DATA_OUT_TO_PINS(0)  => pulse_a_o,
--    CLK_IN               => clk_ref8x_i,
      io_clk               => clk_ioclk_i,
      serdesstrobe         => serdes_strobe_i,
      CLK_DIV_IN           => clk_ref_i,
      LOCKED_IN            => pll_locked_i,
      LOCKED_OUT           => open,
      CLK_RESET            => rst,
      IO_RESET             => rst);

  U_Sync_Reset : gc_sync_ffs
    port map (
      clk_i    => clk_ref_i,
      rst_n_i  => '1',
      data_i   => rst_n_i,
      synced_o => rst_n_ref);

  U_Sync_TagValid : gc_pulse_synchronizer
    port map (
      clk_in_i  => clk_sys_i,
      clk_out_i => clk_ref_i,
      rst_n_i   => rst_n_ref,
      d_ready_o => open,
      d_p_i     => trig_valid_p1_i,
      q_p_o     => trig_valid_ref);

  
  p_tag_input : process(clk_sys_i)
  begin
    if rising_edge(clk_sys_i) then
      if(trig_valid_p1_i = '1') then
        trig_cycles_sys  <= trig_cycles_i;
        trig_seconds_sys <= trig_seconds_i;

        case trig_frac_i(11 downto 9) is
          when "000"  => taps_sys <= "11111111";
          when "001"  => taps_sys <= "11111110";
          when "010"  => taps_sys <= "11111100";
          when "011"  => taps_sys <= "11111000";
          when "100"  => taps_sys <= "11110000";
          when "101"  => taps_sys <= "11100000";
          when "110"  => taps_sys <= "11000000";
          when "111"  => taps_sys <= "10000000";
          when others => taps_sys <= (others => 'X');
        end case;
        
      end if;
    end if;
  end process;

  p_latch_input : process(clk_ref_i)
    begin
      if rising_edge(clk_ref_i) then
        if(trig_valid_ref = '1' and tm_time_valid_i = '1') then
          trig_cycles_ref  <= trig_cycles_sys;
          trig_seconds_ref <= trig_seconds_sys;
          taps_ref         <= taps_sys;
        end if;
      end if;
    end process;
  
  p_fsm : process(clk_ref_i)
  begin
    if rising_edge(clk_ref_i) then
      if rst_n_ref = '0' then
        state <= WAIT_INPUT;
        data  <= (others => '0');
        
      else
        case state is
          when WAIT_INPUT =>
            data <= (others => '0');

            if(trig_valid_ref = '1' and tm_time_valid_i = '1') then
              state <= EXEC_TRIGGER;
            end if;

          when EXEC_TRIGGER =>
            if(tm_time_valid_i = '0') then
              state <= WAIT_INPUT;
              
            elsif(tm_cycles_i = trig_cycles_ref and tm_utc_i = trig_seconds_ref) then
              data           <= taps_ref;
              duration_count <= (others => '0');
              state          <= GEN_PULSE;
            end if;

          when GEN_PULSE =>
            duration_count <= duration_count + 1;
            if(duration_count = unsigned(duration_i)) then
              data  <= not taps_ref;
              state <= WAIT_INPUT;
            else
              data <= (others => '1');
            end if;
            
        end case;
      end if;
    end if;
  end process;



end rtl;
