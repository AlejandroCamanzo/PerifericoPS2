----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.09.2017 19:18:19
-- Design Name: 
-- Module Name: rs_flipflop - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rs_flipflop is
    Port ( clk : in STD_LOGIC;
           r : in STD_LOGIC;
           reset : in STD_LOGIC;
           s : in STD_LOGIC;
           q : out STD_LOGIC);
end rs_flipflop;

architecture Behavioral of rs_flipflop is
    signal q_int : STD_LOGIC;
    
begin
    q <= q_int;
process (clk) begin
    if (clk = '1' and clk'event) then
        if reset = '1' then
            q_int <= '0';
        elsif reset = '0' then
            if r = '1' then
             q_int <= '0';
            elsif s = '1' then
              q_int <= '1';
            else
                q_int <= q_int;
            end if;
        end if;
    end if;
end process;
end Behavioral;
