@echo off
setlocal

call "C:\Program Files (x86)\Embarcadero\Studio\22.0\bin\rsvars.bat"
if errorlevel 1 goto :fail

set SGC_LIB=C:\Users\mspark\Documents\esegece\sgcWebSockets\LibD11\win32

dcc32 -U"%SGC_LIB%" -I"%SGC_LIB%" CtiWebSocketSample.dpr
if errorlevel 1 goto :fail

echo.
echo Build completed successfully.
goto :eof

:fail
echo.
echo Build failed.
exit /b 1
