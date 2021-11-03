-----------------------------
-- Top level 
-- Author: Drew Coker
-- Date: November 2021
-----------------------------

library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

use work.build_pkg.vhd;

entity top is
    port 
    (
        clk_p   : in std_logic;
        leds_p  : out std_logic_vector(3 downto 0)
    );
end top;

architecture bhv of top is
    signal clk_s        : std_logic;
    signal counter_s    : unsigned(7 downto 0);

begin

    clk_s <= clk_p;
    leds_p  <= std_logic_vector(counter_s(3 downto 0));

    process(clk_s)
    begin
        if rising_edge(clk_s) then
            counter_s <= counter_s + 1;
        end if;
    end process;

end bhv;