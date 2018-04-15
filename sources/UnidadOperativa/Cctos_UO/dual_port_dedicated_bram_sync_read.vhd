library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity dual_port_dedicated_bram_sync_read is
    Port ( clk : in STD_LOGIC;
           we : in STD_LOGIC;
           write_addr : in STD_LOGIC_VECTOR (7 downto 0);
           read_addr : in STD_LOGIC_VECTOR (7 downto 0);
           din : in STD_LOGIC_VECTOR (7 downto 0);
           dout : out STD_LOGIC_VECTOR (7 downto 0));
end dual_port_dedicated_bram_sync_read;

architecture Behavioral of dual_port_dedicated_bram_sync_read is

type ram_type is array (255 downto 0) of std_logic_vector (7 downto 0);
signal memoria:ram_type:=
(0=>X"00", 1=>X"00", 2=>X"00", 3=>X"00", 4=>X"00", 5=>X"00", 6=>X"29", 7=>X"28", 8=>X"00", 9=>X"00", 10=>X"00", 11=>X"00", 12=>X"00", 13=>X"09", 14=>X"00", 15=>X"00", 
 16=>X"00", 17=>X"00", 18=>X"00", 19=>X"00", 20=>X"00", 21=>X"71", 22=>X"31", 23=>X"00", 24=>X"00", 25=>X"00", 26=>X"7A", 27=>X"73", 28=>X"61", 29=>X"77", 30=>X"32", 31=>X"00", 
 32=>X"00", 33=>X"63", 34=>X"78", 35=>X"64", 36=>X"65", 37=>X"34", 38=>X"33", 39=>X"00", 40=>X"00", 41=>X"20", 42=>X"76", 43=>X"66", 44=>X"74", 45=>X"72", 46=>X"35", 47=>X"00", 
 48=>X"00", 49=>X"6E", 50=>X"62", 51=>X"68", 52=>X"67", 53=>X"79", 54=>X"36", 55=>X"00", 56=>X"00", 57=>X"00", 58=>X"6D", 59=>X"6A", 60=>X"75", 61=>X"37", 62=>X"38",63 =>X"00", 
 64=>X"00", 65=>X"2C", 66=>X"6B", 67=>X"69", 68=>X"6F", 69=>X"30", 70=>X"39", 71=>X"00", 72=>X"00", 73=>X"2E", 74=>X"00", 75=>X"6C", 76=>X"00", 77=>X"70", 78=>X"00", 79=>X"00", 
 80=>X"00", 81=>X"00", 82=>X"00", 83=>X"00", 84=>X"00", 85=>X"00", 86=>X"00", 87=>X"00", 88=>X"00", 89=>X"00", 90=>X"00", 91=>X"00", 92=>X"00", 93=>X"00", 94=>X"00", 95=>X"00", 
 96=>X"00", 97=>X"00", 98=>X"00", 99=>X"00", 100=>X"00", 101=>X"00", 102=>X"00", 103=>X"00", 104=>X"00", 105=>X"00", 106=>X"00", 107=>X"00", 108=>X"00", 109=>X"00", 110=>X"00", 111=>X"00", 
 112=>X"00", 113=>X"00", 114=>X"00", 115=>X"00", 116=>X"00", 117=>X"00", 118=>X"00", 119=>X"00", 120=>X"00", 121=>X"00", 122=>X"00", 123=>X"00", 124=>X"00", 125=>X"00", 126=>X"00", 127=>X"00",
 128=>X"00", 129=>X"00", 130=>X"00", 131=>X"00", 132=>X"00", 133=>X"00", 134=>X"00", 135=>X"00", 136=>X"00", 137=>X"00", 138=>X"00", 139=>X"00", 140=>X"00", 141=>X"00", 142=>X"00", 143=>X"00", 
 144=>X"00", 145=>X"00", 146=>X"00", 147=>X"00", 148=>X"00", 149=>X"00", 150=>X"00", 151=>X"00", 152=>X"00", 153=>X"00", 154=>X"00", 155=>X"00", 156=>X"00", 157=>X"00", 158=>X"00", 159=>X"00", 160=>X"00", 
 161=>X"00", 162=>X"00", 163=>X"00", 164=>X"00", 165=>X"00", 166=>X"00", 167=>X"00", 168=>X"00", 169=>X"00", 170=>X"00", 171=>X"00", 172=>X"00", 173=>X"00", 174=>X"00", 175=>X"00", 176=>X"00", 
 177=>X"00", 178=>X"00", 179=>X"00", 180=>X"00", 181=>X"00", 182=>X"00", 183=>X"00", 184=>X"00", 185=>X"00", 186=>X"00", 187=>X"00", 188=>X"00", 189=>X"00", 190=>X"00", 191=>X"00",192 =>X"00",
 193=>X"00", 194=>X"00", 195=>X"00", 196=>X"00", 197=>X"00", 198=>X"00", 199=>X"00", 200=>X"00", 201=>X"00", 202=>X"00", 203=>X"00", 204=>X"00", 205=>X"00", 206=>X"00", 207=>X"00", 
 208=>X"00", 209=>X"00", 210=>X"00", 211=>X"00", 212=>X"00", 213=>X"00", 214=>X"00", 215=>X"00", 216=>X"00", 217=>X"00", 218=>X"00", 219=>X"00", 220=>X"00", 221=>X"00", 222=>X"00", 223=>X"00", 
 224=>X"00", 225=>X"00", 226=>X"00", 227=>X"00", 228=>X"00", 229=>X"00", 230=>X"00", 231=>X"00", 232=>X"00", 233=>X"00", 234=>X"00", 235=>X"00", 236=>X"00", 237=>X"00", 238=>X"00", 
  239=>X"00", 240=>X"00", 241=>X"00", 242=>X"00", 243=>X"00", 244=>X"00", 245=>X"00", 246=>X"00", 247=>X"00", 248=>X"00", 249=>X"00", 250=>X"00", 251=>X"00", 252=>X"00", 253=>X"00", 254=>X"00",
  255=>X"00");
begin
 process (clk,we,din)
    begin
        if (clk'event and clk='1') then
            if (we='1') then
                memoria(to_integer (unsigned(write_addr)))<=din;
                end if;
                dout<=memoria(to_integer (unsigned(read_addr)));
                end if;
                end process;
 end Behavioral;