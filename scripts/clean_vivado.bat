@echo off 
echo Removing vivado autogenerated files for configuration %1

echo Removing directories...
for /f "tokens=*" %%a in ('dir .\firmware\synth_%1\*.hw /b /s /a:d') DO rmdir /s /q %%a
for /f "tokens=*" %%a in ('dir .\firmware\synth_%1\*.cache /b /s /a:d') DO rmdir /s /q %%a
for /f "tokens=*" %%a in ('dir .\firmware\synth_%1\*.runs /b /s /a:d') DO rmdir /s /q %%a
for /f "tokens=*" %%a in ('dir .\firmware\synth_%1\*.gen /b /s /a:d') DO rmdir /s /q %%a
for /f "tokens=*" %%a in ('dir .\firmware\synth_%1\*.ip_user_files /b /s /a:d') DO rmdir /s /q %%a
for /f "tokens=*" %%a in ('dir .\firmware\synth_%1\*.sim /b /s /a:d') DO rmdir /s /q %%a
for /f "tokens=*" %%a in ('dir .\firmware\synth_%1\*.srcs /b /s /a:d') DO rmdir /s /q %%a
for /f "tokens=*" %%a in ('dir .\firmware\synth_%1\bd\* /b /s /a:d') DO rmdir /s /q %%a

echo removing files...
for /f "tokens=*" %%a in ('dir .\firmware\synth_%1\*.xpr /b') DO del /s /q .\firmware\synth_%1\%%a
for /f "tokens=*" %%a in ('dir .\firmware\synth_%1\*.jou /b') DO del /s /q .\firmware\synth_%1\%%a
for /f "tokens=*" %%a in ('dir .\firmware\synth_%1\*.log /b') DO del /s /q .\firmware\synth_%1\%%a