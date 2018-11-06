library IEEE;
   use IEEE.std_logic_1164.all;
   use IEEE.std_logic_unsigned.all;
   use ieee.std_logic_arith.all;


library work;
   use work.all;


entity counter is

       port (  
               clk: in std_logic;
               --rst: in std_logic;
               outp: out std_logic_vector(3 downto 0)
                             );
end counter ;


architecture rtl of counter is

signal clki: std_logic;
--signal reset: std_logic;
signal cnt: std_logic_vector(3 downto 0):="0000";

begin
clki<=clk;
--reset<=rst;

process (clki)
 begin
    --if rst='1' then
	--cnt<=(others=>'0');
    --else
	if (clki'event and clki = '1') then
	   cnt <= cnt + 2;
	end if;
    --end if;
 end process;

outp <= cnt;
end rtl ;


