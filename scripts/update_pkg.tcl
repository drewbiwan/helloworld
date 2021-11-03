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

# Load buildlog functions
source [pwd]/scripts/buildlog.tcl 

puts ""
puts "--------------------------"
puts -nonewline "Updating packages for "
puts $hardware_name
puts "--------------------------"

puts ""
puts "-------------"
puts "Reading build information"
puts "-------------"

puts -nonewline "Major version: "
puts $major_version
puts -nonewline "Minor version: "
puts $minor_version

# look at build log to determine new build number
set old_buildlog_list [get_last_buildlog $build_dir/buildlog.txt]
set last_build_number [lindex $old_buildlog_list 3]
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
set build_time_hex [format 0x%X $build_time]

puts "Current time:"
puts "  YYMMDDHH bcd:    $time_yymmddhh_hex"
puts "  Epoch:           $build_time_hex"
puts "  Readable(local): [clock format $build_time -format "%A %B %d, %I:%M:%S%p"]"

puts ""
puts "-------------"
puts "Writing to log"
puts "-------------"
#"MAJOR, MINOR, BUILD, DATE, EPOCH, BRANCH, OID, SYNTH?"
set log_format "PRESYNTH: %s %s %s %s %s %s %s %s"
set buildlog_list [format $log_format $major_version $minor_version $new_build_number $time_yymmddhh_hex $build_time_hex $git_branch_string $git_commit_oid_hex $hardware_name]
append_buildlog $build_dir/buildlog.txt $buildlog_list

puts ""
puts "-------------"
puts -nonewline "Generating new pkg file in "
puts $hdl_dir/build_pkg.vhd
puts "-------------"
generate_build_pkg $hdl_dir/build_pkg.vhd $buildlog_list

puts ""
puts "-------------"
puts "DONE"
puts "-------------"
puts ""
puts ""
puts ""
puts ""