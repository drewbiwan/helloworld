# buildlog.tcl
# Drew Coker 
# 11/2/2021
# functions for reading and writing to a log file


# attempts to read last valid line of buildlog.txt
# if there are no valid lines or no file, it will generate a new file with header and return 0
proc get_last_buildlog {build_file} {
    if {[file exists $build_file] == 1} {
        set build_log_f [open $build_file r]
        set last_build_number 0
        # run through log file, only store the last
        while { [gets $build_log_f data] >= 0 } {
            set line_list [split $data " "]
            # check for valid log data
            if {[lindex $line_list 0]  == "PRESYNTH:"} { 
                set buildlog_list $line_list
                set last_build_number [lindex $buildlog_list 3]
            } elseif {[lindex $line_list 0]  == "POSTSYNTH:"} {
                set buildlog_list $line_list
                set last_build_number [lindex $buildlog_list 3]
            }
        }
        close $build_log_f
    } else {
        # If no logs were found, start fresh
        set build_log_f [open $build_file w+]
        puts -nonewline "WARNING: No build log found at "
        puts $build_file
        puts "New file will be generated, and builds will start at 1"
        set last_build_number 0
        puts $build_log_f "buildlog.txt"
        puts $build_log_f "DO NOT EDIT"
        puts $build_log_f "This is an automatically generated file. See buildlog.tcl for details"
        set buildlog_list {"LOG:" 0 0 0 0 0 0 0 0}
        close $build_log_f
    }
    return $buildlog_list
}

proc generate_presynth_buildlog {new_build_number major_version minor_version hardware_string} {
    # Get GIT commit oid
    set git_oid_log [open [pwd]/.git/logs/HEAD r]
    while { [gets $git_oid_log data] >= 0 } {
        #run through all lines, only care about last line
        set last_line $data
    }
    close $git_oid_log
    set git_commit_oid_hex "[lindex [split $last_line " "] 1]"

    # Get GIT commit branch
    set git_branch_log [open [pwd]/.git/HEAD r]
    while { [gets $git_branch_log data] >= 0 } {
        #run through all lines, only care about last line
        set last_line $data
    }
    close $git_branch_log
    set git_branch_string [lindex [split $last_line " "] 1]

    # Get time
    set build_time [clock seconds]
    set time_yymmddhh_hex [clock format $build_time -format {%y%m%d%H}]
    set build_time_hex [format %X $build_time]


    #"MAJOR, MINOR, BUILD, DATE, EPOCH, BRANCH, OID, SYNTH?"
    set log_format "PRESYNTH: %s %s %s %s %s %s %s %s"
    set buildlog_list [format $log_format $major_version $minor_version $new_build_number $time_yymmddhh_hex $build_time_hex $git_branch_string $git_commit_oid_hex $hardware_string]

    return $buildlog_list
}

proc append_buildlog {build_file buildlog_list} {
    set build_log_f [open $build_file a]
    foreach val $buildlog_list {
        puts -nonewline $build_log_f [format "%s " $val]
    }
    puts  $build_log_f ""
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
    puts  $build_pkg_f [format "    constant MAJOR_VERSON_C     : integer := %s;" [lindex $buildlog_list 1]]
    puts  $build_pkg_f [format "    constant MINOR_VERSON_C     : integer := %s;" [lindex $buildlog_list 2]]
    puts  $build_pkg_f [format "    constant BUILD_NUMBER_C     : integer := %s;" [lindex $buildlog_list 3]]
    puts  $build_pkg_f [format "    constant BUILD_TIME_BCD_C   : STD_LOGIC_VECTOR(31 downto 0) := x\"%s\";" [lindex $buildlog_list 4]]
    puts  $build_pkg_f [format "    constant BUILD_TIME_EPOCH_C : STD_LOGIC_VECTOR(31 downto 0) := x\"%s\";" [lindex $buildlog_list 5]]
    puts  $build_pkg_f [format "    constant BRANCH_STRING_C    : string := \"%s\";" [lindex $buildlog_list 6]]
    puts  $build_pkg_f [format "    constant COMMIT_OID_C       : STD_LOGIC_VECTOR(159 downto 0) := x\"%s\";" [lindex $buildlog_list 7]]
    puts  $build_pkg_f [format "    constant HARDWARE_STRING_C    : string := \"%s\";" [lindex $buildlog_list 8]]
    puts  $build_pkg_f "end build_pkg;"
    close $build_pkg_f
}

proc print_presynth_log {buildlog_list} {
    puts "  Hardware String:    [lindex $buildlog_list 8]"
    puts "  Major Version:      [lindex $buildlog_list 1]"
    puts "  Minor Version:      [lindex $buildlog_list 2]"
    puts "  Build Number:       [lindex $buildlog_list 3]"
    puts "  Build Time (bcd):   0x[lindex $buildlog_list 4]"
    puts "  Build Time (epoch): 0x[lindex $buildlog_list 5]"
    puts "  Branch String:      [lindex $buildlog_list 6]"
    puts "  Commit OID:         0x[lindex $buildlog_list 7]"
}

proc print_postsynth_log {buildlog_list} {
    puts "  Hardware String:    [lindex $buildlog_list 4]"
    puts "  Major Version:      [lindex $buildlog_list 1]"
    puts "  Minor Version:      [lindex $buildlog_list 2]"
    puts "  Build Number:       [lindex $buildlog_list 3]"
    puts "  Bitstream File:     [lindex $buildlog_list 6]"
    puts "  git tag:            [lindex $buildlog_list 5]"
}
