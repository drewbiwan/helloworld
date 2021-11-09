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
    constant BUILD_NUMBER_C     : integer := 32;
    constant BUILD_TIME_BCD_C   : STD_LOGIC_VECTOR(31 downto 0) := x"21110911";
    constant BUILD_TIME_EPOCH_C : STD_LOGIC_VECTOR(31 downto 0) := x"618AA15F";
    constant BRANCH_STRING_C    : string := "refs/heads/main";
    constant COMMIT_OID_C       : STD_LOGIC_VECTOR(159 downto 0) := x"7979a188bd104a7857b69799bd3606fc9b8c1dc0";
    constant HARDWARE_STRING_C    : string := "DEV0";
end build_pkg;
