# compile script for vivado
# Drew Coker 
# 11/2/2021
# This synthesizes, implements, and generates bitstreams. 
# Prereqs:
#   Vivado project should have already been created by create.tcl
#   all files should be committed, and update_pkg.tcl should have been run

puts ""
puts "-------------"
puts -nonewline "Running Compile Script for project in "
puts [pwd]
puts "-------------"

# Load project specific settings
source [pwd]/scripts/project_settings.tcl 

# Load hardware/build specific settings
source $synth_dir/hardware_settings.tcl

# Load buildlog functions
source [pwd]/scripts/buildlog.tcl 

# Pull build information from log
set buildlog_list [get_last_buildlog $build_dir/buildlog.txt]
set major_version [lindex $buildlog_list 1]
set minor_version [lindex $buildlog_list 2]
set current_buildnumber [lindex $buildlog_list 3]

# TEMP UPDATE LOG
#append_buildlog $build_dir/buildlog.txt $buildlog_list

# Open project
open_project $synth_dir/$project_name.xpr

# Compile
#reset_run synth_1
#launch_runs synth_1 -jobs $num_jobs
#wait_on_run synth_1
#launch_runs impl_1 -jobs $num_jobs
#wait_on_run impl_1
#launch_runs impl_1 -to_step write_bitstream  -jobs $num_jobs
#wait_on_run impl_1

# Move bitstream
set bitstream_file_format "%s_%s_v%02up%02ub%04"
set bitstream_string [format "%s_%s_%s_%s_%s.bin" $project_name $hardware_name $major_version $minor_version $current_buildnumber]

# Update log
append_buildlog_synthcomplete $build_dir/buildlog.txt $bitstream_string
