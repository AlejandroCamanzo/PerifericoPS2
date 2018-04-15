----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.11.2017 12:23:44
-- Design Name: 
-- Module Name: testbench_Flags_Tester - Behavioral
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

entity testbench_Flags_Tester is
--  Port ( );
end testbench_Flags_Tester;

architecture Behavioral of testbench_Flags_Tester is

component Flags_Tester is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           ce : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (7 downto 0);
           flag_fin : out STD_LOGIC;
           flag_especial : out STD_LOGIC);
end component;

signal clk : STD_LOGIC;
signal reset : STD_LOGIC;
signal ce : STD_LOGIC;
signal D : STD_LOGIC_VECTOR(7 downto 0);
signal flag_fin : STD_LOGIC;
signal flag_especial : STD_LOGIC;
constant clk_period : time := 10 ns;

begin

uut: Flags_Tester port map(
    clk => clk,
    reset => reset,
    ce => ce,
    D => D,
    flag_fin => flag_fin,
    flag_especial => flag_especial);

clock: process begin
    clk <= '1';
    wait for clk_period/2;
    clk <= '0';
    wait for clk_period/2;
end process;

testbench: process begin
    reset <= '1';
    ce <= '0';
    D <= "00000000";    
    wait for 2* clk_period;
    
    reset <= '0';
    ce <= '1';
    D <= "11110000";
    wait for clk_period;
    D <= "11100000";
    wait for clk_period;
    D <= "10101010";
    wait for clk_period;
    ce <= '0';
    D <= "11110000";
    wait for clk_period;
    reset <= '1';
    wait for clk_period;
    
    assert (false) report "Fin Simulación" severity failure;
    
end process;
end Behavioral;
