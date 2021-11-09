# configuration_settings.tcl
# Drew Coker 
# 11/2/2021
# Vivado settings that are configuration specific should be put here

# Parameters
set fpga_device XC7Z020-CLG484-1
set fpga_board xilinx.com:zc702:part0:1.4
set top_level "top"
set bd_name "zynq_bd"
set bd_script "$bd_dir/$bd_name.tcl"
set ignore_list {"counter.vhd"}

# this string can be read from build_pkg.vhd. Should be 4 characters long to fit into 32bits
set configuration_string DEV0




