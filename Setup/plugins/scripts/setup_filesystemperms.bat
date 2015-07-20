@echo off

IF EXIST ./environ.bat call environ.bat

echo *****************************************************
echo Setup filesystem permissions....

set usrGroup=%PLM.AppServer.ImpersonateGroup%%PLM.AppServer.SiteID%
set admGroup=%PLM.AppServer.ImpersonateAdminGroup%%PLM.AppServer.SiteID%

REM Users need access to full SHARE folder, as there are well... "network shares" open to them
set dirShare="%PLM.Installation.InstallPath%\Software-Etc\Share"

REM Application must have full access to schema files because TOOLKIT edits them
set dirSchema="%PLM.Installation.InstallPath%\Software-Configs\Schema"
REM Application must have full access to entire store
set dirStore="%PLM.Installation.InstallPath%\Software-Etc\Store"
set dirTemp="%PLM.Installation.InstallPath%\Software-Etc\Temp"

echo setup_filesystemperms.bat %grp% %rootDir% %rootDir2% >> cli.log

icacls %dirShare% /T /grant "%usrGroup%":(OI)(CI)F

icacls %dirShare% /T /grant "%admGroup%":(OI)(CI)F
icacls %dirSchema% /T /grant "%admGroup%":(OI)(CI)F
icacls %dirStore% /T /grant "%admGroup%":(OI)(CI)F
icacls %dirTemp% /T /grant "%admGroup%":(OI)(CI)F

goto EndLabel
 
:ErrorLabel
EXIT /b 1
 
:EndLabel

echo Done!
echo *****************************************************\

