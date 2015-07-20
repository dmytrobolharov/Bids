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

echo.
echo.
echo Complete!
echo.
echo.

goto EndLabel
 
:ErrorLabel
EXIT /b 1
 
:EndLabel
echo Done!
echo *****************************************************

REM pause