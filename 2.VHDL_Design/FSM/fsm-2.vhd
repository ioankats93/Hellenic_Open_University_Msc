library IEEE;
   use IEEE.std_logic_1164.all;
   use IEEE.std_logic_unsigned.all;
   use ieee.std_logic_arith.all;


library work;
   use work.all;


entity fsm is

       port (  
               clk: in std_logic;
               rst: in std_logic;
               x: in std_logic;
               sel: in std_logic;
               outp1: out std_logic_vector(5 downto 0);
               outp2: out std_logic_vector(5 downto 0)
                             );
end fsm ;


architecture rtl of fsm is

signal clki: std_logic;
signal reset: std_logic;
signal xi: std_logic;
signal seli: std_logic;
signal cnt1: std_logic_vector(5 downto 0):="000000";
signal cnt2: std_logic_vector(5 downto 0):="000000";
signal cur_state, nxt_state: std_logic_vector(1 downto 0):="00";

begin
clki<=clk;
xi<=x;
seli<=sel;
reset<=rst;

process (clki, reset)
 begin
    if reset='1' then
	cnt1<=(others=>'0');
	cnt2<=(others=>'0');
	cur_state<=(others=>'0');
    else
	if (clki'event and clki = '1') then
		cur_state<=nxt_state;
		case cur_state is
		when "10" =>
			cnt1<=cnt1+1;
			cnt2<=cnt2;
		when "11" =>
			cnt1<=cnt1;
			cnt2<=cnt2+1;
		when others =>
			cnt1<=cnt1;
			cnt2<=cnt2;
		end case;
	end if;
    end if;
 end process;


ctrl_fsm: process (xi, seli, cur_state)
 begin
	case cur_state is
	when "00" =>
		if (xi='0') then
			nxt_state <= "00";
		else
			nxt_state <= "01";
		end if;
	when "01" =>
		if (seli='1') then
			nxt_state <= "10";
		else
			nxt_state <= "11";
		end if;
	when "10" =>
		nxt_state <= "00";
	when "11" =>
		nxt_state <= "00";
	when others =>
		nxt_state <= "00";
        end case;
	 
 end process;

outp1 <= cnt1;
outp2 <= cnt2;
end rtl ;


