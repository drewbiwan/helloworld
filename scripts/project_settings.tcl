# hardware_settings.tcl
# Drew Coker 
# 11/2/2021
# Vivado settings that are project specific should be put here

set project_name helloworld
set hardware_name devboard

# Directory structure
set synth_dir [pwd]/firmware/[lindex $argv 0]
set contraints_dir $synth_dir/constraints
set hdl_dir $synth_dir/hdl
set ip_dir $synth_dir/ip
set firmware_dir [pwd]/firmware
set shared_hdl_dir $firmware_dir/shared_hdl
set shared_ip_dir $firmware_dir/shared_ip