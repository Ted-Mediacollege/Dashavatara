@echo off
set PAUSE_ERRORS=1
call batPC\SetupSDK.bat
call batPC\SetupApplication.bat

set AIR_TARGET=
::set AIR_TARGET=-captive-runtime
set OPTIONS=-tsa none
call batPC\Packager.bat

pause