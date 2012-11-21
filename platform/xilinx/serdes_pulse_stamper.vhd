library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.gencores_pkg.all;

entity serdes_pulse_stamper is

  generic (
    g_ref_clk_rate : integer := 125000000);

  port (
    rst_n_i : in std_logic;

    clk_ref_i       : in  std_logic;
    clk_sys_i       : in  std_logic;
    pll_locked_i    : in  std_logic;
    pulse_a_i       : in  std_logic;
    tm_time_valid_i : in  std_logic;
    tm_utc_i        : in  std_logic_vector(39 downto 0);
    tm_cycles_i     : in  std_logic_vector(27 downto 0);
    tag_utc_o       : out std_logic_vector(39 downto 0);
    tag_cycles_o    : out std_logic_vector(27 downto 0);
    tag_frac_o      : out std_logic_vector(11 downto 0);
    tag_valid_p1_o  : out std_logic;

    -- Spartan-6 specific signals (from a BUFPLL)
    clk_ioclk_i     : in std_logic;
    serdes_strobe_i : in std_logic
    );

end serdes_pulse_stamper;

architecture rtl of serdes_pulse_stamper is

  

  component s6_timing_serdes_input
    generic (
      sys_w : integer;
      dev_w : integer);
    port (
      DATA_IN_FROM_PINS : in  std_logic_vector(sys_w-1 downto 0);
      DATA_IN_TO_DEVICE : out std_logic_vector(dev_w-1 downto 0);
      serdesstrobe      : in  std_logic;
      io_clk            : in  std_logic;
      CLK_DIV_IN        : in  std_logic;
      LOCKED_IN         : in  std_logic;
      LOCKED_OUT        : out std_logic;
      CLK_RESET         : in  std_logic;
      IO_RESET          : in  std_logic);
  end component;

  signal rst, rst_n_ref : std_logic;

  signal data                                       : std_logic_vector(7 downto 0);
  signal output_ready, tag_valid_ref, tag_valid_sys : std_logic;

  signal tag_utc_ref    : std_logic_vector(39 downto 0);
  signal tag_cycles_ref : std_logic_vector(27 downto 0);
  signal tag_frac_ref   : std_logic_vector(11 downto 0);
  signal looking_for    : std_logic;
  
begin  -- rtl

  rst <= not rst_n_i;

  U_Serdes : s6_timing_serdes_input
    generic map (
      sys_w => 1,
      dev_w => 8)
    port map (
      DATA_IN_FROM_PINS(0) => pulse_a_i,
      DATA_IN_TO_DEVICE    => data,
      serdesstrobe         => serdes_strobe_i,
      io_clk               => clk_ioclk_i,
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

  p_time_tag : process(clk_ref_i)
  begin
    if rising_edge(clk_ref_i) then
      if rst_n_ref = '0' then
        tag_valid_ref <= '0';
        looking_for   <= '1';
      else
        
        for i in 0 to 7 loop
          if data(i) = looking_for then
            tag_valid_ref  <= looking_for and tm_time_valid_i and output_ready;
            tag_frac_ref   <= std_logic_vector(to_unsigned(i * 512, 12));
            tag_cycles_ref <= tm_cycles_i;
            tag_utc_ref    <= tm_utc_i;
            exit;
          end if;
        end loop;
        looking_for <= not data(7);
      end if;
    end if;
  end process;

  U_Sync_TagValid : gc_pulse_synchronizer
    port map (
      clk_in_i  => clk_ref_i,
      clk_out_i => clk_sys_i,
      rst_n_i   => rst_n_ref,
      d_ready_o => output_ready,
      d_p_i     => tag_valid_ref,
      q_p_o     => tag_valid_sys);

  p_output_tag : process(clk_sys_i)
  begin
    if rising_edge(clk_sys_i) then
      if rst_n_i = '0' then
        tag_valid_p1_o <= '0';
      else
        tag_valid_p1_o <= tag_valid_sys;
        if(tag_valid_sys = '1') then
          tag_utc_o    <= tag_utc_ref;
          tag_cycles_o <= tag_cycles_ref;
          tag_frac_o   <= tag_frac_ref;
        end if;
      end if;
    end if;
  end process;
  
end rtl;
