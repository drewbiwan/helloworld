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

# Compile
launch_runs synth_1 -jobs $num_jobs
wait_on_run synth_1
launch_runs impl_1 -jobs $num_jobs
wait_on_run impl_1
launch_runs impl_1 -to_step write_bitstream  -jobs $num_jobs
wait_on_run impl_1
