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
        set buildlog_list [split $data ","]
        # check for valid log data
        if {[lindex $buildlog_list 0]  == "LOG"} { 
            set last_build_number [lindex $buildlog_list 3]
        }
    }

    # If no logs were found, start fresh
    if {$last_build_number == 0} {
        puts -nonewline "WARNING: No build log found at "
        puts $build_dir/buildlog.txt
        puts "New file will be generated, and builds will start at 1"
        set last_build_number 0
        puts $build_log_f "MAJOR, MINOR, BUILD, DATE, EPOCH, BRANCH, OID, SYNTH?"
    }
    close $build_log_f
    return $buildlog_list
}

proc append_buildlog {build_file buildlog_list} {
    set build_log_f [open $build_file a]
    #puts  $build_log_f "\n"
    foreach val $buildlog_list {
        puts -nonewline $build_log_f [format "%s," $val]
    }
    close $build_log_f
}

proc append_buildlog_synthcomplete {build_file bitstream_string} {
    puts $build_file
    puts $bitstream_string
    set build_log_f [open $build_file a]
    puts $build_log_f $bitstream_string
    close $build_log_f
    return 1
}