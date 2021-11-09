# create script 
# Drew Coker 
# 11/2/2021
# This should be run after pulling from repo, or as a clean slate (after running clean.sh in synth directory)
# The first argument should be the configuration name, eg "source create.tcl devboard" to create vivado project in /synth_devboard

if { $argc != 1 } {
    puts "ERROR: (create.tcl). Please specify a configuration to run, eg \"create.tcl devboard\""
} else {
    set configuration_name [lindex $argv 0]
}

puts ""
puts "-------------"
puts "Running Create Script for project in [pwd]"
puts "Configuration selected: $configuration_name"
puts "-------------"

# Load project specific settings
source [pwd]/scripts/project_settings.tcl

# Load configuration/build specific settings
source $synth_dir/configuration_settings.tcl

# Create Vivado Project
puts ""
puts "-------------"
puts -nonewline "Creating Vivado Project "
puts $project_name
puts -nonewline "Configuration: "
puts $configuration_name
puts -nonewline "FPGA: "
puts $fpga_device
puts -nonewline "Board: "
puts $fpga_board
puts -nonewline "Top Level Entity: "
puts $top_level
puts "-------------"

create_project $project_name $synth_dir -part $fpga_device -force
set_property board_part $fpga_board [current_project]

# Read HDL and IP
puts ""
puts "-------------"
puts -nonewline "Reading configuration specific HDL in "
puts $hdl_dir
puts "-------------"

foreach f [glob -nocomplain $hdl_dir/*.vhd] {
    puts -nonewline "    "
    puts $f
    read_vhdl $f
}

puts ""
puts "-------------"
puts -nonewline "Reading configuration specific IP in "
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

puts "Removing unneeded files..."
foreach f $ignore_list {
    remove_files $f
    puts "   $f"
}

puts "Generating BD from $bd_script..."
source $bd_script

set bd_autogen_file $synth_dir/$project_name.srcs/sources_1/bd/$bd_name/$bd_name.bd

puts "Generating BD target..."
generate_target all [get_files $bd_autogen_file]

puts "Generating wrapper and moving it to hdl directory..."
make_wrapper -files [get_files $bd_autogen_file] -top
file copy -force $synth_dir/$project_name.gen/sources_1/bd/$bd_name/hdl/$bd_name\_wrapper.vhd $hdl_dir/$bd_name\_wrapper.vhd
read_vhdl $hdl_dir/$bd_name\_wrapper.vhd

puts "-------------"
puts "END OF CREATE SCRIPT"
puts "-------------"