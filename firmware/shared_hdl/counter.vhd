-----------------------------
-- counter.vhd
-- Author: Drew Coker
-- Date: November 2021
-----------------------------

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity counter is
    port 
    (
        clk_p   : in std_logic;
        count_p  : out std_logic_vector(7 downto 0)
    );
end counter;

architecture bhv of counter is
    signal counter_s    : unsigned(7 downto 0);

begin
    count_p  <= counter_s(3 downto 0);

    process(clk_p)
    begin
        if rising_edge(clk_p) then
            counter_s <= counter_s + 1;
        end if;
    end process;

end bhv;