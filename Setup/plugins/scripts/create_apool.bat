REM @ECHO OFF

IF EXIST ./environ.bat call environ.bat

CSCRIPT %SYSTEMDRIVE%\Inetpub\AdminScripts\ADSUTIL.VBS ENUM /P w3svc/AppPools/%1
IF ERRORLEVEL 0 goto EndLabel 

CSCRIPT %SYSTEMDRIVE%\Inetpub\AdminScripts\ADSUTIL.VBS CREATE w3svc/AppPools/%1 IIsApplicationPool
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

CSCRIPT %SYSTEMDRIVE%\Inetpub\AdminScripts\ADSUTIL.VBS SET w3svc/AppPools/%1/ManagedPipelineMode "0"
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

CSCRIPT %SYSTEMDRIVE%\Inetpub\AdminScripts\ADSUTIL.VBS SET w3svc/AppPools/%1/ManagedRuntimeVersion "v4.0"
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

CSCRIPT %SYSTEMDRIVE%\Inetpub\AdminScripts\ADSUTIL.VBS SET w3svc/AppPools/%1/Enable32BitAppOnWin64 "0"
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

%systemroot%\system32\inetsrv\appcmd set config -section:applicationPools /[name='%1'].processModel.loadUserProfile:true
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

goto EndLabel
 
:ErrorLabel
EXIT /b 1
 
:EndLabel