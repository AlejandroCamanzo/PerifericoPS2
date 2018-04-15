----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.09.2017 19:25:57
-- Design Name: 
-- Module Name: biestableD - Behavioral
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

entity biestableD is
    Port ( D : in STD_LOGIC;
           ce : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           Q : out STD_LOGIC);
end biestableD;

architecture Behavioral of biestableD is

signal Qint : STD_LOGIC;

begin
    Q <= Qint;

    process (clk, ce) begin
    
    if (clk = '1' and clk'event and ce = '1') then
        if reset = '1' then
            Qint <= '0';
        else
            Qint <= D;
        end if;
    end if;

    end process;
    
end Behavioral;
