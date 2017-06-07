-- File last modified by Fizzim2 (build 16.04.26) at 2:16:19 PM on 26/05/17
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity poly is
port (
-- OUTPUTS dff-onState
    temp1_out : out unsigned( 23 downto 0);

-- INPUTS
    a : in unsigned(7 downto 0);
    b : in unsigned(1 downto 0);
    c : in unsigned(7 downto 0);
    x : in unsigned(7 downto 0);
    temp1_in : in unsigned(23 downto 0);

-- GLOBAL
    clk: in std_logic;

);
end;

architecture rtl of poly is

-- STATE Definitions
type states is (
    compute_ax,
    compute_ax_p_b,
    compute_ax_p_b_m_x,
    compute_ax_p_b_m_x_p_c);

signal  state: states;

begin

run_stmc: process (clk ,reset)
begin 
    if (reset) then
        state <= compute_ax;
    elsif (clk'EVENT and clk='1') then
        case (state) is
            when compute_ax =>            
                    state <= compute_ax_p_b;
            when compute_ax_p_b =>            
                    state <= compute_ax_p_b_m_x;
            when compute_ax_p_b_m_x =>            
                    state <= compute_ax_p_b_m_x_p_c;
            when compute_ax_p_b_m_x_p_c =>            
                    state <= compute_ax;
        end case;
    end if;
end process;

-- Drive outputs 
compute: process (clk ,reset)
begin
        temp1_out <= (others=>'0');

        case (state) is
            when compute_ax =>
                temp1_out <= a*x;
            when compute_ax_p_b =>
                temp1_out <= temp1_in + b;
            when compute_ax_p_b_m_x =>
                temp1_out <= temp1_in*x;
            when compute_ax_p_b_m_x_p_c =>
                temp1_out <= temp1_in + c;
        end case;
    end if;
end process;
end architecture; -- Fizzim2
