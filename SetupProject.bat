@echo off

set ogreVersion=14.4.1
set vstVersion=142
set buildAll=1

if exist "%cd%/Assets" set buildAll=0
if exist "%cd%/OGRE.zip" goto ExitProgram


:SetupProject
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0InstallOgre.ps1" -Command %buildAll% "%ogreVersion%" "%vstVersion%"
echo Project Setup completed...
pause
exit

:ExitProgram
echo Project is already installed...
pause
exit
