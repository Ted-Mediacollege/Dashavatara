@echo off
set PAUSE_ERRORS=1
call batPC\SetupSDK.bat
call batPC\SetupApplication.bat

echo.
echo Starting AIR Debug Launcher...
echo.

adl "%APP_XML%" "%APP_DIR%"
if errorlevel 1 goto error
goto end

:error
pause

:end