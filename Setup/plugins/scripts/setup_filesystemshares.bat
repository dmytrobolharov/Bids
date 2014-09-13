@echo off

IF EXIST ./environ.bat call environ.bat

echo *****************************************************
echo Setup filesystem shares....

set usrGroup=%PLM.AppServer.ImpersonateGroup%%PLM.AppServer.SiteID%
set admGroup=%PLM.AppServer.ImpersonateAdminGroup%%PLM.AppServer.SiteID%

set rootDir="%PLM.Installation.InstallPath%"
set V=%PLM.AppServer.SiteID%

echo setup_filesystemshares.bat %rootDir% %V% >> cli.log

net share plmOn%V%ShareRoot=%rootDir%\Software-Etc\Share /remark:"plmOn Shared Folders" /grant:%usrGroup%,FULL
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

net share plmOn%V%Share=%rootDir%\Software-Etc\Share\Image /remark:"plmOn Shared Images" /grant:%usrGroup%,FULL
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

net share plmOn%V%Store=%rootDir%\Software-Etc\Store /remark:"plmOn File Store" /grant:%admGroup%,FULL 
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

goto EndLabel
 
:ErrorLabel
EXIT /b 1
 
:EndLabel
echo Done!
echo *****************************************************

