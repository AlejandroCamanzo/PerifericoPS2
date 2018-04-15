----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.11.2017 22:23:42
-- Design Name: 
-- Module Name: testbench_Operative_Unit - Behavioral
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

entity testbench_Operative_Unit is
--  Port ( );
end testbench_Operative_Unit;

architecture Behavioral of testbench_Operative_Unit is
component Operative_Unit is
   Port ( kbclock : in STD_LOGIC;
          kbdata : in STD_LOGIC;
          clk : in STD_LOGIC;
          reset : in STD_LOGIC;
          CE_reg_desplazamiento : in STD_LOGIC;
          CE_paridad : in STD_LOGIC;
          CE_contador : in STD_LOGIC;
          CE_flags : in STD_LOGIC;
          CE_flags_tester : in STD_LOGIC;
          reset_paridad : in STD_LOGIC;
          reset_contador : in STD_LOGIC;
          flag_fin_UC : out STD_LOGIC;
          flag_fin : out STD_LOGIC;
          flag_especial_UC : out STD_LOGIC;
          flag_especial : out STD_LOGIC;
          
          overflow_CTR : out STD_LOGIC;
          error_paridad : out STD_LOGIC;
          tecla_ASCII : out STD_LOGIC_VECTOR (7 downto 0);
          makecode : out STD_LOGIC_VECTOR (7 downto 0));
end component;

           signal kbclock :  STD_LOGIC;
           signal  kbdata :  STD_LOGIC;
           signal clk :  STD_LOGIC;
           signal reset :  STD_LOGIC;
           signal CE_reg_desplazamiento :  STD_LOGIC;
           signal CE_paridad :  STD_LOGIC;
           signal CE_contador : STD_LOGIC;
           signal flag_fin_UC : STD_LOGIC;
           signal flag_fin :  STD_LOGIC;
           signal flag_especial_UC :  STD_LOGIC;
           signal flag_especial :  STD_LOGIC;
           signal reset_flags :  STD_LOGIC;
           signal reset_paridad :  STD_LOGIC;
           signal reset_contador :  STD_LOGIC;
           signal CE_flags_tester : STD_LOGIC;
           signal overflow_CTR :  STD_LOGIC;
           signal error_paridad :  STD_LOGIC;
           signal tecla_ASCII :  STD_LOGIC_VECTOR (7 downto 0);
           signal makecode :  STD_LOGIC_VECTOR (7 downto 0);
           
           constant clk_period : time := 10ns;
           constant kb_period : time := 100us;
begin

uut:  Operative_Unit port map (
           kbclock => kbclock,
           kbdata => kbdata,
           clk => clk,
           reset => reset,
           CE_reg_desplazamiento => CE_reg_desplazamiento,
           CE_paridad => CE_paridad,
           CE_contador => CE_contador,
           CE_flags => reset_flags,
           CE_flags_tester => CE_flags_tester,
           reset_paridad => reset_paridad,
           reset_contador => reset_contador,
           flag_fin_UC => flag_fin_UC,
           flag_fin => flag_fin,
           flag_especial_UC => flag_especial_UC,
           flag_especial => flag_especial,
           overflow_CTR => overflow_CTR,
           error_paridad => error_paridad,
           tecla_ASCII => tecla_ASCII,
           makecode => makecode);

clock: process begin
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

