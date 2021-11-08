# hardware_settings.tcl
# Drew Coker 
# 11/2/2021
# Vivado settings that are hardware specific should be put here

# Load project specific settings
source [pwd]/scripts/project_settings.tcl 

# Parameters
set fpga_device XC7Z020-CLG484-1
set fpga_board xilinx.com:zc702:part0:1.4
set top_level "top"
set bd_name "zynq_bd"
set bd_script "$bd_dir/$bd_name.tcl"
set ignore_list {"counter.vhd"}

# Load project specific settings
source [pwd]/scripts/project_settings.tcl 

proc hardware_update_bd {} {
    write_bd_tcl -force $bd_dir/$bd_script
}


