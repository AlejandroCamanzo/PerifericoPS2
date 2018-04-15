----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.11.2017 10:11:04
-- Design Name: 
-- Module Name: Odd_Parity_Tester - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Odd_Parity_Tester is
    Port ( clk : in STD_LOGIC;
           ce : in STD_LOGIC;
           reset : in STD_LOGIC;
           parity_bit : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (7 downto 0);
           odd_parity : out STD_LOGIC);
end Odd_Parity_Tester;

architecture Behavioral of Odd_Parity_Tester is

begin

process(D, parity_bit, clk, reset) begin
if (clk = '1' and clk'event) then
    if (reset = '1') then
        odd_parity <= '0';
    elsif ( ce = '1') then
        odd_parity <= d(0) xor d(1) xor d(2) xor d(3) xor d(4) xor d(5) xor d(6) xor d(7) xor parity_bit;
    end if;
end if;
end process;

end Behavioral;
