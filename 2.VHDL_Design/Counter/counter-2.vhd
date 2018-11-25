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
               outp: out std_logic_vector(5 downto 0)
                             );
end counter ;


architecture rtl of counter is

signal clki: std_logic;
--signal reset: std_logic;
signal cnt: std_logic_vector(5 downto 0):="000011"; -- means store 6 bytes vector, 000011 = 3 as binary  

begin
clki<=clk;
--reset<=rst;

process (clki)
 begin
    --if rst='1' then
	--cnt<=(others=>'3');
    --else
	if (clki'event and clki = '1') then -- 'event means a change in a digital signal'
	   cnt <= cnt + 1;
		if (cnt=53) then cnt<=conv_std_logic_vector(3, 6); 
		end if;


	end if;
    --end if;
 end process;

outp <= cnt;
end rtl ;


