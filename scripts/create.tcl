# create script for vivado
puts "-------------"
puts -nonewline "Running Create Script in "
puts $[pwd]
puts "-------------"

# Project settings

# Directory structure
set synth_dir [pwd]/firmware/[lindex $argv 0]
set contraints_dir $synth_dir/constraints
set hdl_dir $synth_dir/hdl
set ip_dir $synth_dir/ip
set firmware_dir [pwd]/firmware
set shared_hdl_dir $firmware_dir/shared_hdl
set shared_ip_dir $firmware_dir/shared_ip

# Load Project specific settings
source $synth_dir/hardware_settings.tcl

# Load hardware specific settings
source [pwd]/scripts/project_settings.tcl

# Create Vivado Project
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
puts "-------------"
puts -nonewline "Reading hardware specific HDL in "
puts $hdl_dir
puts "-------------"

foreach f [glob -nocomplain $hdl_dir/*.vhd] {
    puts -nonewline "    "
    puts $f
    read_vhdl $f
}

puts "-------------"
puts -nonewline "Reading hardware specific IP in "
puts $ip_dir
puts "-------------"

foreach f [glob -nocomplain $ip_dir/*.xcix] {
    puts -nonewline "    "
    puts $f  
    read_ip $f
}

puts "-------------"
puts -nonewline "Reading shared HDL in "
puts $shared_hdl_dir
puts "-------------"

foreach f [glob -nocomplain $shared_hdl_dir/*.vhd] {
    puts -nonewline "    "
    puts $f  
    read_vhdl $f
}

puts "-------------"
puts -nonewline "Reading shared IP in "
puts $shared_ip_dir
puts "-------------"

foreach f [glob -nocomplain $shared_ip_dir/*.xcix] {
    puts -nonewline "    "
    puts $f  
    read_ip $f
}

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
