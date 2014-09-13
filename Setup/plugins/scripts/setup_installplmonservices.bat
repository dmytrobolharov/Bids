@echo off

IF EXIST ./environ.bat call environ.bat

set spath="%PLM.Installation.InstallPath%\Software\Application\plmOnServices"
set V=%PLM.AppServer.SiteID%

echo *****************************************
echo Installing plmOnServices....
echo setup_installplmonservices.bat %spath% %V% >> cli.log

set srvName=plmOn%V%Services
set dispName=YuniquePLM plmOn%V%Services
set usr=%PLM.AppServer.WindowsServiceAccount%
set pwd=%PLM.AppServer.WindowsServicePassword%

%SYSTEMDRIVE%\WINDOWS\system32\sc.exe create %srvName% binPath= %spath%\plmOnServices.exe start= auto DisplayName= "%dispName%" obj= %usr% password= %pwd%
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

..\utils\ntrights.exe +r SeServiceLogonRight -u %usr%
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

%SYSTEMDRIVE%\WINDOWS\system32\sc.exe start %srvName%
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

goto EndLabel
 
:ErrorLabel
echo %ERRORLEVEL%
EXIT /b 1
 
:EndLabel

echo Done!
echo ******************************************
