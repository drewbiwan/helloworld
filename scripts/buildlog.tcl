# buildlog.tcl
# Drew Coker 
# 11/2/2021
# functions for reading and writing to a log file


# attempts to read last valid line of buildlog.txt
# if there are no valid lines or no file, it will generate a new file with header and return 0
proc get_last_buildlog {build_file} {
    set build_log_f [open $build_file r]
    set last_build_number 0
    # run through log file, only store the last
    while { [gets $build_log_f data] >= 0 } {
        set line_list [split $data " "]
        # check for valid log data
        if {[lindex $line_list 0]  == "LOG:"} { 
            set buildlog_list $line_list
            set last_build_number [lindex $buildlog_list 3]
        }
    }
    close $build_log_f

    # If no logs were found, start fresh
    if {$last_build_number == 0} {
        set build_log_f [open $build_file w+]
        puts -nonewline "WARNING: No build log found at "
        puts $build_file
        puts "New file will be generated, and builds will start at 1"
        set last_build_number 0
        puts $build_log_f "MAJOR MINOR BUILD DATE EPOCH BRANCH OID SYNTH?"
        set buildlog_list {"LOG:" 0 0 0 0 0 0 0 0}
        close $build_log_f
    }
    return $buildlog_list
}

proc append_buildlog_presynth {build_file buildlog_list} {
    set build_log_f [open $build_file a]
    puts  $build_log_f "\n"
    foreach val $buildlog_list {
        puts -nonewline $build_log_f [format "%s " $val]
    }
    close $build_log_f
}

proc append_buildlog_postsynth {build_file bitstream_string} {
    puts $build_file
    puts $bitstream_string
    set build_log_f [open $build_file a]
    puts -nonewline $build_log_f $bitstream_string
    close $build_log_f
    return 1
}

proc generate_build_pkg {build_pkg_file buildlog_list} {
    set build_pkg_f [open $build_pkg_file w+]
    puts  $build_pkg_f "----------------"
    puts  $build_pkg_f "-- build_pkg.vhd"
    puts  $build_pkg_f "-- DO NOT EDIT"
    puts  $build_pkg_f "-- This is an automatically generated file. See buildlog.tcl for details"
    puts  $build_pkg_f "-- Drew Coker"
    puts  $build_pkg_f "-- November 2021"
    puts  $build_pkg_f "----------------"
    puts  $build_pkg_f "library ieee;"
    puts  $build_pkg_f "use ieee.numeric_std.all;"
    puts  $build_pkg_f "use ieee.std_logic_1164.all;"
    puts  $build_pkg_f "package build_pkg is"
    puts  $build_pkg_f [format "    constant MAJOR_VERSON_C     : integer := %s;" [lindex buildlog_list 1]]
    puts  $build_pkg_f [format "    constant MINOR_VERSON_C     : integer := %s;" [lindex buildlog_list 2]]
    puts  $build_pkg_f [format "    constant BUILD_NUMBER_C     : integer := %s;" [lindex buildlog_list 3]]
    puts  $build_pkg_f [format "    constant BUILD_TIME_BCD_C   : STD_LOGIC_VECTOR(31 downto 0) := %s;" [lindex buildlog_list 4]]
    puts  $build_pkg_f [format "    constant BUILD_TIME_EPOCH_C : STD_LOGIC_VECTOR(31 downto 0) := %s;" [lindex buildlog_list 5]]
    puts  $build_pkg_f [format "    constant BRANCH_STRING_C    : string := \"%s\";" [lindex buildlog_list 6]]
    puts  $build_pkg_f [format "    constant COMMIT_OID_C       : STD_LOGIC_VECTOR(159 downto 0) := %s;" [lindex buildlog_list 7]]
    puts  $build_pkg_f [format "    constant HARDWARE_STRING_C    : string := \"%s\";" [lindex buildlog_list 8]]
    puts  $build_pkg_f "end package body build_pkg;"
    close $build_pkg_f
}
