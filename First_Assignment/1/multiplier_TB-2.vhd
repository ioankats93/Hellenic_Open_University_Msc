-- Ioannis Katsikavelas | email : sps040@ac.eap.gr
-- 25/11/18
-- Hellenic Open University
-- Embedded system design and microcontroller applications for the Internet of Things
-- This is my solution for the fifth part of the first exercise.

--1.5
-- Write VHDL for 4-bit multiplier testbench.
library ieee;
use ieee.std_logic_1164.all;

entity multy_tb is           -- testbench
end entity;

-- Component Declaration for the Unit Under Test (UUT)
architecture foo of multy_tb is
    component multy is
    port (
        x: in  std_logic_vector (3 downto 0);
        y: in  std_logic_vector (3 downto 0);
        p: out std_logic_vector (7 downto 0)
    );
end  component;

--Inputs
  signal x : std_logic_vector (3 downto 0) ;
  signal y : std_logic_vector (3 downto 0) ;
  --Output
  signal p : std_logic_vector (7 downto 0) ;


  begin
--  Unit Under Test (UUT)
     uut: multy port map(
           x => x,
           y => y,
           p => p
           );

-- Stimulus process
  stim_proc: process
  begin
  x <= "0010";
  y <= "0010";

  wait for 10 ns;
  x <= "0011";
  y <= "0010";

  wait for 10 ns;
  x <= "0011";
  y <= "0001";

  wait;
end process;
  end;
