-- Ioannis Katsikavelas | email : sps040@ac.eap.gr
-- 25/11/18
-- Hellenic Open University
-- Embedded system design and microcontroller applications for the Internet of Things
-- This is my solution for the first part of the second exercise.

--2.1
-- Write VHDL codefor 2 bit upcounter four bit. (D flip flop part)
library ieee;
  use ieee.std_logic_1164.all;

entity dff is --D Flip Flop entity and Architecture
  port(
	clk  : in  std_logic;
        rst : in  std_logic;
        din : in  std_logic;
      	qout  : out std_logic
);
end  dff;

architecture rtl of dff is
  begin
    process (clk, rst)

    begin
      if (rst='0') then
        qout<='0';
      elsif(clk='1' and clk' event) then
          qout <= din ;
    end if;
end process;

end rtl;
