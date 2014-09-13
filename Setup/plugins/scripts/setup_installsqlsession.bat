@echo off

IF EXIST ./environ.bat call environ.bat

set dbServerNameAndInstance="%PLM.DBServer.ServerNameAndInstance%"

echo *****************************************
echo Installing sql session state....
echo setup_installsqlsession.bat %dbServerNameAndInstance% >> cli.log

%WINDIR%\Microsoft.NET\Framework\v4.0.30319\aspnet_regsql.exe -S %dbServerNameAndInstance% -E -ssadd -sstype p
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

goto EndLabel
 
:ErrorLabel
echo %ERRORLEVEL%
EXIT /b 1
 
:EndLabel

echo Done!
echo ******************************************
