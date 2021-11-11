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
    constant CONFIGURATION_NAME_C   : string := "devboard";
    constant MAJOR_VERSON_C         : integer := 0;
    constant MINOR_VERSON_C         : integer := 0;
    constant BUILD_NUMBER_C         : integer := 12;
    constant BUILD_TIME_BCD_C       : STD_LOGIC_VECTOR(31 downto 0) := x"21111110";
    constant BUILD_TIME_EPOCH_C     : STD_LOGIC_VECTOR(31 downto 0) := x"618D368E";
    constant BRANCH_STRING_C        : string := "refs/heads/main";
    constant COMMIT_OID_C           : STD_LOGIC_VECTOR(159 downto 0) := x"90f07cfa9f8a8289430f08bc44689cb8fc495f54";
    constant CONFIGURATION_STRING_C : string := "DEV0";
end build_pkg;
