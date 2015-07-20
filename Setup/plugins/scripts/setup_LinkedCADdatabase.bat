@echo off

IF EXIST ./environ.bat call environ.bat

echo *********************************************************************
echo Installing empty database into server.....

REM This should link our local database with CAD database.

set remotesvr=%PLM.CADServer.CADDatabaseRemoteServerName%
set dbname=%PLM.CADServer.CADDatabaseName%
set remoteusr=%PLM.CADServer.RemoteUsername%
set remotepwd=%PLM.CADServer.RemotePassword%
set localusrname=%PLM.CADServer.LocalUserName%

echo setup_LinkedCADdatabase.bat %remotesvr% %dbname% %remoteusr% %remotepwd% %localusrname% >> cli.log

echo if(exists(select srvname from dbo.sysservers where srvname = 'CADDatabase')) >> LinkCADDatabase_data.sql
echo begin >> LinkCADDatabase_data.sql
echo exec sp_dropserver 'CADDatabase','droplogins' >> LinkCADDatabase_data.sql
echo end >> LinkCADDatabase_data.sql

echo exec sp_addlinkedserver 'CADDatabase','sql_server','SQLOLEDB','%remotesvr%' >> LinkCADDatabase_data.sql
echo exec sp_addlinkedsrvlogin 'CADDatabase','false','%localusrname%','%remoteusr%','%remotepwd%' >> LinkCADDatabase_data.sql
echo GO >> LinkCADDatabase_data.sql

REM ==================================================
REM Update AspNet_SqlCacheTablesForChangeNotification table
REM ==================================================

echo DELETE from AspNet_SqlCacheTablesForChangeNotification >> LinkCADDatabase_data.sql

sqlcmd -i LinkCADDatabase_data.sql
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel  

del LinkCADDatabase_data.sql
IF EXIST LinkCADDatabase_data.sql Goto ErrorLabel

goto EndLabel

:ErrorLabel
EXIT /b 1
 
:EndLabel

echo Done!
echo *********************************************************************
