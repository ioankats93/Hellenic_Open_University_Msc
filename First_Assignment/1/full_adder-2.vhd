-- Ioannis Katsikavelas | email : sps040@ac.eap.gr
-- 25/11/18
-- Hellenic Open University
-- Embedded system design and microcontroller applications for the Internet of Things
-- This is my solution for the first part of the first exercise.

--1.1
-- Write dataflow VHDL for 1-bit adder (FA)

--library
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--entity
entity FA is
    Port ( A : in STD_LOGIC;
 	   B : in STD_LOGIC;
 	   Cin : in STD_LOGIC;
 	   S : out STD_LOGIC;
 	   Cout : out STD_LOGIC);
end FA;

architecture gate_level of FA is

begin
  S <= (A XOR B) XOR Cin ;
  Cout <= (A AND B) OR (Cin AND(A XOR B)) ;
end gate_level;
