-- Ioannis Katsikavelas | email : sps040@ac.eap.gr
-- 25/11/18
-- Hellenic Open University
-- Embedded system design and microcontroller applications for the Internet of Things
-- This is my solution for the first part of the third exercise.

--3.1
-- Write VHDL code for the given fsm model.
library ieee;
use ieee.std_logic_1164.all;

entity fsm is
    port(
            clk, reset : in std_logic;
            level : in std_logic;
            tick: out std_logic
);
end fsm;

architecture rtl of fsm is

    type stateFsm_type is (s1, s2, s3); -- 3 states are required
    signal stateFsm_reg, stateFsm_next : stateFsm_type;

begin
    process(clk, reset)
    begin
        if (reset = '1') then -- go to state zero if reset
            stateFsm_reg <= s1;
        elsif (clk'event and clk = '1') then -- otherwise update the states
            stateFsm_reg <= stateFsm_next;
        else
            null;
        end if;
    end process;

    process(stateFsm_reg, level)
begin
        -- store current state as next
        stateFsm_next <= stateFsm_reg; -- required: when no case statement is satisfied

        tick <= '0';
        case stateFsm_reg is
            when s1 => -- if state is zero,
                if level = '1' then  -- and level is 1
                    stateFsm_next <= s2; -- then go to state s2.
                end if;
            when s2 =>
                --tick <= '1'; -- set the tick to 1.
                if level = '1' then -- if level is 1,
                    stateFsm_next <= s3; --go to state s3,
                else
                    stateFsm_next <= s1; -- else go to state s1.
                end if;
            when s3 =>
                if level = '0' then -- if level is 0,
                    stateFsm_next <= s1; -- then go to state s1.
                end if;
        end case;
    end process;
end rtl;
