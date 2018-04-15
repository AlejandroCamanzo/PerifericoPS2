----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.11.2017 10:32:47
-- Design Name: 
-- Module Name: testbench_Shift_Register_8bit - Behavioral
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

entity testbench_Shift_Register_8bit is
--  Port ( );
end testbench_Shift_Register_8bit;

architecture Behavioral of testbench_Shift_Register_8bit is

component Shift_Register_8bit is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           ce : in STD_LOGIC;
           D : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal clk : STD_LOGIC;
signal reset : STD_LOGIC;
signal ce : STD_LOGIC;
signal D : STD_LOGIC;
signal Q : STD_LOGIC_VECTOR (7 downto 0);
constant clk_period : time := 10 ns;

begin

uut: Shift_Register_8bit port map(
    clk => clk,
    reset => reset,
    ce => ce,
    D => D,
    Q => Q);
    
clock: process begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

testbench: process begin

    reset <= '1';
    ce <= '0';
    D <= '0';
    wait for 3*clk_period;
    reset <= '0';
    D <= '1';
    wait for clk_period;
    ce <= '1';
    wait for 2*clk_period;
    D <= '0'; 
    wait for clk_period;
    ce <= '0';
    wait for clk_period*2;
    ce <='1';
    wait for clk_period;
    D <= '1';
    wait for 3*clk_period;
    D <= '0';
    wait for 2 clk_period;
    wait for clk_period;
    reset <='1';
    
    wait for 2*clk_period;
    assert (false) report "fin testbench" severity failure;

end process;

end Behavioral;
