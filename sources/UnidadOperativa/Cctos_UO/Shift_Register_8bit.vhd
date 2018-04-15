----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.11.2017 10:24:32
-- Design Name: 
-- Module Name: Shift_Register_8bit - Behavioral
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

entity Shift_Register_8bit is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           ce : in STD_LOGIC;
           D : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (7 downto 0));
end Shift_Register_8bit;

architecture Behavioral of Shift_Register_8bit is

signal Q_intern : std_logic_vector (7 downto 0);

begin
    
Q <= Q_intern;
    
process(clk, reset, ce, D) begin
if (clk='1' and clk'event) then
    if (reset = '1') then
        Q_intern <= "00000000";
    else
        if (ce = '1') then -- Desplazamos cada ciclo de reloj si ce esta a 1
            Q_intern(7) <= Q_intern(6);
            Q_intern(6) <= Q_intern(5);
            Q_intern(5) <= Q_intern(4);
            Q_intern(4) <= Q_intern(3);
            Q_intern(3) <= Q_intern(2);
            Q_intern(2) <= Q_intern(1);
            Q_intern(1) <= Q_intern(0);
            Q_intern(0) <= D;
        end if;    
    end if;
end if;
end process;

end Behavioral;
