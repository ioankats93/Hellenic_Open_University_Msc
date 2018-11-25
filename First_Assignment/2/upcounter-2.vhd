-- Ioannis Katsikavelas | email : sps040@ac.eap.gr
-- 25/11/18
-- Hellenic Open University
-- Embedded system design and microcontroller applications for the Internet of Things
-- This is my solution for the first part of the second exercise.

--2.1
-- Write VHDL codefor 2 bit upcounter four bit.
library ieee;
  use ieee.std_logic_1164.all;

entity upcounter is
  port (
	clk  : in  std_logic;
        rst : in  std_logic;
        en : in  std_logic;
      	qout  : out std_logic_vector(3 downto 0)
        );
end upcounter;

architecture rtl of upcounter is
component dff is
  port(
	clk  : in  std_logic;
        rst : in  std_logic;
        din : in  std_logic;
      	qout  : out std_logic
);
end component;

signal dffs_out : std_logic_vector(3 downto 0);
signal dffs_in : std_logic_vector(3 downto 0);
signal ands_out : std_logic_vector(2 downto 0);

begin  -- Design gates for data input

    ands_out(0) <= en and dffs_out(0);
    ands_out(1) <= ands_out(0) and dffs_out(1);
    ands_out(2) <= ands_out(1) and dffs_out(2);

    dffs_in(0) <= en xor dffs_out(0);
    dffs_in(1) <= ands_out(0) xor dffs_out(1);
    dffs_in(2) <= ands_out(1) xor dffs_out(2);
    dffs_in(3) <= ands_out(2) xor dffs_out(3);

    qout <= dffs_out;

  dff_0 : --layers of D flip flops
   dff
   port map(
            clk  => clk,
            rst  => rst,
            din  => dffs_in(0),
            qout => dffs_out(0)
   );

  dff_1 :
   dff
   port map(
            clk => clk,
            rst => rst,
            din => dffs_in(1),
            qout=> dffs_out(1)
   );

  dff_2 :
   dff
    port map(
        clk => clk,
        rst => rst,
        din => dffs_in(2),
        qout=> dffs_out(2)
    );


  dff_3 :
   dff
   port map(
            clk => clk,
            rst => rst,
            din => dffs_in(3),
            qout=> dffs_out(3)
   );
end rtl;
