-- Ioannis Katsikavelas | email : sps040@ac.eap.gr
-- 15/01/19
-- Hellenic Open University
-- Embedded system design and microcontroller applications for the Internet of Things
-- This is my solution for the second part of the second exercise.

library IEEE;
   use IEEE.std_logic_1164.all;
   USE ieee.std_logic_arith.all ;
   USE ieee.std_logic_unsigned.all ;

LIBRARY std;
    USE std.textio.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

entity extwo is

--//=======================================================
--//  PORT declarations
--//=======================================================

   PORT (

--	//////////// CLOCK //////////
	CLOCK_50 		: IN STD_LOGIC; --Won't use it thoght

--	//////////// LED //////////  --Won't use it thoght
	LED			:OUT STD_LOGIC_VECTOR(7 downto 0);

--	//////////// GPIO_0, GPIO_0 connect to GPIO Default //////////
	GPIO_2		: INOUT STD_LOGIC_VECTOR(31 downto 0)

);

end extwo ;

architecture rtl of extwo is

signal SEG7DISPLAY : STD_LOGIC_VECTOR(6 downto 0);
signal inp4 : STD_LOGIC_VECTOR(3 downto 0);

begin
--clk <= CLOCK_50 ;
inp4 <= GPIO_2(3 downto 0) ;

process(inp4)
begin
  case inp4 is
    when "0000" => SEG7DISPLAY <= "0111111"; -- sum = '0'
    when "0001" => SEG7DISPLAY <= "0000110"; -- all sums that are '1'
    when "0010" => SEG7DISPLAY <= "0000110";
    when "0100" => SEG7DISPLAY <= "0000110";
    when "1000" => SEG7DISPLAY <= "0000110";

    when "0011" => SEG7DISPLAY <= "1011011"; -- all sums that are '2'
    when "0101" => SEG7DISPLAY <= "1011011";
    when "1001" => SEG7DISPLAY <= "1011011";
    when "1100" => SEG7DISPLAY <= "1011011";
    when "1010" => SEG7DISPLAY <= "1011011";

    when "0111" => SEG7DISPLAY <= "1001111"; -- all sums that are '3'
    when "1011" => SEG7DISPLAY <= "1001111";
    when "1101" => SEG7DISPLAY <= "1001111";

    when "1111" => SEG7DISPLAY <= "1100110" ; -- sum = '4'
    when others => SEG7DISPLAY <= "1111001" ;
  end case ;          -- TODO : When not connected = 'E'
  end process ;

    GPIO_2(4) <= SEG7DISPLAY(5); -- f
    GPIO_2(5) <= SEG7DISPLAY(3); -- d
    GPIO_2(6) <= SEG7DISPLAY(0); -- a
    GPIO_2(7) <= SEG7DISPLAY(6); -- g
    GPIO_2(8) <= SEG7DISPLAY(1); -- b
    GPIO_2(9) <= SEG7DISPLAY(4); -- e
    GPIO_2(10) <= SEG7DISPLAY(2);-- c

  end rtl ;
