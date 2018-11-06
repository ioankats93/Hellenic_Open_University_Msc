library IEEE;
   use IEEE.std_logic_1164.all;
   use IEEE.std_logic_unsigned.all;
   use ieee.std_logic_arith.all;

library work;
   use work.all;

entity cnt_tb is
end cnt_tb;

architecture cnt_tb_a of cnt_tb is
component counter is                                                    
       port (  
               clk: in std_logic;
               --rst: in std_logic;
               outp: out std_logic_vector(3 downto 0)
                             );                                      
end component;                                                         

signal clock: std_logic :='1';
--signal rst: std_logic :='1';
signal o: std_logic_vector(3 downto 0);
-- constant num_cycles : integer := 320;
constant clk_period : time := 10 ns;

begin   

cnt_inst: counter
      port map (                                                            
                --clock, rst, o  );
                clock, o  );

clk_gen: process is
begin
        clock <= '0';
        wait for clk_period/2;  --for 0.5 ns signal is '0'.
        clock <= '1';
        wait for clk_period/2;  --for next 0.5 ns signal is '1'.
end process clk_gen;

--res: process is
--begin
	--rst<='0';
	--wait for 2*clk_period;
	--rst<='1';
	--wait for 2*clk_period;
	--rst<='0';
	--wait;
--end process res;

end architecture cnt_tb_a;

