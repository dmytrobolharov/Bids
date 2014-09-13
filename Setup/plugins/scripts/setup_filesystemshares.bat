@echo off

IF EXIST ./environ.bat call environ.bat

echo *****************************************************
echo Setup filesystem shares....

set rootDir="%PLM.Installation.InstallPath%"
set V=%PLM.AppServer.SiteID%

echo setup_filesystemshares.bat %rootDir% %V% >> cli.log

net share plmOn%V%ShareRoot=%rootDir%\Software-Etc\Share /remark:"plmOn Shared Folders" /grant:plmusers,FULL
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

net share plmOn%V%Share=%rootDir%\Software-Etc\Share\Image /remark:"plmOn Shared Images" /grant:plmusers,FULL
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

net share plmOn%V%Store=%rootDir%\Software-Etc\Store /remark:"plmOn File Store" /grant:plmApplication,FULL 
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

goto EndLabel
 
:ErrorLabel
EXIT /b 1
 
:EndLabel
echo Done!
echo *****************************************************

