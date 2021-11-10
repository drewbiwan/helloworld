# helloworld

## Directory Structure
- {project_name}
    - documentation --for ICDs, block diagrams, datasheets, etc
    - firmware --for HDL and embedded software
        - buildlog --stores log files for build number and tags. Shared across all hardware configurations
        - shared_files -- Files used in multiple configurations
            - shared_bd -- TCL files used to build block diagrams
            - shared_hdl -- HDL files shared across hardware (.hdl)
            - shared_ip --IP files (.xcix)
        - synth_{configuration} --top level for vivado project synthesis
            - bitstreams --this contains the bitstreams for this configuration (.bin, .bit, .xsa)
            - bd --tcl scripts to build block diagrams (.tcl)
            - constraints --constraints files read by vivado project (.xdc)
            - hdl --configuration specific (.vhd)
            - ip --configuration specific IP files (.xcix)
    - scripts --tcl and batch scipts for build environments
    - software --higher level software, excecutables, etc

## Nomenclature
### Project
This is the overarching name for the entire codebase. It defines the top level directory
### Configuration
Specific configuration that necessitates different top level code, constraints, parameters, etc. This might be differing hardware/dev board, or a design split

#### Hardware Configuration
Different hardware configurations necessitate different firmware builds. This could be because of different top level code, constraints, pinout, parameters, etc.. These are split into different directories within /firmware as /synth_{configuration}.

#### Software Configuration

### version and build
Major and minor versions are manually changed. Minor should be regular releases, major should be significant changes in the codebase, or a focus shift to new hardware. The build number is auto-incremented on each run of the compile script, whether or not it results in a bitstream.

Format of git tag is v{major}.{minor}.{buildnum}

## Processes

### General build framework
. Vivado builds HDL into bitstreams (bit, bin, xsa)
. Vitis SDK creates platform/domain based on xsa file
. Application project


. Make changes to HDL/IP/BD files in a configuration
. (if needed) run create_vivado task to create vivado project
. Run compile_vivado task
. 

### Build Firmware after clean, or new git clone
1. Clone git to your local machine
    - (optional) create new branch. Compile script will auto-commit, which can make things complicated if multiple people are building on the same branch.
2. Run "create_vivado" task in vs code, then select the configuration you want. This should pull hdl and ip (xcix) files from shared and synth/hdl directories. This will generate vivado project files and import all files.
3. Run "compile_vivado" task in vs code, then select the configuration you want. This will kick off a build locally. It will automatically append the build log, update the build package, and commit any changes. Once the bitstreams are generated, it will amend the commit and tag with version+build.

### New configuration within a project
1. Run the "new configuration" task in vs code, then enter the name of the new configuration. This generates directory firmware/synth_NEWCONFIGNAME with sub-directories and placeholder files. 
2. Copy/edit/create new hdl, ip, constraints, tcl
3. Update the tasks.json input:configuration list to include this configuration
4. Run create_vivado and compile_vivado scripts to generate bitstreams

## TODO
- git hooks?
- sdk tcl script
- document
- create dir structure script
- embedded c dir structure
- problem catcher