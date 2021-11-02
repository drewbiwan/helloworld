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
puts -nonewline "Updating packages for "
puts $hardware_name
puts "-------------"

puts "-------------"
puts "Reading build information"
puts "-------------"

# Get GIT commit info
set git_oid_log [open [pwd]/.git/ORIG_HEAD r]
set git_commit_oid_hex "0x"
while { [gets $git_oid_log data] >= 0 } {
    append git_commit_oid_hex $data
}

puts -nonewline "Commit ID "
puts $git_commit_oid_hex