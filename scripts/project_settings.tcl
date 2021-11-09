# project_settings.tcl
# Drew Coker 
# 11/2/2021
# Vivado settings that are project specific should be put here
# REQUIRES configuration_name be set before running

# overall project name. this should not change once directory structure has been set up
set project_name helloworld

# Version information. These are updated manually
set major_version 0
set minor_version 0

# Run parameters
set num_jobs 8

# Directory structure
set synth_dir [pwd]/firmware/synth_$configuration_name
set contraints_dir $synth_dir/constraints
set hdl_dir $synth_dir/hdl
set ip_dir $synth_dir/ip
set bd_dir $synth_dir/bd
set build_dir $synth_dir/builds

set firmware_dir [pwd]/firmware
set shared_hdl_dir $firmware_dir/shared_files/shared_hdl
set shared_ip_dir $firmware_dir/shared_files/shared_ip
set shared_bd_dir $firmware_dir/shared_files/shared_bd