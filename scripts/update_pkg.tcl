# update_pkg.tcl
# Drew Coker 
# 11/2/2021
# Updates pkg files that are read by the upcoming vivado compile
# Prereqs:
#   Vivado project should have already been created by create.tcl
#   all changes should be staged

# Load Project specific settings
source [pwd]/scripts/project_settings.tcl

# Load hardware specific settings
source $synth_dir/hardware_settings.tcl

puts "-------------"
puts "Updating packages"
puts "-------------"

puts "-------------"
puts "Reading GIT information"
puts "-------------"
set git_log [open [pwd]/.git/HEAD r]
while { [gets $git_log data] >= 0 } {
   puts $data
}
