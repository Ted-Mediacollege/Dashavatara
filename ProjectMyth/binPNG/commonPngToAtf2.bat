::png2atf.exe -i sky_spritesheet.png -o sky_spritesheet.atf
@echo off
SET TOOL_PATH="C:\Program Files (x86)\Adobe Gaming SDK 1.3\Utilities\ATF Tools\"


copy /y nul tutorial.atf
call %TOOL_PATH%png2atf.exe -c -r -e -i tutorial.png -o tutorial.atf
copy /y nul editor.atf
call %TOOL_PATH%png2atf.exe -c -r -e -i editor.png -o editor.atf
::copy /y nul earth_spritesheet.atf
::call %TOOL_PATH%png2atf.exe -c -r -e -i earth_spritesheet.png -o earth_spritesheet.atf
::copy /y nul sky_spritesheet.atf
::call %TOOL_PATH%png2atf.exe -c -r -e -i sky_spritesheet.png -o sky_spritesheet.atf
pause