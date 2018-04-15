----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.11.2017 15:25:03
-- Design Name: 
-- Module Name: topPS2 - Behavioral
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

entity periferico_PS2 is
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           kbclock : in STD_LOGIC;
           kbdata : in STD_LOGIC;
           makecode : out STD_LOGIC_VECTOR (7 downto 0);
           tecla_ASCII : out STD_LOGIC_VECTOR (7 downto 0);
           flag_fin : out STD_LOGIC;
           flag_especial : out STD_LOGIC;
           read_strobe: in STD_LOGIC;
           interrupt_ack : in STD_LOGIC;
           interrupt : out STD_LOGIC);
end periferico_PS2;

architecture Behavioral of periferico_PS2 is

component Operative_Unit is
port (
           reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           kbclock : in STD_LOGIC;
           kbdata : in STD_LOGIC;
           flag_fin : out STD_LOGIC;
           flag_especial: out STD_LOGIC;
           makecode : out STD_LOGIC_VECTOR (7 downto 0);
           tecla_ASCII : out STD_LOGIC_VECTOR (7 downto 0);
           
           
           flag_fin_UC : out STD_LOGIC;
           flag_especial_UC: out STD_LOGIC;
           overflow_CTR : out STD_LOGIC;
           error_paridad: out STD_LOGIC;
           
           CE_flags_tester: in STD_LOGIC;
           CE_flags: in STD_LOGIC;
           CE_reg_desplazamiento: in STD_LOGIC;
           CE_paridad: in STD_LOGIC;
           CE_contador: in STD_LOGIC;
           reset_paridad: in STD_LOGIC;
           --reset_reg_ASCII: in STD_LOGIC;
           reset_contador: in STD_LOGIC
          


);
end component;


component Control_Unit is
port(     
          reset: in STD_LOGIC;
          clk: in STD_LOGIC;
          flags: in STD_LOGIC;
          kbdata : in STD_LOGIC;
          overflow : in STD_LOGIC;
          error_paridad : in STD_LOGIC;
          read_strobe: in STD_LOGIC;
          interrupt:out STD_LOGIC;
          interrupt_ack:in STD_LOGIC;
          CE_contador : out STD_LOGIC;  
          CE_reg_desplazamiento : out STD_LOGIC;
          CE_flags:out STD_LOGIC;
          CE_flags_tester:out STD_LOGIC;
        
          CE_paridad : out STD_LOGIC;
          Reset_paridad:out STD_LOGIC;
          Reset_contador : out STD_LOGIC
          --Reset_reg_ASCII:out STD_LOGIC;
                    
         
          --Reset_flags : out STD_LOGIC
          

);
end component;

signal t_flags:std_logic;

signal t_flag_fin:std_logic;
signal t_flag_especial:std_logic;
signal t_overflow_CTR :std_logic;
signal t_error_paridad:std_logic;

signal t_CE_flags:std_logic;
signal t_CE_flags_tester:std_logic;
signal t_CE_reg_desplaz:std_logic;
signal t_CE_paridad:std_logic;
signal t_CE_contador:std_logic;
signal t_Reset_paridad:std_logic;
signal t_Reset_contador:std_logic;
--signal t_Reset_reg_ASCII:std_logic;
--signal t_Reset_flags:std_logic;

begin

t_flags <= t_flag_fin or t_flag_especial;

C_Unit:Control_Unit port map(
          reset=>reset,
          clk=>clk,
          flags=>t_flags,
          kbdata=> kbdata,
          overflow =>t_overflow_CTR,
          error_paridad =>t_error_paridad,
          read_strobe=>read_strobe,
          interrupt=>interrupt,
          interrupt_ack =>interrupt_ack,
          
          CE_contador=>t_CE_contador,
          CE_reg_desplazamiento =>t_CE_reg_desplaz,
          CE_flags_tester=>t_CE_flags_tester,
          CE_flags=>t_CE_flags,
          
          CE_paridad =>t_CE_paridad,
          Reset_paridad=>t_Reset_paridad,
          Reset_contador =>t_Reset_contador
          --Reset_reg_ASCII=>t_Reset_reg_ASCII,
                    
          
          --Reset_flags=> t_Reset_flags



);

O_Unit: Operative_Unit port map(

           reset=>reset,
           clk=>clk,
           kbclock=> kbclock,
           kbdata =>kbdata,
           flag_fin =>flag_fin,
           flag_especial=>flag_especial,
           makecode =>makecode,
           tecla_ASCII =>tecla_ASCII,
           
           
           flag_fin_UC=>t_flag_fin,
           flag_especial_UC=>t_flag_especial,
           overflow_CTR =>t_overflow_CTR,
           error_paridad=>t_error_paridad,
          
           CE_flags=>t_CE_flags,
           CE_contador=>t_CE_contador,
           CE_reg_desplazamiento=>t_CE_reg_desplaz,
           CE_paridad=>t_CE_paridad,
           reset_paridad=>t_Reset_paridad,
           --reset_reg_ASCII=>t_Reset_reg_ASCII,
           reset_contador=>t_Reset_contador,
           CE_flags_tester=>t_CE_flags_tester


  
);

end Behavioral;
