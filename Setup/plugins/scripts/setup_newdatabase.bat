@echo off

IF EXIST ./environ.bat call environ.bat

echo *********************************************************************
echo Installing empty database into server.....

set svr=%PLM.DBServer.ServerName% %PLM.DBServer.Instance% 
set usr=%PLM.DBServer.SAName%
set pwd=%PLM.DBServer.SAPassword%
set dbname=%PLM.DBServer.Catalog%
REM was %~5
set dbfile="%PLM.Installation.InstallPath%\Database\plmOn400_OoTB.bak"
REM C:\Program Files\Microsoft SQL Server\MSSQL\Data  ??
REM was $~6
set finalDest="%PLM.Installation.InstallPath%\Database"

echo setup_newdatabase.bat %svr% %usr% %pwd% %dbname% %dbfile% %finalDest% >> cli.log

REM This should take the clean initial DB and restore it to the SQL server of choice
REM This is potentially very distructive.  BE SURE not to use an existing DB name

echo RESTORE DATABASE %dbname% > restore_db.sql
echo    FROM DISK = N'%dbfile%' WITH REPLACE, >> restore_db.sql
echo    MOVE N'LoadTestDatabase' TO >> restore_db.sql
echo       N'%finalDest%\%dbname%_Data.MDF', >> restore_db.sql
echo    MOVE N'LoadTestDatabase_Log' TO >> restore_db.sql
echo       N'%finalDest%\%dbname%_LOG.LDF'; >> restore_db.sql
echo GO >> restore_db.sql

OSQL -S %svr% -U %usr% -P %pwd% -i restore_db.sql
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

del restore_db.sql
IF EXIST restore_db.sql Goto ErrorLabel

goto EndLabel

:ErrorLabel
EXIT /b 1
 
:EndLabel

echo Done!
echo *********************************************************************
