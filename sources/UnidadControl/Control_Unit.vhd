----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.11.2017 12:45:38
-- Design Name: 
-- Module Name: Control_Unit - Behavioral
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

entity Control_Unit is
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
end Control_Unit;

architecture Behavioral of Control_Unit is

type estados is (S0,S1,S2,S3,S4,S5,S6,S7); -- definimos los estados de la FSM

signal estado_actual : estados;
signal estado_siguiente : estados;
begin
-- check sensibilities ---------------------
state_memory: process(clk) begin
    if (clk = '1' and clk'event) then
        estado_actual <= estado_siguiente;
    end if;
end process;

state_check: process(clk, estado_actual, kbdata, reset, overflow, flags,
    error_paridad, interrupt_ack, read_strobe, estado_actual) begin
    case estado_actual is
    when S0 =>
        if reset = '1' then
            estado_siguiente <= S0;
        else
            estado_siguiente <= S1;
        end if;
    when S1 =>
        if reset = '1' then
            estado_siguiente <= S0;
        elsif kbdata = '0' then
            estado_siguiente <= S2;
        else
            estado_siguiente <= S1;
        end if;
    when S2 =>
        if reset = '1' then
            estado_siguiente <= S0;
        elsif overflow = '1' then
            estado_siguiente <= S3;
        end if;
    when S3 =>
        if reset = '1' then
            estado_siguiente <= S0;
        elsif flags = '1' then
            estado_siguiente <= S4;
        else
            estado_siguiente <= S5;
        end if;
    when S4 =>
        if reset = '1' then
            estado_siguiente <= S0;
        else
            estado_siguiente <= S1;
        end if;
    when S5 =>
        if reset = '1' then
            estado_siguiente <= S0;
        elsif error_paridad = '1' then
            estado_siguiente <= S0;
        elsif interrupt_ack = '1' then 
            estado_siguiente <= S6; 
        end if;
    when S6 =>
        if reset = '1' then
            estado_siguiente <= S0;
        elsif read_strobe = '1' then
            estado_siguiente <= S7;
        end if;
    when S7 =>
        estado_siguiente <= S0;
    end case;
end process;

state_behaviour: process(clk, estado_actual) begin
    case estado_actual is
    when S0 =>
        interrupt <= '0';
        CE_contador <= '0';
        CE_reg_desplazamiento <= '0';
        CE_flags <= '0';
        CE_flags_tester <= '0';
        CE_paridad <='0';
        Reset_contador <= '1';
        Reset_paridad <= '1';
    when S1 =>
        interrupt <= '0';
        CE_contador <= '0';
        CE_reg_desplazamiento <= '0';
        CE_flags <= '0'; -- para cuando retorna desde S4
        CE_flags_tester <= '0'; -- idem
        CE_paridad <='0';
        Reset_contador <= '0';
        Reset_paridad <= '0';
    when S2 =>
        interrupt <= '0';
        CE_contador <= '1';
        CE_reg_desplazamiento <= '1';
        CE_flags <= '0'; 
        CE_flags_tester <= '0'; 
        CE_paridad <='0';
        Reset_contador <= '0';
        Reset_paridad <= '0';
    when S3 =>
        interrupt <= '0';
        CE_contador <= '0';
        CE_flags <= '0';
        CE_reg_desplazamiento <= '0';
        CE_flags_tester <= '1';
        CE_paridad <= '1';
        Reset_contador <= '0';
        Reset_paridad <= '0';
    when S4 =>
        interrupt <= '0';
        CE_contador <= '0';
        CE_reg_desplazamiento <= '0';
        CE_flags <= '1';
        CE_flags_tester <= '1';
        CE_paridad <= '0';
        Reset_contador <= '1';
        Reset_paridad <= '0';
    when S5 =>
        CE_contador <= '0';
        CE_reg_desplazamiento <= '0';
        CE_flags_tester <= '0';
        CE_flags <= '0';
        Reset_contador <= '0';
        Reset_paridad <= '0';
        CE_paridad <= '0';
        interrupt <= '1';
    when S6 =>
        interrupt <= '0';
     CE_contador <= '0';
               CE_reg_desplazamiento <= '0';
               CE_flags_tester <= '0';
               CE_flags <= '0';
               Reset_contador <= '0';
               Reset_paridad <= '0';
               CE_paridad <= '0';
    when S7 =>
         CE_contador <= '0';
           CE_reg_desplazamiento <= '0';
           CE_flags_tester <= '0';
           CE_flags <= '0';
           Reset_contador <= '0';
           Reset_paridad <= '0';
           CE_paridad <= '0';
        interrupt <= '0';
    -- no se hace nada en S7,
    -- tan solo es un estado de transicion para que el pB lea los datos
    -- se incluye porque si no, Vivado da error
    end case;
end process;
end Behavioral;
