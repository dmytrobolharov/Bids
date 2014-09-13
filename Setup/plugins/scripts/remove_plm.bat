@echo off

IF NOT EXIST ./environ.bat (
  echo "Missing Environment File"
  goto EndLabel
)

IF EXIST ./environ.bat call environ.bat

set V=%PLM.AppServer.SiteID%

set usrGroup=%PLM.AppServer.ImpersonateGroup%%V%
set admGroup=%PLM.AppServer.ImpersonateAdminGroup%%V%
set mailFolder=%PLM.Mail.QueueFolder%
set installPath=%PLM.Installation.InstallPath%

echo
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo       Remove Shares
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo Removing Shares......

net share plmOn%V%ShareRoot /DELETE
net share plmOn%V%Share /DELETE
net share plmOn%V%Store /DELETE

echo
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo       Remove Virtual Dirs
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo Removing IIS Virtual Directories.....

cscript %SYSTEMDRIVE%\Inetpub\AdminScripts\adsutil.vbs DELETE W3SVC/1/ROOT/plmOn%V%Download
cscript %SYSTEMDRIVE%\Inetpub\AdminScripts\adsutil.vbs DELETE W3SVC/1/ROOT/srmOn%V%Download

echo
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo       Remove Web Applications
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo Removing IIS Web Applications.....

cscript %SYSTEMDRIVE%\Inetpub\AdminScripts\adsutil.vbs DELETE w3svc/1/root/plmOn%V%
cscript %SYSTEMDRIVE%\Inetpub\AdminScripts\adsutil.vbs DELETE w3svc/1/root/plmOn%V%Report
cscript %SYSTEMDRIVE%\Inetpub\AdminScripts\adsutil.vbs DELETE w3svc/1/root/srmOn%V%
cscript %SYSTEMDRIVE%\Inetpub\AdminScripts\adsutil.vbs DELETE w3svc/1/root/YuniqueBI%V%
cscript %SYSTEMDRIVE%\Inetpub\AdminScripts\adsutil.vbs DELETE w3svc/1/root/plmOn%V%Dashboard
cscript %SYSTEMDRIVE%\Inetpub\AdminScripts\adsutil.vbs DELETE w3svc/1/root/plmOn%V%WebServices
cscript %SYSTEMDRIVE%\Inetpub\AdminScripts\adsutil.vbs DELETE w3svc/1/root/plmOn%V%ImageServer
cscript %SYSTEMDRIVE%\Inetpub\AdminScripts\adsutil.vbs DELETE w3svc/1/root/plmOn%V%FileServices
cscript %SYSTEMDRIVE%\Inetpub\AdminScripts\adsutil.vbs DELETE w3svc/1/root/YuniqueToolkit%V%
cscript %SYSTEMDRIVE%\Inetpub\AdminScripts\adsutil.vbs DELETE w3svc/1/root/Yunique.Toolkit%V%.API
cscript %SYSTEMDRIVE%\Inetpub\AdminScripts\adsutil.vbs DELETE w3svc/1/root/YuniqueAPI%V%
cscript %SYSTEMDRIVE%\Inetpub\AdminScripts\adsutil.vbs DELETE w3svc/1/root/YuniqueAPI%V%.SOAP
cscript %SYSTEMDRIVE%\Inetpub\AdminScripts\adsutil.vbs DELETE w3svc/1/root/YuniqueAPI%V%.REST
cscript %SYSTEMDRIVE%\Inetpub\AdminScripts\adsutil.vbs DELETE w3svc/1/root/YuniqueAppManager%V%
cscript %SYSTEMDRIVE%\Inetpub\AdminScripts\adsutil.vbs DELETE w3svc/1/root/plmOn%V%CodrawMarkup

echo
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo       Remove Application Pools
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo Removing IIS Application Pools.....

