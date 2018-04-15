----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.11.2017 14:10:20
-- Design Name: 
-- Module Name: Operative_Unit - Behavioral
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

entity Operative_Unit is
    Port ( kbclock : in STD_LOGIC;
           kbdata : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           CE_reg_desplazamiento : in STD_LOGIC;
           CE_paridad : in STD_LOGIC;
           CE_contador : in STD_LOGIC;
           CE_flags : in STD_LOGIC;
           CE_flags_tester: in STD_LOGIC;
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
end Operative_Unit;

architecture Behavioral of Operative_Unit is

component Shift_Register_8bit is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           ce : in STD_LOGIC;
           D : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component Odd_Parity_Tester is
    Port ( clk : in STD_LOGIC;
           ce : in STD_LOGIC;
           reset : in STD_LOGIC;
           parity_bit : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (7 downto 0);
           odd_parity : out STD_LOGIC);
end component;

component Flags_Tester is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           ce : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (7 downto 0);
           flag_fin : out STD_LOGIC;
           flag_especial : out STD_LOGIC);
end component;

component detector_flancos is
    Port ( entrada : in std_logic;
           clk : in std_logic;
           reset : in std_logic;
           fa_entrada : out std_logic; -- flanco ascendente
           fd_entrada : out std_logic -- flanco descendente
				);
end component;

component sctr4 is
    Port ( clk : in  STD_LOGIC;
           async_reset : in  STD_LOGIC;
           sync_reset : in  STD_LOGIC;
           ce : in  STD_LOGIC;
           load : in  STD_LOGIC;
           dir : in  STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (3 downto 0);
           q : out  STD_LOGIC_VECTOR (3 downto 0);
           tc : out  STD_LOGIC);
end component;

component dual_port_dedicated_bram_sync_read is
    Port ( clk : in STD_LOGIC;
           we : in STD_LOGIC;
           write_addr : in STD_LOGIC_VECTOR (7 downto 0);
           read_addr : in STD_LOGIC_VECTOR (7 downto 0);
           din : in STD_LOGIC_VECTOR (7 downto 0);
           dout : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component  biestableD is
    Port ( D : in STD_LOGIC;
           ce : in STD_LOGIC;
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           Q : out STD_LOGIC);
end component;

component rs_flipflop is
    Port ( clk : in STD_LOGIC;
           r : in STD_LOGIC;
           reset : in STD_LOGIC;
           s : in STD_LOGIC;
           q : out STD_LOGIC);
end component;

signal flanco_kbclock : STD_LOGIC;
signal makecode_salida_reg : STD_LOGIC_VECTOR(7 downto 0);
signal salida_detector_paridad : STD_LOGIC;
signal flag_fin_interna : STD_LOGIC;
signal flag_especial_interna : STD_LOGIC;
signal not_salida_detector_paridad : STD_LOGIC;
signal reset_biestable_paridad : STD_LOGIC;
signal and_ce_shr : STD_LOGIC;
signal and_ce_ctr4 : STD_LOGIC;
signal reset_flags : STD_LOGIC;

begin

reset_flags <= not CE_flags;
reset_biestable_paridad <= reset_paridad or reset;
and_ce_ctr4 <= flanco_kbclock and CE_contador;
and_ce_shr <= flanco_kbclock and CE_reg_desplazamiento;
not_salida_detector_paridad <= not salida_detector_paridad;
flag_fin_UC <= flag_fin_interna;
flag_especial_UC <= flag_especial_interna;
makecode <= makecode_salida_reg;

detector_flancos_kbclock: detector_flancos port map(
    clk => clk,
    reset => reset,
    entrada => kbclock,
    fa_entrada => open,
    fd_entrada => flanco_kbclock);

reg_desplazamiento: Shift_Register_8bit port map(
    clk => clk,
    reset => reset,
    ce => and_ce_shr,
    D => kbdata,
    Q => makecode_salida_reg);

comprobar_paridad: Odd_Parity_Tester port map(
    clk => clk,
    reset => reset,
    CE => '1',
    D => makecode_salida_reg,
    parity_bit => kbdata,
    odd_parity => salida_detector_paridad);
    
comprobar_flags: Flags_Tester port map(
    clk => clk,
    reset => reset,
    ce => CE_flags_tester,
    flag_fin => flag_fin_interna,
    flag_especial => flag_especial_interna,
    D => makecode_salida_reg);
    
RAM_ASCII_coder: dual_port_dedicated_bram_sync_read port map(
    clk => clk,
    we => '0',
    write_addr => "00000000",
    read_addr => makecode_salida_reg,
    din => "00000000",
    dout => tecla_ASCII);

contador: sctr4 port map (
    clk => clk,
    async_reset => '0',
    sync_reset => reset,
    ce => and_ce_ctr4,
    load => reset_contador,
    dir => '1',
    din => "0111",
    q => open,
    tc => overflow_CTR);
    
RS_flag_fin: rs_flipflop port map (
    clk => clk,
    reset => reset,
    r => reset_flags,
    s => flag_fin_interna,
    q => flag_fin);
    
RS_flag_especial: rs_flipflop port map(
    clk => clk,
    reset => reset,
    r => reset_flags,
    s => flag_especial_interna,
    q => flag_especial);

Biestable_paridad: biestableD port map(
    clk => clk,
    reset => reset_biestable_paridad,
    CE => CE_paridad,
    D => not_salida_detector_paridad, -- not dado que el detector da un 1 si hay paridad impar
    Q => error_paridad);

end Behavioral;