-- Ioannis Katsikavelas | email : sps040@ac.eap.gr
-- 15/01/19
-- Hellenic Open University
-- Embedded system design and microcontroller applications for the Internet of Things
-- This is my solution for the first part of the second exercise.

library IEEE;
   use IEEE.std_logic_1164.all;
   USE ieee.std_logic_arith.all ;
   USE ieee.std_logic_unsigned.all ;

LIBRARY std;
    USE std.textio.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

entity exone is
  --//=======================================================
  --//  PORT declarations
  --//=======================================================
  PORT (
  --	//////////// CLOCK //////////
  	CLOCK_50 		: IN STD_LOGIC;

  --	//////////// LED //////////
  	LED			:OUT STD_LOGIC_VECTOR(7 downto 0);

  --	//////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
  	GPIO_2		: INOUT STD_LOGIC_VECTOR(1 downto 0)

  );

end exone ;

architecture rtl of exone is

signal led_s : STD_LOGIC_VECTOR(7 downto 0 );
signal inp, preinp : STD_LOGIC ;
signal state, prestate, changed: integer ;
signal rst, clk : STD_LOGIC ;
signal cnt1: STD_LOGIC_VECTOR( 19 downto 0);
signal cnt2: STD_LOGIC_VECTOR( 19 downto 0);

begin
clk <= CLOCK_50 ;
inp <= GPIO_2(0);
rst <= GPIO_2(1);

process (clk, rst, inp) -- CYCLE
begin
    if rst='1' then  -- Reset
  			cnt1<=(others=>'0');
  			cnt2<=(others=>'0');
  			led_s<=(others=>'0');
        preinp <= '1' ;
        state <= 3 ;
        prestate <= 3 ;
   	elsif (clk'event and clk = '1') then
  	   cnt1 <= cnt1 + 1;
  		if (cnt1=1000000) then
  			cnt2 <= cnt2+1;
  			cnt1 <= (others=>'0');
  		end if;

    if (inp = '1'  and preinp ='1') or (inp = '0' and preinp = '0') then --if the input signal changes then led blibking change

      if changed = 1 then
        prestate <= state ;
      end if;

      if prestate = 3 then --blink LEDA[0:1]
        if (cnt2=0) then
          led_s <= "00000011";
        elsif (cnt2=50) then
          led_s <= "00000000";
        elsif (cnt2=100) then
          cnt2<=(others=>'0');
          state <= 1 ;
        else
          led_s <= led_s;
        end if ;

      elsif prestate = 1 then --blink LEDA[3:4]
        if (cnt2=0) then
          led_s <= "00011000";
        elsif (cnt2=150) then
          led_s <= "00000000";
        elsif (cnt2=300) then
          cnt2<=(others=>'0');
          state <= 2 ;
        else
          led_s <= led_s;
        end if;


      elsif prestate = 2 then --blink LEDA[6:7]
        if (cnt2=0) then
          led_s <= "11000000";
        elsif (cnt2=300) then
          led_s <= "00000000";
        elsif (cnt2=600) then
          cnt2<=(others=>'0');
          state <= 3 ;
        else
          led_s <= led_s;
        end if ;

      end if ;

      changed <= 0 ;  -- signal change flag

   else
     changed <= 1 ;
     preinp <= inp ;
   end if ;

end if ;
end process ;
  LED <= led_s ;
END rtl ;