CSCRIPT %SYSTEMDRIVE%\Inetpub\AdminScripts\ADSUTIL.VBS DELETE w3svc/AppPools/plmOn%V%
CSCRIPT %SYSTEMDRIVE%\Inetpub\AdminScripts\ADSUTIL.VBS DELETE w3svc/AppPools/plmOn%V%Report
CSCRIPT %SYSTEMDRIVE%\Inetpub\AdminScripts\ADSUTIL.VBS DELETE w3svc/AppPools/srmOn%V%
CSCRIPT %SYSTEMDRIVE%\Inetpub\AdminScripts\ADSUTIL.VBS DELETE w3svc/AppPools/YuniqueBI%V%
CSCRIPT %SYSTEMDRIVE%\Inetpub\AdminScripts\ADSUTIL.VBS DELETE w3svc/AppPools/plmOn%V%Dashboard
CSCRIPT %SYSTEMDRIVE%\Inetpub\AdminScripts\ADSUTIL.VBS DELETE w3svc/AppPools/plmOn%V%WebServices
CSCRIPT %SYSTEMDRIVE%\Inetpub\AdminScripts\ADSUTIL.VBS DELETE w3svc/AppPools/plmOn%V%ImageServices
CSCRIPT %SYSTEMDRIVE%\Inetpub\AdminScripts\ADSUTIL.VBS DELETE w3svc/AppPools/plmOn%V%FileServices
CSCRIPT %SYSTEMDRIVE%\Inetpub\AdminScripts\ADSUTIL.VBS DELETE w3svc/AppPools/YuniqueToolkit%V%
CSCRIPT %SYSTEMDRIVE%\Inetpub\AdminScripts\ADSUTIL.VBS DELETE w3svc/AppPools/Yunique.Toolkit%V%.API
CSCRIPT %SYSTEMDRIVE%\Inetpub\AdminScripts\ADSUTIL.VBS DELETE w3svc/AppPools/YuniqueAPI%V%
CSCRIPT %SYSTEMDRIVE%\Inetpub\AdminScripts\ADSUTIL.VBS DELETE w3svc/AppPools/YuniqueAPI%V%.SOAP
CSCRIPT %SYSTEMDRIVE%\Inetpub\AdminScripts\ADSUTIL.VBS DELETE w3svc/AppPools/YuniqueAPI%V%.REST
CSCRIPT %SYSTEMDRIVE%\Inetpub\AdminScripts\ADSUTIL.VBS DELETE w3svc/AppPools/YuniqueAppManager%V%
CSCRIPT %SYSTEMDRIVE%\Inetpub\AdminScripts\ADSUTIL.VBS DELETE w3svc/AppPools/plmOn%V%CodrawMarkup

echo
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo       Remove Windows Service
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo Windows Services.....

sc STOP plmOn%V%Services
sc DELETE plmOn%V%Services

echo
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo       Remove Chilkat Stuff
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo Chilkat Stuff.....

sc STOP ChilkatSmtpq
sc DELETE ChilkatSmtpq

%SYSTEMDRIVE%\WINDOWS\system32\regsvr32.exe /u "C:\Program Files\YuniquePLM\ChilkatSmtpQ\ChilkatUtil.dll"
%SYSTEMDRIVE%\WINDOWS\system32\regsvr32.exe /u "C:\Program Files\YuniquePLM\ChilkatSmtpQ\SmtpQMgr.dll"

%SYSTEMDRIVE%\WINDOWS\system32\reg.exe delete "HKEY_LOCAL_MACHINE\SOFTWARE\Chilkat Software, Inc.\SmtpQ" /f

rmdir /S /Q "C:\Program Files\YuniquePLM\ChilkatSmtpQ"
rmdir /S /Q %mailFolder%

echo
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo       Remove User Perms
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo Removing User Perms.....
icacls %installPath%\Software-Etc\Share /T /remove %usrGroup%
icacls %installPath%\Software-Etc\Store /T /remove %admGroup%
icacls %installPath%\Software-Configs\Schema /T /remove %admGroup%

echo
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
echo       Remove Scheduled tasks
echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
schtasks /DELETE /TN "YuniquePLM Maintenance %V%"

echo.
echo.
echo Complete!
echo.
echo Please note:  The following steps are left for you...
echo                   1) Remove reports from the report server. For Example.
echo                        http://server/Reports_MSSQL2008R2
echo                                  - or -
echo                        http://server/Reports
echo                   2) Drop your PLM Database
echo                        'drop database plmonDBName' on sql server
echo                   3) Delete the entire PLM Installation folder
echo                   4) Delete your PLM User (Optional)
echo                   5) Delete your PLM User's Group (Optional)  

echo.

goto EndLabel
 
:ErrorLabel
EXIT /b 1
 
:EndLabel
echo Done!
echo *****************************************************

pause