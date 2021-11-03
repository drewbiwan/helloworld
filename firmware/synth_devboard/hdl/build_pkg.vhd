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
    constant MAJOR_VERSON_C     : integer := ;
    constant MINOR_VERSON_C     : integer := ;
    constant BUILD_NUMBER_C     : integer := ;
    constant BUILD_TIME_BCD_C   : STD_LOGIC_VECTOR(31 downto 0) := ;
    constant BUILD_TIME_EPOCH_C : STD_LOGIC_VECTOR(31 downto 0) := ;
    constant BRANCH_STRING_C    : string := "";
    constant COMMIT_OID_C       : STD_LOGIC_VECTOR(159 downto 0) := ;
    constant HARDWARE_STRING_C    : string := "";
end package body build_pkg;
