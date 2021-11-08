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
    constant BUILD_NUMBER_C     : integer := 28;
    constant BUILD_TIME_BCD_C   : STD_LOGIC_VECTOR(31 downto 0) := x"21110810";
    constant BUILD_TIME_EPOCH_C : STD_LOGIC_VECTOR(31 downto 0) := x"61893C4F";
    constant BRANCH_STRING_C    : string := "refs/heads/main";
    constant COMMIT_OID_C       : STD_LOGIC_VECTOR(159 downto 0) := x"79d52caa253be36f35501f8470ef368a61de275b";
    constant HARDWARE_STRING_C    : string := "DEV0";
end build_pkg;
