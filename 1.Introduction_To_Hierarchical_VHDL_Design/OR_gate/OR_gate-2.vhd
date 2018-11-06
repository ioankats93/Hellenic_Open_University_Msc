library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.std_logic_unsigned.all;
	use IEEE.std_logic_arith.all;
	use IEEE.std_logic_textio.all;

library work;
use work.all;

entity OR_gate is

	port(
		x: in std_logic;
		y: in std_logic;
		z: out std_logic
		);
end OR_gate;

architecture rtl of OR_gate is

begin
process(x,y)
begin 
z<= x OR y;
end process ;

end rtl;