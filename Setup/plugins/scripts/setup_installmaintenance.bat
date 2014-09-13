@echo off

IF EXIST ./environ.bat call environ.bat

set installPath="%PLM.Installation.InstallPath%"
set scriptPath=%installPath%\Software\Maintenance\DeleteTempFiles.vbs

echo **************************************************
echo Installing maintenance scripts....
echo setup_installmaintenance.bat %installPath% %scriptPath% >> cli.log

REM at 23:00 /every:M,T,W,Th,F %scriptPath%
schtasks /CREATE /SC DAILY /ST 23:00 /TN "YuniquePLM Maintenance %PLM.AppServer.SiteID%" /TR %scriptPath% /F

IF %ERRORLEVEL% NEQ 0 goto ErrorLabel
goto EndLabel
 
:ErrorLabel
EXIT /b 1
 
:EndLabel

echo Done!
echo **************************************************

