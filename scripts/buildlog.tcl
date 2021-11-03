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