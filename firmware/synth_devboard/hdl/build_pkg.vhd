----------------
-- build_pkg.vhd
-- DO NOT EDIT
-- This is an automatically generated file. See buildlog.tcl for details
-- Drew Coker
-- November 2021
----------------
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
package build_pkg is
    constant MAJOR_VERSON_C     : integer := 0;
    constant MINOR_VERSON_C     : integer := 0;
    constant BUILD_NUMBER_C     : integer := 10;
    constant BUILD_TIME_BCD_C   : STD_LOGIC_VECTOR(31 downto 0) := 0x21110311;
    constant BUILD_TIME_EPOCH_C : STD_LOGIC_VECTOR(31 downto 0) := 0x6182A3F5;
    constant BRANCH_STRING_C    : string := "refs/heads/main";
    constant COMMIT_OID_C       : STD_LOGIC_VECTOR(159 downto 0) := 0xd960daba73051c9e19087a8764d23c4ae1ab34f1;
    constant HARDWARE_STRING_C    : string := "devboard";
end build_pkg;