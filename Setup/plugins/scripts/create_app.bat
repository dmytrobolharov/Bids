REM Args:   ApplicationName ApplicationPool ApplicationPath

REM @ECHO OFF
IF EXIST ./environ.bat call environ.bat

call create_vdir.bat %1 %3
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

cscript %SYSTEMDRIVE%\Inetpub\AdminScripts\adsutil.vbs appcreateinproc w3svc/1/root/%1
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

cscript %SYSTEMDRIVE%\Inetpub\AdminScripts\adsutil.vbs set w3svc/1/root/%1/path %3
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

cscript %SYSTEMDRIVE%\Inetpub\AdminScripts\adsutil.vbs set w3svc/1/root/%1/AppPoolId %2
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

goto EndLabel
 
:ErrorLabel
 
:EndLabel