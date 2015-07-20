@echo off

IF EXIST ./environ.bat call environ.bat

set svr=%PLM.DBServer.ServerName%\%PLM.DBServer.Instance%
set usr=%PLM.DBServer.SAName%
set pwd=%PLM.DBServer.SAPassword%
set dbname=%PLM.DBServer.Catalog%

set lpfile=%PLM.Installation.InstallPath%\Database\LanguagePack.bak
set finalDest=%PLM.Installation.InstallPath%\Database\

echo setup_languagepack.bat %svr% %usr% %pwd% %dbname% %lpfile% %finalDest% >> cli.log

sqlcmd -S %svr% -U %usr% -P %pwd% -i Setup_installlanguagepack.sql -v BackupPath = "%lpfile%" FinalDest = "%finalDest%" TargetDB = %dbname%
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

goto EndLabel

:ErrorLabel
EXIT /b 1
 
:EndLabel

echo Done!
echo *********************************************************************
