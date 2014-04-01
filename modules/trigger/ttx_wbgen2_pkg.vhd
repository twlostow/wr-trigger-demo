---------------------------------------------------------------------------------------
-- Title          : Wishbone slave core for Trigger TX module
---------------------------------------------------------------------------------------
-- File           : ttx_wbgen2_pkg.vhd
-- Author         : auto-generated by wbgen2 from trigger_tx_wb.wb
-- Created        : Thu Mar 14 23:42:50 2013
-- Standard       : VHDL'87
---------------------------------------------------------------------------------------
-- THIS FILE WAS GENERATED BY wbgen2 FROM SOURCE FILE trigger_tx_wb.wb
-- DO NOT HAND-EDIT UNLESS IT'S ABSOLUTELY NECESSARY!
---------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package ttx_wbgen2_pkg is
  
  
  -- Input registers (user design -> WB slave)
  
  type t_ttx_in_registers is record
    cntr_i                                   : std_logic_vector(31 downto 0);
    end record;
  
  constant c_ttx_in_registers_init_value: t_ttx_in_registers := (
    cntr_i => (others => '0')
    );
    
    -- Output registers (WB slave -> user design)
    
    type t_ttx_out_registers is record
      cr_enable_o                              : std_logic;
      cr_rst_cnt_o                             : std_logic;
      cr_id_o                                  : std_logic_vector(15 downto 0);
      adj_c_o                                  : std_logic_vector(27 downto 0);
      adj_f_o                                  : std_logic_vector(11 downto 0);
      end record;
    
    constant c_ttx_out_registers_init_value: t_ttx_out_registers := (
      cr_enable_o => '0',
      cr_rst_cnt_o => '0',
      cr_id_o => (others => '0'),
      adj_c_o => (others => '0'),
      adj_f_o => (others => '0')
      );
    function "or" (left, right: t_ttx_in_registers) return t_ttx_in_registers;
    function f_x_to_zero (x:std_logic) return std_logic;
    function f_x_to_zero (x:std_logic_vector) return std_logic_vector;
end package;

package body ttx_wbgen2_pkg is
function f_x_to_zero (x:std_logic) return std_logic is
begin
if(x = 'X' or x = 'U') then
return '0';
else
return x;
end if; 
end function;
function f_x_to_zero (x:std_logic_vector) return std_logic_vector is
variable tmp: std_logic_vector(x'length-1 downto 0);
begin
for i in 0 to x'length-1 loop
if(x(i) = 'X' or x(i) = 'U') then
tmp(i):= '0';
else
tmp(i):=x(i);
end if; 
end loop; 
return tmp;
end function;
function "or" (left, right: t_ttx_in_registers) return t_ttx_in_registers is
variable tmp: t_ttx_in_registers;
begin
tmp.cntr_i := f_x_to_zero(left.cntr_i) or f_x_to_zero(right.cntr_i);
return tmp;
end function;
end package body;
