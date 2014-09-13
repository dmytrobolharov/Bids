@echo off

IF EXIST ./environ.bat call environ.bat

echo *********************************************************************
echo Installing empty database into server.....

REM This should take the clean initial DB and restore it to the SQL server of choice
REM This is potentially very distructive.  BE SURE not to use an existing DB name

set svr=%PLM.DBServer.ServerName% %PLM.DBServer.Instance%
set usr=%PLM.DBServer.SAName%
set pwd=%PLM.DBServer.SAPassword%
set dbname=%PLM.DBServer.Catalog%
REM was %~5
set lpfile="%PLM.Installation.InstallPath%\Database\LanguagePack.bak"
REM C:\Program Files\Microsoft SQL Server\MSSQL\Data  ??
REM was %~6
set finalDest="%PLM.Installation.InstallPath%\Database"

echo setup_languagepack.bat %svr% %usr% %pwd% %dbname% %lpfile% %finalDest% >> cli.log

echo RESTORE DATABASE N'LanguagePack' > lang_pack.sql
echo    FROM DISK = N'%lpfile%' WITH REPLACE, >> lang_pack.sql
echo GO >> lang_pack.sql
echo drop [%dbname].[dbo].[sSystemButtons] >> lang_pack.sql
echo drop [%dbname].[dbo].[sSystemCulture] >> lang_pack.sql
echo drop [%dbname].[dbo].[sSystemPageStrings] >> lang_pack.sql
echo drop [%dbname].[dbo].[sSystemStrings] >> lang_pack.sql
echo drop [%dbname].[dbo].[sUserStrings] >> lang_pack.sql
echo drop [%dbname].[dbo].[sUserXMLStrings] >> lang_pack.sql
echo select * into [%dbname%].[dbo].[sSystemButtons] from [LanguagePack].[dbo].[sSystemButtons] >> lang_pack.sql
echo select * into [%dbname%].[dbo].[sSystemCulture] from [LanguagePack].[dbo].[sSystemCulture] >> lang_pack.sql
echo select * into [%dbname%].[dbo].[sSystemPageStrings] from [LanguagePack].[dbo].[sSystemPageStrings] >> lang_pack.sql
echo select * into [%dbname%].[dbo].[sSystemStrings] from [LanguagePack].[dbo].[sSystemStrings] >> lang_pack.sql
echo select * into [%dbname%].[dbo].[sUserStrings] from [LanguagePack].[dbo].[sUserStrings] >> lang_pack.sql
echo select * into [%dbname%].[dbo].[sUserXMLStrings] from [LanguagePack].[dbo].[sUserXMLStrings] >> lang_pack.sql
echo drop database LanguagePack  >> lang_pack.sql
echo GO >> lang_pack.sql

OSQL -S %svr% -U %usr% -P %pwd% -i lang_pack.sql
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

del lang_pack.sql
IF EXIST lang_pack.sql Goto ErrorLabel

goto EndLabel

:ErrorLabel
EXIT /b 1
 
:EndLabel

echo Done!
echo *********************************************************************
