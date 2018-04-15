----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.11.2017 12:42:57
-- Design Name: 
-- Module Name: testbench_top_PS2 - Behavioral
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

entity testbench_topPS2 is
--  Port ( );
end testbench_topPS2;

architecture Behavioral of testbench_topPS2 is
component periferico_PS2 is
Port(
           reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           kbclock : in STD_LOGIC;
           kbdata : in STD_LOGIC;
           makecode : out STD_LOGIC_VECTOR (7 downto 0);
           tecla_ASCII : out STD_LOGIC_VECTOR (7 downto 0);
           flag_fin : out STD_LOGIC;
           flag_especial : out STD_LOGIC;
           read_strobe: in STD_LOGIC;
           interrupt : out STD_LOGIC;
           interrupt_ack : in STD_LOGIC
);
end component;

-- Clock period definitions
constant clk_period : time := 10 ns;
constant kb_period : time := 100us;

signal reset : STD_LOGIC;
signal clk : STD_LOGIC;
signal kbclock : STD_LOGIC;
signal kbdata : STD_LOGIC;
signal makecode : STD_LOGIC_VECTOR(7 downto 0);
signal tecla_ASCII : STD_LOGIC_VECTOR(7 downto 0);
signal flag_fin : STD_LOGIC;
signal flag_especial : STD_LOGIC;
signal interrupt : STD_LOGIC;
signal read_strobe : STD_LOGIC;
signal interrupt_ack : STD_LOGIC;

begin
uut: periferico_PS2
PORT MAP (

           reset =>reset,
           clk =>clk,
           kbclock =>kbclock,
           kbdata =>kbdata,
           makecode =>makecode,
           tecla_ASCII =>tecla_ASCII,
           flag_fin =>flag_fin,
           flag_especial =>flag_especial,
           read_strobe=>read_strobe,
           interrupt =>interrupt,
           interrupt_ack => interrupt_ack
);


   -- Clock process definitions
clk_process:process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
   
kb_clock: process begin
       kbclock <= '1';
       wait for kb_period/2;
       kbclock <= '0';
       wait for kb_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
             reset <= '1';
             read_strobe <= '0';
             interrupt_ack <= '0';
             wait for 2*clk_period;
             reset <= '0';
             wait for 2*clk_period;
             --primer ciclo de lectura
             kbdata <= '0';
             wait for kb_period;
             kbdata <= '0';
             wait for kb_period;
             kbdata <= '0';
             wait for kb_period;
             kbdata <= '0';
             wait for kb_period;
             kbdata <= '1';
             wait for kb_period;
             kbdata <= '1';
             wait for kb_period;
             kbdata <= '1';
             wait for kb_period;
             kbdata <= '1';
             wait for kb_period;
             kbdata <= '1';
             wait for kb_period;
             kbdata <= '0';
             wait for kb_period;
             kbdata <= '1';
             wait for kb_period;
 
  assert (false) report "fin simulacion" severity failure;
  end process;
  end Behavioral;