@echo off
echo vivado exe at %1
echo tcl script at %2

call %1 -mode batch -notrace -nolog -nojournal -source %2 -tclargs %3