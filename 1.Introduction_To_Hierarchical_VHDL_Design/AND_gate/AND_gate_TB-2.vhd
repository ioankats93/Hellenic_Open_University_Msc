library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.std_logic_unsigned.all;
	use IEEE.std_logic_arith.all;
	use IEEE.std_logic_textio.all;

library work;
use work.all;

entity AND_gate_tb is
end AND_gate_tb;

architecture AND_gate_tb_a of AND_gate_tb is
	component AND_gate is
		port(
			x: in std_logic;
			y: in std_logic;
			z: out std_logic
			);
	end component;
	signal X,y,z:std_logic;
begin
AND_gate_inst:AND_gate
port map(
	x,y,z);
stimulus_proc: process is
begin

x<='0';y<='0';
wait for 12ns;
x<='1';y<='0';
wait for 2ns;
x<='1';y<='1';
wait for 3ns;
x<='0';y<='1';
wait for 7ns;
x<='0';y<='0';
wait for 2ns;
wait;
end process stimulus_proc;
end architecture AND_gate_tb_a;