  -- Ioannis Katsikavelas | email : sps040@ac.eap.gr
-- 25/11/18
-- Hellenic Open University
-- Embedded system design and microcontroller applications for the Internet of Things
-- This is my solution for the second part of the third exercise.

--3.2
-- Write VHDL test bench code for the given fsm model.
library ieee;
use ieee.std_logic_1164.all;

entity fsm_tb is
end fsm_tb;

architecture fsm_arch_tb of fsm_tb is
component fsm is
  port(
        clk, reset : in std_logic;
        level : in std_logic;
        tick: out std_logic
);
end component;

signal clk: std_logic :='1';
signal reset: std_logic :='0';
signal level: std_logic :='0';
signal  tick: std_logic ;
--type stateFsm_type is (s1, s2 , s3 ); -- 3 states are required
--signal stateFsm_reg, stateFsm_next : stateFsm_type ;

constant clk_period : time := 1 ns;

begin

cnt_inst : fsm
  port map (
      clk, reset, level,  tick
  );

clk_gen: process is
begin
      clk <= '1';
      wait for clk_period/2;  --for 0.5 ns signal is '0'.
      clk <= '0';
      wait for clk_period/2;  --for next 0.5 ns signal is '1'.
end process clk_gen;

trig: process is
begin

          wait for clk_period;
                 level<= '1';
      	  wait for clk_period;
      	         reset <= '0' ;
                 level <= '1' ;
      	  wait for clk_period;
                 level <= '1' ;
      	  wait for clk_period;
                 level <= '1' ;
      	  wait for clk_period;
                 reset <= '1' ;
      	  wait for clk_period;
                 reset <= '0' ;
      	         level <= '1' ;
      	  wait for clk_period;
                 level <= '1' ;
      	  wait for clk_period;
                 level <= '1' ;
      	  wait for clk_period;
                 level <= '1' ;


         wait;
end process trig;

end architecture fsm_arch_tb;
