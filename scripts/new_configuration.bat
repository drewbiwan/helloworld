REM @echo off 
REM Expects 1 argument: the new configuration name (eg "new_configuration.bat devboard", which creates /synth_devboard)
REM Should be run from project root directory
echo Creating new configuration directory at %1
mkdir .\firmware\synth_%1
mkdir .\firmware\synth_%1\bd
mkdir .\firmware\synth_%1\builds
mkdir .\firmware\synth_%1\constraints
mkdir .\firmware\synth_%1\hdl
mkdir .\firmware\synth_%1\ip

echo Copying templates into new directory
copy .\templates\new_configuration\clean.sh .\firmware\synth_%1
copy .\templates\new_configuration\configuration_settings.tcl .\firmware\synth_%1
copy .\templates\new_configuration\top.hdl .\firmware\synth_%1\hdl
copy .\templates\new_configuration\devboard_pin.xdc .\firmware\synth_%1\constraints
copy .\templates\new_configuration\zynq_bd.tcl .\firmware\synth_%1\bd

cd .\templates