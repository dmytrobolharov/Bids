@echo off

IF EXIST ./environ.bat call environ.bat

echo *****************************************************
echo Setup filesystem permissions....

set grp=%PLM.AppServer.ImpersonateGroup%
set rootDir="%PLM.Installation.InstallPath%\Software-Etc"
set rootDir2="%PLM.Installation.InstallPath%\Software-Configs\Schema"

echo setup_filesystemperms.bat %grp% %rootDir% %rootDir2% >> cli.log

icacls %rootDir% /T /grant "%grp%":F
icacls %rootDir2% /T /grant "%grp%":F
goto EndLabel
 
:ErrorLabel
EXIT /b 1
 
:EndLabel

echo Done!
echo *****************************************************\

