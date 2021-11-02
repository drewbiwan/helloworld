# compile script for vivado
# Drew Coker 
# 11/2/2021
# This synthesizes, implements, and generates bitstreams. 
# Prereqs:
#   Vivado project should have already been created by create.tcl
#   all files should be committed, and update_pkg.tcl should have been run

# Project settings
set project_name helloworld
set hardware_name devboard
set fpga_device XC7Z020-CLG484-1

# Directory structure
set synth_dir [pwd]/firmware/synth_$hardware_name
set contraints_dir $synth_dir/constraints
set hdl_dir $synth_dir/hdl
set shared_hdl_dir [pwd]/firmware/shared_hdl
set shared_ip_dir $shared_hdl_dir/shared_ip