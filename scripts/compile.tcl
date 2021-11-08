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
set old_buildlog_list [get_last_buildlog $build_dir/buildlog.txt]

# Update package file, and append log file with new info
set old_build_number [lindex $old_buildlog_list 3]
set new_build_number [expr $old_build_number + 1]
set presynth_buildlog_list [generate_presynth_buildlog $new_build_number $major_version $minor_version $hardware_string]

# Append log with "PRESYNTH:" message
puts "-------------"
puts "Pre-Synthesis Log information:"
print_presynth_log $presynth_buildlog_list
puts "-------------"

# Update build log and build pkg files
puts "-------------"
puts "Appending Log and creating build_pkg.vhd:"
append_buildlog $build_dir/buildlog.txt $presynth_buildlog_list
generate_build_pkg $hdl_dir/build_pkg.vhd $presynth_buildlog_list
read_vhdl $hdl_dir/build_pkg.vhd
puts "-------------"

# Open vivado project
puts "-------------"
puts "Opening Vivado Project in $synth_dir"
open_project $synth_dir/$project_name.xpr
puts "-------------"

# Save current BD as a tcl script
puts "-------------"
puts "Updating block diagram tcl script at $bd_script"
puts "BD at $synth_dir/$project_name.srcs/sources_1/bd/$bd_name/$bd_name.bd"
open_bd_design $synth_dir/$project_name.srcs/sources_1/bd/$bd_name/$bd_name.bd
write_bd_tcl -force $bd_script
puts "-------------"

# Auto commit
exec git add $firmware_dir
exec git commit -m "PRE-SYNTHESIS AUTOCOMMIT. Ran from compile.tcl."

puts "-------------"
puts "Synthesis"
puts "-------------"
# Compile
reset_run synth_1
launch_runs synth_1 -jobs $num_jobs
wait_on_run synth_1
puts "-------------"
puts "Implementation"
puts "-------------"
launch_runs impl_1 -jobs $num_jobs
wait_on_run impl_1
puts "-------------"
puts "Creating bitstreams"
puts "-------------"
launch_runs impl_1 -to_step write_bitstream  -jobs $num_jobs
wait_on_run impl_1

# Move bitstream
set bitstream_file_format "%s_%s_v%02up%02ub%04"
set bitstream_string [format "%s_%s_%s_%s_%s" $project_name $hardware_name $major_version $minor_version $new_build_number]
set bitstream_file $synth_dir/$project_name.runs/impl_1/$top_level

puts "-------------"
puts "Moving bitstreams"
puts "From $bitstream_file.bin to $build_dir/$bitstream_string.bin"
puts "From $bitstream_file.bit to $build_dir/$bitstream_string.bit"

file copy $bitstream_file.bin $build_dir/$bitstream_string.bin
file copy $bitstream_file.bit $build_dir/$bitstream_string.bit
puts "-------------"

# Update log
set tag_string [format "v%s.%s.%s" $major_version $minor_version $new_build_number]
set log_format "POSTSYNTH: %s %s %s %s %s %s"
set postsynth_buildlog_list [format $log_format $major_version $minor_version $new_build_number $hardware_string $tag_string $bitstream_string]
append_buildlog $build_dir/buildlog.txt $postsynth_buildlog_list

puts "-------------"
puts "Post-Synthesis Log information:"
print_postsynth_log $postsynth_buildlog_list
puts "-------------"

# Commit to git
# exec git diff
exec git add $firmware_dir
exec git commit --amend -m "POST-SYNTHESIS AUTOCOMMIT. Ran from compile.tcl."
exec git tag $tag_string
#exec "git --help"
#exec "git commit -m \"AUTOCOMMIT. Run from compile.tcl, after synthesis\""
