REM @ECHO OFF
IF EXIST ./environ.bat call environ.bat

cscript %SYSTEMDRIVE%\Inetpub\AdminScripts\adsutil.vbs create w3svc/1/root/%1 "IIsWebVirtualDir"
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

cscript %SYSTEMDRIVE%\Inetpub\AdminScripts\adsutil.vbs set w3svc/1/root/%1/path %2
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

goto EndLabel
 
:ErrorLabel
 
:EndLabel