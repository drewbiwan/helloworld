# hardware_settings.tcl
# Drew Coker 
# 11/2/2021
# Vivado settings that are hardware specific should be put here

set fpga_device XC7Z020-CLG484-1
set top_level "top"
set bd_script "zynq_bd.tcl"

# run in create.tcl. These overwrite previously set properties
proc hardware_create {} {
    puts "Hardware specific settings..."

# create bd from scratch
    source $bd_dir/$bd_script

# every hdl file in shared is automatically added. Add file names to the list if necessary 
    puts "Removing unneeded files.."
    set useless_list "counter.vhd"
    append useless_list ""
    foreach f $useless_list {
        remove_files $f
        puts "   $f"
    }
}

proc hardware_update_bd {} {
    write_bd_tcl -force $bd_dir/$bd_script
}


