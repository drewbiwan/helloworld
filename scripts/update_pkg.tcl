# update_pkg.tcl
# Drew Coker 
# 11/2/2021
# Updates pkg files that are read by the upcoming vivado compile
# Prereqs:
#   Vivado project should have already been created by create.tcl
#   all changes should be staged

# Load Project specific settings
source $synth_dir/hardware_settings.tcl

# Load hardware specific settings
source [pwd]/scripts/project_settings.tcl

