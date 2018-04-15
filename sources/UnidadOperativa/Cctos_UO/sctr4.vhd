--------------------------------------------------------------------------------
-- Company: University of Vigo
-- Engineer: Luis Jacobo Alvarez Ruiz de Ojeda
--
-- Create Date:   18:10:10 2/6/2017
-- Design Name: 
-- Module Name:    sctr4 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sctr4 is
    Port ( clk : in  STD_LOGIC;
           async_reset : in  STD_LOGIC;
           sync_reset : in  STD_LOGIC;
           ce : in  STD_LOGIC;
           load : in  STD_LOGIC;
           dir : in  STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (3 downto 0);
           q : out  STD_LOGIC_VECTOR (3 downto 0);
           tc : out  STD_LOGIC);
end sctr4;

architecture Behavioral of sctr4 is

	signal ctr_state: std_logic_vector (3 downto 0):= (others=>'0');
begin
	q <= ctr_state; -- asignación de la señal interna a la salida del contador

process (clk, ce, async_reset, sync_reset, dir, ctr_state)
begin
   if async_reset='1' then  -- asynchronous reset
		ctr_state <= "0000";
   elsif (clk'event and clk='1') then
	   if sync_reset='1' then -- synchronous reset
			ctr_state <= "0000";
		elsif load='1' then
         ctr_state <= din;
      else
         if ce='1' then
            if dir='1' then
					if ctr_state = "1111" then
						ctr_state <= "0000";
					else
						ctr_state <= ctr_state + 1;
					end if;
            else
					if ctr_state = "0000" then
						ctr_state <= "1111";
					else
						ctr_state <= ctr_state - 1;
					end if;				
            end if;
         end if;
      end if;
	end if;

-- Salida de fin de contaje (TC) que se activa cuando el contador llega al último estado
	if (((ctr_state = "1111") and dir = '1') or ((ctr_state = "0000") and dir = '0')) then tc <= '1';
	else tc <= '0';
	end if;
end process;

end Behavioral;