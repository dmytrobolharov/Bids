@echo off 

call ../../Setup/plugins/scripts/environ.bat

set svr=%PLM.RSServer.ServerName%
set usr=%PLM.RSServer.UserName%
set pwd=%PLM.RSServer.UserPassword%
set ins=%PLM.RSServer.ServerVDir%

set con="%PLM.DBServer.ConnectionString%"

set rep=%PLM.RSServer.EnableREP%
set dash=%PLM.RSServer.EnableDASH%
set bi=%PLM.RSServer.EnableBI%

set cnn=%PLM.RSServer.EnableCNN%

shift
set wsid=%PLM.AppServer.SiteID%

echo publish.bat %svr% %usr% %pwd% %ins% %con% %rep% %dash% %bi% %cnn% %wsid% >> cli.log

REM ==================================================================
REM Edit These variables to suit your environment
REM ==================================================================

set report_server=http://%svr%/%ins%
set username=%svr%\%usr%
set password=%pwd%
set reportFolder=plmOn%wsid%Reports
set dashFolder=plmOn%wsid%Dashboards
set biFolder=YuniqueBI%wsid%

set datasource=plmOn
set conn_string=%con%

REM ==================================================================
REM **** DO NOT ***  Edit below this line
REM ==================================================================

set reports_dir=..\plmOnSQLReports2005
set reports_dir2=..\plmOnSQLReports2008
set dashboard_dir=..\plmOnSQLDashboard2008
set bi_dir=..\YuniqueBI
set report_script_template=..\RSSBatchUploadScript\plmOnSQLReports2005.rss.tmpl
set report_script=..\RSSBatchUploadScript\plmOnSQLReports2005.rss

REM
REM Creating script file...
REM

echo Creating RSS script file....
copy %report_script_template% %report_script%

set translated_reports_dir=..\plmOnSQLReports2005\TranslatedReports
set report_script_for_reports=..\..\RSSBatchUploadScript\plmOnSQLReports2005.rss
IF EXIST %translated_reports_dir%\ GOTO skipReports_Dir
set translated_reports_dir=%reports_dir%
set report_script_for_reports=..\RSSBatchUploadScript\plmOnSQLReports2005.rss
:skipReports_Dir

set translated_reports_dir2=..\plmOnSQLReports2008\TranslatedReports
set report_script_for_reports2=..\..\RSSBatchUploadScript\plmOnSQLReports2005.rss
IF EXIST %translated_reports_dir2%\ GOTO skipReports_Dir2
set translated_reports_dir2=%reports_dir2%
set report_script_for_reports2=..\RSSBatchUploadScript\plmOnSQLReports2005.rss
:skipReports_Dir2

set translated_reportsBI_dir=..\YuniqueBI\TranslatedReports
set report_script_for_reportsBI=..\..\RSSBatchUploadScript\plmOnSQLReports2005.rss
IF EXIST %translated_reportsBI_dir%\ GOTO skipReportsBI_Dir
set translated_reportsBI_dir=%bi_dir%
set report_script_for_reportsBI=..\RSSBatchUploadScript\plmOnSQLReports2005.rss
:skipReportsBI_Dir

set translated_dashboard_dir=..\plmOnSQLDashboard2008\TranslatedReports
set report_script_for_dashboard=..\..\RSSBatchUploadScript\plmOnSQLReports2005.rss
IF EXIST %translated_dashboard_dir%\ GOTO skipDashboard_dir
set translated_dashboard_dir=%dashboard_dir%
set report_script_for_dashboard=..\RSSBatchUploadScript\plmOnSQLReports2005.rss
:skipDashboard_dir

echo Dim parentFolder As String = "%reportFolder%" >> %report_script%
echo Dim parentPath As String = "/" + parentFolder >> %report_script%
echo Dim parentDashFolder As String = "%dashFolder%" >> %report_script%
echo Dim parentDashPath As String = "/" + parentDashFolder >> %report_script%
echo Dim parentBIFolder As String = "%biFolder%" >> %report_script%
echo Dim parentBIPath As String = "/" + parentBIFolder >> %report_script%

echo Dim datasourcename1 As String = "%datasource%" >> %report_script%
echo Dim strconnection1 As String = %conn_string% >> %report_script%
echo. >> %report_script%

REM ===================[ D A T A S O U R C E S ]=========================

echo Public Sub CreateDatasources() >> %report_script%
if NOT "%cnn%" == "yes" goto skipConn
    echo CreateSampleDataSource(parentPath, datasourcename1, strconnection1) >> %report_script%
    echo CreateSampleDataSource(parentDashPath, datasourcename1, strconnection1) >> %report_script%
    echo CreateSampleDataSource(parentBIPath, datasourcename1, strconnection1) >> %report_script%
:skipConn
echo End Sub >> %report_script%

