# update_pkg.tcl
# Drew Coker 
# 11/2/2021
# Updates pkg files that are read by the upcoming vivado compile
# Prereqs:
#   Vivado project should have already been created by create.tcl
#   all changes should be staged

# Load Project specific settings
source [pwd]/scripts/project_settings.tcl

# Load hardware specific settings
source $synth_dir/hardware_settings.tcl

puts ""
puts "-------------"
puts -nonewline "Updating packages for "
puts $hardware_name
puts "-------------"

puts ""
puts "-------------"
puts "Reading build information"
puts "-------------"

puts -nonewline "Major version: "
puts $major_version
puts -nonewline "Minor version: "
puts $minor_version

# look at build log to determine new build number
set build_log_f [open $build_dir/buildlog.txt a+]
set last_line ""
while { [gets $build_log_f data] >= 0 } {
    #run through all lines, only care about last line
    set last_line $data
}
set ll_split [split $last_line ","]
if {[lindex $ll_split 0] == "LOG"} {
    set last_build_number [lindex [split $last_line ","] 3]
} else {
    puts -nonewline "WARNING: No build log found at "
    puts $build_dir/buildlog.txt
    puts "New file will be generated, and builds will start at 1"
    set last_build_number 0
    puts $build_log_f "MAJOR, MINOR, BUILD, DATE, EPOCH, BRANCH, OID, SYNTH?"
}
set new_build_number [expr $last_build_number + 1]

puts -nonewline "Last build number: "
puts $last_build_number
puts -nonewline "New build number: "
puts $new_build_number

# Get GIT commit oid
set git_oid_log [open [pwd]/.git/logs/HEAD r]
while { [gets $git_oid_log data] >= 0 } {
    #run through all lines, only care about last line
    set last_line $data
}
close $git_oid_log
set git_commit_oid_hex "0x"
append git_commit_oid_hex [lindex [split $last_line " "] 1]

puts -nonewline "Commit ID: "
puts $git_commit_oid_hex

# Get GIT commit branch
set git_branch_log [open [pwd]/.git/HEAD r]
while { [gets $git_branch_log data] >= 0 } {
    #run through all lines, only care about last line
    set last_line $data
}
close $git_branch_log
set git_branch_string [lindex [split $last_line " "] 1]

puts -nonewline "HEAD branch: "
puts $git_branch_string

# Get time
set build_time [clock seconds]
set time_yymmddhh_hex [clock format $build_time -format {0x%y%m%d%H}]

puts -nonewline "Current time (YYMMDDHH bcd): "
puts $time_yymmddhh_hex

set build_time_hex [format 0x%X $build_time]
puts -nonewline "Current time (Epoch): "
puts $build_time_hex

puts ""
puts "-------------"
puts "Writing to log"
puts "-------------"
#"MAJOR, MINOR, BUILD, DATE, EPOCH, BRANCH, OID, SYNTH?"
set log_format "LOG,%s,%s,%s,%s,%s,%s,%s,%s"
puts $build_log_f [format $log_format $major_version $minor_version $new_build_number $time_yymmddhh_hex $build_time_hex $git_branch_string $git_commit_oid_hex "NO"]
close $build_log_f

puts ""
puts "-------------"
puts "DONE"
puts "-------------"
puts ""
puts ""
puts ""
puts ""