-- Ioannis Katsikavelas | email : sps040@ac.eap.gr
-- 25/11/18
-- Hellenic Open University
-- Embedded system design and microcontroller applications for the Internet of Things
-- This is my solution for the second part of the second exercise.

--2.2
-- Write VHDL codefor 2 bit upcounter four bit. Test bench
library ieee;
use ieee.std_logic_1164.all;

entity counter_tb is
end counter_tb;

architecture behavior of counter_tb is
    component upcounter
    port(
         clk : in  std_logic;
         rst : in  std_logic;
         en : in  std_logic;
         qout : out  std_logic_vector(3 downto 0)
        );
    end component;

   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal en : std_logic := '0';

   signal qout : std_logic_vector(3 downto 0);

begin

   uut: upcounter port map(
        clk => clk,
         rst => rst,
         en => en,
         qout => qout);

    clk <= not clk after 5 ns;

    rst <= '0',
             '1' after 30 ns;

    en  <= '0',
             '1' after 40 ns,
             '0' after 70 ns,
             '1' after 90 ns;

end;