REM ===================[ R E P O R T S ]=======================

echo Public Sub PublishReports() >> %report_script%

if NOT "%rep%" == "yes" goto skipRep
echo    ''' REPORTS >> %report_script%
forfiles -p %translated_reports_dir% -m *.rdl -c "CMD /C echo    PublishReport("@FNAME", "@PATH") >> %report_script_for_reports%"
IF %ERRORLEVEL% GTR 1 goto ErrorLabel

forfiles -p %reports_dir% -m *.jpg -c "CMD /C echo    PublishReportImage("@FILE", "@PATH") >> %report_script%"
IF %ERRORLEVEL% GTR 1 goto ErrorLabel

forfiles -p %reports_dir% -m *.gif -c "CMD /C echo    PublishReportImage("@FILE", "@PATH") >> %report_script%"
IF %ERRORLEVEL% GTR 1 goto ErrorLabel

forfiles -p %reports_dir% -m *.png -c "CMD /C echo    PublishReportImage("@FILE", "@PATH") >> %report_script%"
IF %ERRORLEVEL% GTR 1 goto ErrorLabel

forfiles -p %translated_reports_dir2% -m *.rdl -c "CMD /C echo    PublishReport("@FNAME", "@PATH") >> %report_script_for_reports2%"
IF %ERRORLEVEL% GTR 1 goto ErrorLabel

forfiles -p %reports_dir2% -m *.jpg -c "CMD /C echo    PublishReportImage("@FILE", "@PATH") >> %report_script%"
IF %ERRORLEVEL% GTR 1 goto ErrorLabel

forfiles -p %reports_dir2% -m *.gif -c "CMD /C echo    PublishReportImage("@FILE", "@PATH") >> %report_script%"
IF %ERRORLEVEL% GTR 1 goto ErrorLabel

forfiles -p %reports_dir2% -m *.png -c "CMD /C echo    PublishReportImage("@FILE", "@PATH") >> %report_script%"
IF %ERRORLEVEL% GTR 1 goto ErrorLabel
:skipRep


if NOT "%dash%" == "yes" goto skipDash
echo    ''' DASHBOARD >> %report_script%
REM forfiles -p %dashboard_dir% -m *.rdl -c "CMD /C echo    PublishDashboard("@FNAME", "@PATH") >> %report_script%"
forfiles -p %translated_dashboard_dir% -m *.rdl -c "CMD /C echo    PublishDashboard("@FNAME", "@PATH") >> %report_script_for_dashboard%"
IF %ERRORLEVEL% GTR 1 goto ErrorLabel

forfiles -p %dashboard_dir% -m *.jpg -c "CMD /C echo    PublishDashboardImage("@FILE", "@PATH") >> %report_script%"
IF %ERRORLEVEL% GTR 1 goto ErrorLabel

forfiles -p %dashboard_dir% -m *.gif -c "CMD /C echo    PublishDashboardImage("@FILE", "@PATH") >> %report_script%"
IF %ERRORLEVEL% GTR 1 goto ErrorLabel

forfiles -p %dashboard_dir% -m *.png -c "CMD /C echo    PublishDashboardImage("@FILE", "@PATH") >> %report_script%"
IF %ERRORLEVEL% GTR 1 goto ErrorLabel
:skipDash


if NOT "%bi%" == "yes" goto skipBI
echo    ''' YUNIQUE_BI >> %report_script%
REM forfiles -p %bi_dir% -m *.rdl -c "CMD /C echo    PublishBI("@FNAME", "@PATH") >> %report_script%"
forfiles -p %translated_reportsBI_dir% -m *.rdl -c "CMD /C echo    PublishBI("@FNAME", "@PATH") >> %report_script_for_reportsBI%"
IF %ERRORLEVEL% GTR 1 goto ErrorLabel

forfiles -p %bi_dir% -m *.jpg -c "CMD /C echo    PublishBIImage("@FILE", "@PATH") >> %report_script%"
IF %ERRORLEVEL% GTR 1 goto ErrorLabel

forfiles -p %bi_dir% -m *.gif -c "CMD /C echo    PublishBIImage("@FILE", "@PATH") >> %report_script%"
IF %ERRORLEVEL% GTR 1 goto ErrorLabel

forfiles -p %bi_dir% -m *.png -c "CMD /C echo    PublishBIImage("@FILE", "@PATH") >> %report_script%"
IF %ERRORLEVEL% GTR 1 goto ErrorLabel
:skipBI

echo End Sub >> %report_script%

REM
REM Publishing reports
REM

echo Publishing all reports.....
rs.exe -i "%CD%\plmOnSQLReports2005.rss" -s %report_server%  -u %username% -p %password% >> cli.log
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

goto EndLabel
 
:ErrorLabel
EXIT /b 1
 
:EndLabel