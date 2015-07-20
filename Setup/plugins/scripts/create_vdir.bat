REM @ECHO OFF
IF EXIST ./environ.bat call environ.bat

set wsID=1

CSCRIPT %SYSTEMDRIVE%\Inetpub\AdminScripts\ADSUTIL.VBS ENUM /P w3svc/%wsID%/root/%1
IF ERRORLEVEL 0 goto EndLabel 

cscript %SYSTEMDRIVE%\Inetpub\AdminScripts\adsutil.vbs create w3svc/%wsID%/root/%1 "IIsWebVirtualDir"
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

cscript %SYSTEMDRIVE%\Inetpub\AdminScripts\adsutil.vbs set w3svc/%wsID%/root/%1/path %2
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

goto EndLabel
 
:ErrorLabel
EXIT /b 1

:EndLabel