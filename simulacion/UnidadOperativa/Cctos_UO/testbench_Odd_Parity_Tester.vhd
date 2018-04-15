----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.11.2017 10:21:50
-- Design Name: 
-- Module Name: testbench_Odd_Parity_Tester - Behavioral
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

entity testbench_Odd_Parity_Tester is
--  Port ( );
end testbench_Odd_Parity_Tester;

architecture Behavioral of testbench_Odd_Parity_Tester is

component Odd_Parity_Tester is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           parity_bit : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (7 downto 0);
           odd_parity : out STD_LOGIC);
end component;

signal clk : STD_LOGIC;
signal reset : STD_LOGIC;
signal D : STD_LOGIC_VECTOR (7 downto 0);
signal parity_bit : STD_LOGIC;
signal odd_parity : STD_LOGIC;
constant clk_period : time := 10ns;

begin

uut: Odd_Parity_Tester port map(
    clk => clk,
    reset => reset,
    D => D,
    parity_bit => parity_bit,
    odd_parity => odd_parity);
    
clock: process begin
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
    wait for clk_period/2;
end process;

process begin

    D <= "00000000";
    parity_bit <= '0';
    reset <= '1';
    wait for 2*clk_period;
    reset <= '0';
    D <= "10101010";
    parity_bit <= '1';
    wait for clk_period;
    D <= "11001110";
    parity_bit <= '0';
    wait for clk_period;
    D <= "11101110";
    wait for clk_period;
    reset <= '1';
    wait for 2*clk_period;
    
    assert (false) report "fin de simulacion" severity failure;
    
end process;
end Behavioral;
