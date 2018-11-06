library IEEE;
   use IEEE.std_logic_1164.all;
   use IEEE.std_logic_unsigned.all;
   use ieee.std_logic_arith.all;

library work;
   use work.all;

entity fsm_tb is
end fsm_tb;

architecture fsm_arch_tb of fsm_tb is
component fsm is                                                    
       port (  
               clk: in std_logic;
               rst: in std_logic;
               x: in std_logic;
               sel: in std_logic;
               outp1: out std_logic_vector(5 downto 0);
               outp2: out std_logic_vector(5 downto 0)
                             );                                      
end component;                                                         

signal clock: std_logic :='1';
signal rst: std_logic :='1';
signal x: std_logic :='1';
signal sel: std_logic :='1';
signal o1: std_logic_vector(5 downto 0);
signal o2: std_logic_vector(5 downto 0);
-- constant num_cycles : integer := 320;
constant clk_period : time := 10 ns;

begin   

cnt_inst: fsm
      port map (                                                            
                clock, rst, x, sel, o1, o2  );

clk_gen: process is
begin
        clock <= '1';
        wait for clk_period/2;  --for 0.5 ns signal is '0'.
        clock <= '0';
        wait for clk_period/2;  --for next 0.5 ns signal is '1'.
end process clk_gen;

trig: process is
begin
         rst<= '1';
         sel<= '0';
         x<= '0';
         wait for clk_period*10;
         rst <= '0';
         sel<= '1';
         x <= '1';
	 wait for clk_period;
         x <= '0';
         wait for clk_period*10;
         x <= '1';
         sel<= '1';
	 wait for clk_period;
         x <= '0';
         wait for clk_period*10;
         x <= '1';
         sel<= '1';
	 wait for clk_period;
         x <= '0';
         wait for clk_period*10;
         x <= '1';
         sel<= '0';
	 wait for clk_period;
         x <= '0';
         wait for clk_period*10;
         x <= '1';
         sel<= '1';
	 wait for clk_period;
         x <= '0';
         wait for clk_period*10;
         x <= '1';
         sel<= '0';
	 wait for clk_period;
         x <= '0';
         wait for clk_period*10;
         x <= '1';
         sel<= '0';
	 wait for clk_period;
         x <= '0';
         wait for clk_period*10;
         x <= '1';
         sel<= '0';
	 wait for clk_period;
         x <= '0';
         wait for clk_period*10;
         x <= '1';
         sel<= '0';
	 wait for clk_period;
         x <= '0';
         wait for clk_period*10;
         x <= '1';
         sel<= '1';
	 wait for clk_period;
         x <= '0';
	 wait;
end process trig;

--res: process is
--begin
	--rst<='0';
	--wait for 2*clk_period;
	--rst<='1';
	--wait for 2*clk_period;
	--rst<='0';
	--wait;
--end process res;

end architecture fsm_arch_tb;

