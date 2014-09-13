@echo off

IF EXIST ./environ.bat call environ.bat

REM This is necessary because we have some paths/urls/etc inside the columns of a few tables
REM   They need to be redirected in order for the site to work out of the box.

set svr=%PLM.DBServer.ServerNameAndInstance%
set usr=%PLM.DBServer.SAName%
set pwd=%PLM.DBServer.SAPassword%
set catalog=%PLM.DBServer.Catalog%

set dbServer=%PLM.DBServer.ServerName%
set dashFolder=plmOn%PLM.AppServer.SiteID%Dashboards
set biFolder=YuniqueBI%PLM.AppServer.SiteID%
set reportFolder=plmOn%PLM.AppServer.SiteID%Reports

set httpServer=%PLM.AppServer.ServerIPAddress%

echo *********************************************************************
echo Updating the data in the empty database.....
echo setup_updatedata.bat %svr% %usr% %pwd% %catalog% %dbServer% %dashFolder% %biFolder% %reportFolder% %httpServer% >> cli.log

REM Thank M$
shift
shift
shift

echo (cont...) %biFolder% %reportFolder% %httpServer%
set rsServer=%biFolder%
set rsvdir=%reportFolder%

set V=%PLM.AppServer.SiteID%

REM ==================================================
REM Update Dashbord paths
REM ==================================================

echo UPDATE rDashFolderItem > update_data.sql
echo   SET    DashFolderItemURL = '/%dashFolder%/' + DashFolderItemServerReportName; >> update_data.sql

echo UPDATE rDashFolderItem >> update_data.sql
echo   SET    DashFolderItemServerURL = 'http://%rsServer%/%rsvdir%'; >> update_data.sql

echo UPDATE rDashFolderItem >> update_data.sql
echo   SET    DashFolderItemServerFolderName = '%biFolder%'; >> update_data.sql

REM ==================================================
REM Update Report folder paths
REM ==================================================

echo UPDATE rReportFolderItem >> update_data.sql
echo   SET    ReportItemURL = '../Report/Report_Main.aspx?R=/%reportFolder%/' + ReportFormName; >> update_data.sql

REM ==================================================
REM Update rReportSetting table
REM ==================================================

echo UPDATE rReportSetting >> update_data.sql
echo   SET    SettingValue = 'http://%rsServer%/%rsvdir%' >> update_data.sql
echo   WHERE  SettingType = 'ReportServer'; >> update_data.sql

REM --
REM echo UPDATE rReportSetting >> update_data.sql
REM echo   SET    SettingValue = 'http://%httpServer%/plmOn%V%Image' >> update_data.sql
REM echo   WHERE  SettingType = 'ImagePath'; >> update_data.sql

REM --
REM echo UPDATE rReportSetting >> update_data.sql
REM echo   SET    SettingValue = 'http://%httpServer%/plmOn%V%ImageCare' >> update_data.sql
REM echo   WHERE  SettingType = 'ImageCarePath'; >> update_data.sql

REM --
REM echo UPDATE rReportSetting >> update_data.sql
REM echo   SET    SettingValue = 'http://%httpServer%/plmOn%V%ImagePOM' >> update_data.sql
REM echo   WHERE  SettingType = 'ImagePOMPath'; >> update_data.sql

REM --
REM echo UPDATE rReportSetting >> update_data.sql
REM echo   SET    SettingValue = 'http://%httpServer%/plmOn%V%Sample' >> update_data.sql
REM echo   WHERE  SettingType = 'ImageSamplePath'; >> update_data.sql

REM --
REM echo UPDATE rReportSetting >> update_data.sql
REM echo   SET    SettingValue = 'http://%httpServer%/plmOn%V%ImageColor' >> update_data.sql
REM echo   WHERE  SettingType = 'ImageColorPath'; >> update_data.sql

REM --
REM echo UPDATE rReportSetting >> update_data.sql
REM echo   SET    SettingValue = 'http://%httpServer%/plmOn%V%Report/Image' >> update_data.sql
REM echo   WHERE  SettingType = 'ImageReportPath'; >> update_data.sql

echo UPDATE rReportSetting >> update_data.sql
echo   SET    SettingValue = 'http://%httpServer%/plmOn%V%ImageServer' >> update_data.sql
echo   WHERE  SettingType = 'ImageServer'; >> update_data.sql

echo UPDATE rReportSetting >> update_data.sql
echo   SET    SettingValue = 'http://%httpServer%/plmOn%V%' >> update_data.sql
echo   WHERE  SettingType = 'plmOnServer'; >> update_data.sql

REM ==================================================
REM Update AspNet_SqlCacheTablesForChangeNotification table
REM ==================================================

echo DELETE from AspNet_SqlCacheTablesForChangeNotification >> update_data.sql

OSQL -S %svr% -U %usr% -P %pwd% -d %catalog% -i update_data.sql
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

del update_data.sql
IF EXIST update_data.sql Goto ErrorLabel

goto EndLabel
 
:ErrorLabel
EXIT /b 1
 
:EndLabel

echo Done!
echo *********************************************************************
