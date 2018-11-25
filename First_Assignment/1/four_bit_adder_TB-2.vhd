-- Ioannis Katsikavelas | email : sps040@ac.eap.gr
-- 25/11/18
-- Hellenic Open University
-- Embedded system design and microcontroller applications for the Internet of Things
-- This is my solution for the third part of the first exercise.

--1.3
-- Write VHDL code for 4-bit adder testbench for simulation.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Tb_Ripple_Adder is
end Tb_Ripple_Adder;

architecture behavior of Tb_Ripple_Adder is

-- Component Declaration for the Unit Under Test (UUT)

component Ripple_Adder
port(
      A : in std_logic_vector(3 downto 0);
      B : in std_logic_vector(3 downto 0);
      Cin : in std_logic;
      S : out std_logic_vector(3 downto 0);
      Cout : out std_logic
      );
end component;

--Inputs
signal A : std_logic_vector(3 downto 0) := (others => '0');
signal B : std_logic_vector(3 downto 0) := (others => '0');
signal Cin : std_logic := '0';

--Outputs
signal S : std_logic_vector(3 downto 0);
signal Cout : std_logic;

begin

--  Unit Under Test (UUT)
uut: Ripple_Adder port  map (
  A => A,
  B => B,
  Cin => Cin,
  S => S,
  Cout => Cout
);

-- Stimulus process
stim_proc: process
begin
wait for 10 ns;
A <= "0001";
B <= "0010";

wait for 10 ns;
A <= "0111";
B <= "0001";

wait for 10 ns;
A <= "0110";
B <= "0011";

wait;

end process;

END;
