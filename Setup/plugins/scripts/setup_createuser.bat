@echo off

IF EXIST ./environ.bat call environ.bat

echo *****************************************************
echo Creating users and groups....

set usr=%PLM.AppServer.ImpersonateName%
set grp=%PLM.AppServer.ImpersonateGroup%%PLM.AppServer.SiteID%
set grpadmin=%PLM.AppServer.ImpersonateAdminGroup%%PLM.AppServer.SiteID%
set pwd=%PLM.AppServer.ImpersonatePassword%

echo setup_createuser.bat %usr% %grp% %pwd% >> cli.log

echo "Check for user %usr%"
net user %usr%
IF %ERRORLEVEL% EQU 0 goto UserExists

echo "Creating User...."
net user %usr% %pwd% /add /PASSWORDCHG:NO /EXPIRES:NEVER
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

:UserExists
echo "User Exists..."

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
