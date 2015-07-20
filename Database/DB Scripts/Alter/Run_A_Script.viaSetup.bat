@echo off

call ..\..\..\Setup\plugins\scripts\environ.bat

set datasource=%PLM.DBServer.ServerName%%PLM.DBServer.Instance%
set catalog=%PLM.DBServer.Catalog%
set user=%PLM.DBServer.SAName%
set pwd=%PLM.DBServer.SAPassword%
set logFile=%1
set script=%2

echo. >> %logFile%
echo. >> %logFile%
echo ------------------------------------------------------------------------------------------- >> %logFile%
echo Execute: %script% >> %logFile%
date /T >> %logFile%
echo ------------------------------------------------------------------------------------------- >> %logFile%
echo osql -b -S %datasource% -d %catalog% -U %user% -P %pwd% -i %script% >> %logFile%
osql -b -S %datasource% -d %catalog% -U %user% -P %pwd% -i %script% >> %logFile%

if %ERRORLEVEL% NEQ 0 goto error
echo. >> %logFile%
echo. >> %logFile%
echo ----    Complete    ----   >> %logFile%
echo. >> %logFile%
goto done

:error
echo. >> %logFile%
echo. >> %logFile%
echo ======================================================= >> %logFile%
echo ==    ** ERROR **    ** ERROR **      ** ERROR **    == >> %logFile%
echo ======================================================= >> %logFile%
echo. >> %logFile%
EXIT /b 1
:done

