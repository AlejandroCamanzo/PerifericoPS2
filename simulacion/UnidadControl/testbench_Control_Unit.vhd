----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.11.2017 18:59:49
-- Design Name: 
-- Module Name: testbench_Control_Unit - Behavioral
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

entity testbench_Control_Unit is
--  Port ( );
end testbench_Control_Unit;

architecture Behavioral of testbench_Control_Unit is

component Control_Unit is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           flags : in STD_LOGIC;
           kbdata : in STD_LOGIC;
           overflow : in STD_LOGIC;
           error_paridad : in STD_LOGIC;
           read_strobe : in STD_LOGIC;
           interrupt_ack : in STD_LOGIC;
           interrupt : out STD_LOGIC;
           CE_contador : out STD_LOGIC;
           CE_reg_desplazamiento : out STD_LOGIC;
           CE_flags : out STD_LOGIC;
           CE_flags_tester : out STD_LOGIC;
           CE_paridad : out STD_LOGIC;
           Reset_contador : out STD_LOGIC;
           Reset_paridad : out STD_LOGIC);
end component;

signal clk : STD_LOGIC;
signal reset : STD_LOGIC;
signal flags : STD_LOGIC;
signal kbdata : STD_LOGIC;
signal  overflow : STD_LOGIC;
signal error_paridad : STD_LOGIC;
signal read_strobe : STD_LOGIC;
signal interrupt_ack : STD_LOGIC;
signal interrupt : STD_LOGIC;
signal CE_contador : STD_LOGIC;
signal CE_reg_desplazamiento : STD_LOGIC;
signal CE_flags :  STD_LOGIC;
signal CE_flags_tester :  STD_LOGIC;
signal CE_paridad :  STD_LOGIC;
signal Reset_contador :  STD_LOGIC;
signal Reset_paridad : STD_LOGIC;

constant clk_period : time := 10 ns;
constant kb_period : time := 100 us; 

begin

uut: Control_Unit port map (
           clk => clk,
           reset => reset,
           flags => flags,
           kbdata => kbdata,
           overflow => overflow,
           error_paridad => error_paridad,
           read_strobe => read_strobe,
           interrupt_ack => interrupt_ack,
           interrupt => interrupt,
           CE_contador => CE_contador,
           CE_reg_desplazamiento => CE_reg_desplazamiento,
           CE_flags => CE_flags,
           CE_flags_tester => CE_flags_tester,
           CE_paridad => CE_paridad,
           Reset_contador => Reset_contador,
           Reset_paridad => Reset_paridad);
           
clock: process begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
end process;

testbench: process begin
-- signals go here
           reset <= '1';
           flags <= '0';
           kbdata <= '1';
           overflow <= '0';
           error_paridad <= '0';
           read_strobe <= '0';
           interrupt_ack <= '0';
           wait for 2*clk_period;
           reset <= '0';
           wait for 2*kb_period;
           --primer ciclo de lectura
           kbdata <= '0';
           wait for 8*kb_period;
           overflow <= '1';
           wait for clk_period;
           overflow <= '0';
           wait for kb_period - clk_period;
           kbdata <= '1';
           wait for 6*clk_period;
           interrupt_ack <= '1';
           wait for clk_period;
           interrupt_ack <= '0';
           wait for clk_period;
           read_strobe <= '1';
           wait for clk_period;
           read_strobe <= '0';
           wait for 2*kb_period; 
           -- segundo ciclo de lectura
           kbdata <= '0';
                      wait for 8*kb_period;
                      overflow <= '1';
                      wait for clk_period;
                      overflow <= '0';
                      flags <= '1';
                      wait for clk_period;
                      flags <= '0';
                      wait for 8*kb_period - 2*clk_period;
                      overflow <= '1';
                      wait for clk_period;
                      overflow <= '0';
                      wait for kb_period - clk_period;
                      kbdata <= '1';
                      wait for 6*clk_period;
                      interrupt_ack <= '1';
                      wait for clk_period;
                      interrupt_ack <= '0';
                      wait for clk_period;
                      read_strobe <= '1';
                      wait for clk_period;
                      read_strobe <= '0';
                      wait for clk_period;
assert (false) report "fin simulacion" severity failure;
end process;
end Behavioral;
