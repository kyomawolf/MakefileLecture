@echo off
setlocal EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

rem Prepare a file "X" with only one dot
<nul > X set /p ".=."

call :color 01 "		---This is a (not so) simple Makefile challenge---"
echo.
echo.
call :color 0f "Level1"
echo    Create a simple makefile, that can compile the given sourcecode with 'make'
echo.
call :color 0e "Level2"
echo    Create a makefile which has a library as a dependency, also create rules to clean up!
echo          Kinda bonus?(you are not allowed to compile or clean in the library subfolder directly)
echo.
call :color 0d "Level3"
echo 	Create a makefile which uses *.o files to compile
echo.
call :color 0c "Level4"
echo 	Create a makefile that will do everything from the other levels and also recompiles sources of you change the content of a header
echo.
rem call :color 1c "^!<>&| %%%%"*?"
exit /b

:color
set "param=^%~2" !
set "param=!param:"=\"!"
findstr /p /A:%1 "." "!param!\..\X" nul
<nul set /p ".=%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%%DEL%"
exit /b