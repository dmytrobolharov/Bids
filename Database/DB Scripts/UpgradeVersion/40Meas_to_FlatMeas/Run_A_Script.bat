@echo off

set datasource=%1
set catalog=%2
set user=%3
set pwd=%4
set script=%5

echo.
echo.
echo -------------------------------------------------------------------------------------------
echo Execute: %script%
echo -------------------------------------------------------------------------------------------
osql -b -S %datasource% -d %catalog% -U %user% -P %pwd% -i %script%

if %ERRORLEVEL% NEQ 0 goto error
echo.
echo.
echo ----    Complete    ----  
echo.
goto done

:error
echo.
echo.
echo =======================================================
echo ==    ** ERROR **    ** ERROR **      ** ERROR **    ==
echo =======================================================
echo.

:done

