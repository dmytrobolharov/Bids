@echo off

IF EXIST ./environ.bat call environ.bat

echo *****************************************************
echo Creating users and groups...

set usr=%PLM.AppServer.ImpersonateName%
set grp=%PLM.AppServer.ImpersonateGroup%
set grpadmin=%PLM.AppServer.ImpersonateAdminGroup%
set pwd=%PLM.AppServer.ImpersonatePassword%

echo setup_createuser.bat %usr% %grp% %pwd% >> cli.log

net user %usr% %pwd% /add /PASSWORDCHG:NO /EXPIRES:NEVER
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

net localgroup %grp% /add
net localgroup %grpadmin% /add

net localgroup %grpadmin% %usr% /add

REM net localgroup "Administrators" %usr% /add

net localgroup "IIS_WPG" %usr% /add

net localgroup "IIS_IUSRS" %usr% /add

goto EndLabel
 
:ErrorLabel
EXIT /b 1

:EndLabel

echo Done!
echo *****************************************************
