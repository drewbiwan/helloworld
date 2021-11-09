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
    constant CONFIGURATION_NAME_C   : string := "rev1board";
    constant MAJOR_VERSON_C         : integer := 0;
    constant MINOR_VERSON_C         : integer := 0;
    constant BUILD_NUMBER_C         : integer := 2;
    constant BUILD_TIME_BCD_C       : STD_LOGIC_VECTOR(31 downto 0) := x"21110916";
    constant BUILD_TIME_EPOCH_C     : STD_LOGIC_VECTOR(31 downto 0) := x"618AEA65";
    constant BRANCH_STRING_C        : string := "refs/heads/main";
    constant COMMIT_OID_C           : STD_LOGIC_VECTOR(159 downto 0) := x"dd717ba4aaf802e8a858f39b30362d2317b0384a";
    constant CONFIGURATION_STRING_C : string := "TEMP";
end build_pkg;
