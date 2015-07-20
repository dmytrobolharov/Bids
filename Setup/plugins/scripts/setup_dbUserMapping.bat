@echo off

IF EXIST ./environ.bat call environ.bat

set datasource=%PLM.DBServer.ServerName%%PLM.DBServer.Instance%
if NOT "%PLM.DBServer.Instance%" == "" set datasource=%PLM.DBServer.ServerName%\%PLM.DBServer.Instance%

set catalog=%PLM.DBServer.Catalog%
set sauser=%PLM.DBServer.SAName%
set sapwd=%PLM.DBServer.SAPassword%

set user=%PLM.DBServer.Username%
set pwd=%PLM.DBServer.Password%

set winuser=%PLM.AppServer.ServerName%\%PLM.AppServer.ImpersonateName%

echo setup_dbUserMapping.bat %datasource% %catalog% %user% %pwd% >> cli.log

IF [%user%]==[] (
	sqlcmd -S %datasource% -d %catalog% -U %sauser% -P %sapwd% -i %PLM.Installation.PluginPath%\scripts\setup_dbUserMappingIntegrated.sql -v dbName = %catalog% windowsUser = %winuser%
) ELSE (
	sqlcmd -S %datasource% -d %catalog% -U %sauser% -P %sapwd% -i %PLM.Installation.PluginPath%\scripts\setup_dbUserMappingSQL.sql -v dbName = %catalog% loginUser = %user% loginPassword = %pwd%
)
