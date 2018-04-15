----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.11.2017 12:17:03
-- Design Name: 
-- Module Name: Flags_Tester - Behavioral
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

entity Flags_Tester is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           ce : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (7 downto 0);
           flag_fin : out STD_LOGIC;
           flag_especial : out STD_LOGIC);
end Flags_Tester;

architecture Behavioral of Flags_Tester is

begin
process(clk ,reset, ce, D) begin
if (clk = '1' and clk'event) then
    if (reset = '1') then
        flag_fin <= '0';
        flag_especial <= '0';
    elsif (ce = '1') then
        flag_fin <= D(7) and D(6) and D(5) and D(4) and not D(3) and not D(2) and not D(1) and not D(0);
        flag_especial <= D(7) and D(6) and D(5) and not D(4) and not D(3) and not D(2) and not D(1) and not D(0);
    end if;
end if;
end process;
end Behavioral;
