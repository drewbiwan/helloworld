# create script 
# Drew Coker 
# 11/2/2021
# This should be run after pulling from repo, or as a clean slate (after running clean.sh in synth directory)

puts ""
puts "-------------"
puts -nonewline "Running Create Script for project in "
puts [pwd]
puts "-------------"

# Load project specific settings
source [pwd]/scripts/project_settings.tcl 

# Load hardware/build specific settings
source $synth_dir/hardware_settings.tcl

# Create Vivado Project
puts ""
puts "-------------"
puts -nonewline "Creating Vivado Project "
puts $project_name
puts -nonewline "Hardware: "
puts $hardware_name
puts -nonewline "FPGA: "
puts $fpga_device
puts -nonewline "Top Level Entity: "
puts $top_level
puts "-------------"

create_project $project_name $synth_dir -part $fpga_device -force

# Read HDL and IP
puts ""
puts "-------------"
puts -nonewline "Reading hardware specific HDL in "
puts $hdl_dir
puts "-------------"

foreach f [glob -nocomplain $hdl_dir/*.vhd] {
    puts -nonewline "    "
    puts $f
    read_vhdl $f
}

puts ""
puts "-------------"
puts -nonewline "Reading hardware specific IP in "
puts $ip_dir
puts "-------------"

foreach f [glob -nocomplain $ip_dir/*.xcix] {
    puts -nonewline "    "
    puts $f  
    read_ip $f
}

puts ""
puts "-------------"
puts -nonewline "Reading shared HDL in "
puts $shared_hdl_dir
puts "-------------"

foreach f [glob -nocomplain $shared_hdl_dir/*.vhd] {
    puts -nonewline "    "
    puts $f  
    read_vhdl $f
}

puts ""
puts "-------------"
puts -nonewline "Reading shared IP in "
puts $shared_ip_dir
puts "-------------"

foreach f [glob -nocomplain $shared_ip_dir/*.xcix] {
    puts -nonewline "    "
    puts $f  
    read_ip $f
}

puts ""
puts "-------------"
puts -nonewline "Reading constraints in "
puts $contraints_dir
puts "-------------"

foreach f [glob -nocomplain $contraints_dir/*.xdc] {
    puts -nonewline "    "
    puts $f  
    read_xdc $f
}

# Set Vivado build properties
set_property target_language VHDL [current_project]
update_compile_order -fileset sources_1
set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true [get_runs impl_1]
set_property coreContainer.enable 1 [current_project]
set_property top $top_level [current_fileset]
set_property default_lib work [current_project]

# Set hardware specific Vivado properties
puts ""
puts "-------------"
puts "Setting hardware specific files"
puts "-------------"
hardware_create 
