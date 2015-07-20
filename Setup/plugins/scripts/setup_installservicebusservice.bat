@echo off

IF EXIST ./environ.bat call environ.bat

set spath="%PLM.Installation.InstallPath%\Software\Application\Yunique.ServiceBus"
set V=%PLM.AppServer.SiteID%

echo *****************************************
echo Installing Service Bus....
echo setup_installservicebusservice.bat %spath% %V% >> cli.log

set srvName=YuniquePLMServiceBus%V%
set dispName=YuniquePLM Service Bus %V%
set usr=%PLM.AppServer.WindowsServiceAccount%
set pwd=%PLM.AppServer.WindowsServicePassword%

%SYSTEMDRIVE%\WINDOWS\system32\sc.exe create %srvName% binPath= %spath%\Yunique.Service.Bus.Receiver.exe start= auto DisplayName= "%dispName%" obj= %usr% password= %pwd%
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