testbench: process begin
    kbdata <= '1';
    reset <= '1';
    reset_flags <= '0';
    reset_paridad <= '0';
    reset_contador <= '0';
    CE_flags_tester <= '0';
    CE_paridad <= '0';
    CE_reg_desplazamiento <= '0';
    wait for 2*clk_period;
    reset <= '0';
    reset_contador <= '1';
    CE_paridad <= '1'; -- para eliminar el estado U del biestable de paridad
    wait for clk_period;
    CE_paridad <= '0';
    reset_contador <= '0';
    kbdata <= '0';
    wait for clk_period;
    CE_reg_desplazamiento <= '1';
    CE_contador <= '1';
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
    kbdata <= '0';
    wait for kb_period;    
    kbdata <= '0';
    wait for kb_period;    
    kbdata <= '0'; -- bit paridad impar
    -- aqui el contador debe haber dado overflow
    -- envio correcto
    CE_flags_tester <= '1';
    CE_contador <= '0';
    CE_reg_desplazamiento <= '0';
    CE_paridad <= '1';
    wait for clk_period;
    CE_paridad <= '0';
    reset_contador <= '1';
    wait for kb_period - clk_period;    
    kbdata <= '1';
    CE_flags_tester <= '0'; 
    reset_contador <= '0';
    wait for kb_period;
        reset_contador <= '0';
        kbdata <= '0';
        wait for clk_period;
        CE_reg_desplazamiento <= '1';
        CE_contador <= '1';
        wait for kb_period;    
        kbdata <= '0';
        wait for kb_period;    
        kbdata <= '1';
        wait for kb_period;    
        kbdata <= '0';
        wait for kb_period;    
        kbdata <= '1';
        wait for kb_period;    
        kbdata <= '1';
        wait for kb_period;    
        kbdata <= '1';
        wait for kb_period;    
        kbdata <= '0';
        wait for kb_period;    
        kbdata <= '0';
        wait for kb_period;    
        kbdata <= '0'; -- bit paridad impar
        -- aqui el contador debe haber dado overflow
        -- envio incorrecto
        CE_contador <= '0';
        CE_reg_desplazamiento <= '0';
        CE_paridad <= '1';
        wait for clk_period;
        reset_flags <= '1';
        CE_paridad <= '0';
        reset_contador <= '1';
        wait for kb_period - clk_period;    
        kbdata <= '1';
        reset_contador <= '1';
            wait for clk_period;
            reset_contador <= '0';
            kbdata <= '0';
            wait for clk_period;
            CE_reg_desplazamiento <= '1';
            CE_contador <= '1';
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
            kbdata <= '0';
            wait for kb_period;    
            kbdata <= '0';
            wait for kb_period;    
            kbdata <= '0';
            wait for kb_period;    
            kbdata <= '1'; -- bit paridad impar
            -- aqui el contador debe haber dado overflow
            -- envio F0
            CE_flags_tester <= '1';
            reset_flags <= '0';
            CE_contador <= '0';
            CE_reg_desplazamiento <= '0';
            CE_paridad <= '1';
            wait for 2*clk_period; -- requierer 2 ciclos el flag_tester para funcionar
            CE_flags_tester <= '0';
            CE_paridad <= '0';
            wait for kb_period - clk_period;    
            kbdata <= '1';
            reset_contador <= '1';
            reset_paridad <= '1';
            wait for clk_period;
            reset_paridad <= '0';
                wait for clk_period;
                reset_contador <= '0';
                kbdata <= '0';
                wait for clk_period;
                CE_reg_desplazamiento <= '1';
                CE_contador <= '1';
                wait for kb_period -2*clk_period;    
                kbdata <= '1';
                wait for kb_period;    
                kbdata <= '1';
                wait for kb_period;    
                kbdata <= '1';
                wait for kb_period;    
                kbdata <= '0';
                wait for kb_period;    
                kbdata <= '0';
                wait for kb_period;    
                kbdata <= '0';
                wait for kb_period;    
                kbdata <= '0';
                wait for kb_period;    
                kbdata <= '0';
                wait for kb_period;    
                kbdata <= '0'; -- bit paridad impar
                -- aqui el contador debe haber dado overflow
                -- envio E0
                CE_flags_tester <= '1';
                reset_flags <= '0';
                CE_contador <= '0';
                CE_reg_desplazamiento <= '0';
                CE_paridad <= '1';
                wait for clk_period;
                CE_paridad <= '0';
                wait for kb_period - clk_period;    
                kbdata <= '1';
                CE_flags_tester <= '0';
                wait for kb_period;
                
    assert (false) report "fin simulacion" severity failure;
end process;
end Behavioral;