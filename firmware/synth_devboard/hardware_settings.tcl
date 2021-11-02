# hardware_settings.tcl
# Drew Coker 
# 11/2/2021
# Vivado settings that are hardware specific should be put here

set fpga_device XC7Z020-CLG484-1
set top_level "top"

# run in create.tcl. These overwrite previously set properties
proc hardware_tcl {} {
    puts "Hardware specific settings..."
}