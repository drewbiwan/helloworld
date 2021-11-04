# helloworld

## Directory Structure
/{project_name}
    /documentation --for ICDs, block diagrams, datasheets, etc
    /firmware --for HDL and embedded software
        /shared_hdl --code that is shared across hardware
            /shared_ip
        /synth_{hardware+revision} --top level for vivado project synthesis
            /builds --this contains the bitstreams and logs for all builds for this hardware
            /constraints --constraints files read by vivado project
            /hdl --hardware specific
    /scripts --tcl and batch scipts for build environments
    /software --higher level software, excecutables, etc

## Nomenclature
### project name
This is the overarching name for the entire codebase. It defines the top level dire
### hardware name
Specific hardware that necessitates different top level code, constraints, parameters, etc
### version and build
Major and minor versions are manually changed. Minor should be regular releases, major should be significant changes in the codebase, or a focus shift to new hardware

The build number is auto-incremented on each run of the compile script. 

Format of git tag is v{major}.{minor}.{buildnum}

## New project process

## How to compile an established project
1.  Clone git to your local machine
2.  Run "create" task in 

## TODO
1.  git hooks?
2.  sdk tcl script
3.  document
4.  bit and bin?
5.  create dir structure script
6.  embedded c dir structure