# hardware_settings.tcl
# Drew Coker 
# 11/2/2021
# Vivado settings that are project specific should be put here

# overall project name. this should not change once directory structure has been set up
set project_name helloworld

# hardware build name. 
#  there should be a directory in firmware for each hardware build
#  the active one is specified here
set hardware_name devboard

# Version information. These are updated manually
set major_version 0
set minor_version 0

# Directory structure
set synth_dir [pwd]/firmware/synth_$hardware_name
set contraints_dir $synth_dir/constraints
set hdl_dir $synth_dir/hdl
set ip_dir $synth_dir/ip
set build_dir $synth_dir/builds

set firmware_dir [pwd]/firmware
set shared_hdl_dir $firmware_dir/shared_hdl
set shared_ip_dir $firmware_dir/shared_ip