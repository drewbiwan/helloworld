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
    constant BUILD_NUMBER_C     : integer := 31;
    constant BUILD_TIME_BCD_C   : STD_LOGIC_VECTOR(31 downto 0) := x"21110910";
    constant BUILD_TIME_EPOCH_C : STD_LOGIC_VECTOR(31 downto 0) := x"618A954D";
    constant BRANCH_STRING_C    : string := "refs/heads/main";
    constant COMMIT_OID_C       : STD_LOGIC_VECTOR(159 downto 0) := x"2aea67f4a9f60d655acf26753774087b05cf1c96";
    constant HARDWARE_STRING_C    : string := "DEV0";
end build_pkg;
