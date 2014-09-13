@echo off

call %0\..\environ.bat

set datasource=%PLM.DBServer.ServerName%%PLM.DBServer.Instance%
set catalog=%PLM.DBServer.Catalog%
set sauser=%PLM.DBServer.SAName%
set sapwd=%PLM.DBServer.SAPassword%

set user=%PLM.DBServer.Username%
set pwd=%PLM.DBServer.Password%

echo setup_dbUserMapping.bat %datasource% %catalog% %user% %pwd% >> cli.log

sqlcmd -S %datasource% -d %catalog% -U %sauser% -P %sapwd% -i %PLM.Installation.PluginPath%\scripts\setup_dbUserMappingSQL.sql -v dbName = %catalog% loginUser = %user% loginPassword = %pwd%
