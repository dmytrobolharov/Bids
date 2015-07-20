@echo off

REM !!! Edit These !!!
set datasource=mySQLServer_Name_here
set catalog=myDatabase_Name_Here
set user=My_UserName_Goes_Here
set pwd=MyPassword_Goes_Here

@echo on

REM !!! ************************
REM !!! Delete the old log files
REM !!! ************************

del log.txt
del sis.txt

forfiles -m *table_updates*.sql -c "CMD /C Run_A_Script.bat %datasource% %catalog% %user% %pwd% @FILE >> log.txt"
forfiles -m *measurement_scripts_for_plmon_structures*.sql -c "CMD /C Run_A_Script.bat %datasource% %catalog% %user% %pwd% @FILE >> log.txt"
forfiles -m *Create_View_vwx_UnFlattenedPOMS*.sql -c "CMD /C Run_A_Script.bat %datasource% %catalog% %user% %pwd% @FILE >> log.txt"
forfiles -m *Conversion_procedures*.sql -c "CMD /C Run_A_Script.bat %datasource% %catalog% %user% %pwd% @FILE >> log.txt"
forfiles -m *Execute_Conversion*.sql -c "CMD /C Run_A_Script.bat %datasource% %catalog% %user% %pwd% @FILE >> log.txt"
forfiles -m *Drop_View_vwx_UnFlattenedPOMS*.sql -c "CMD /C Run_A_Script.bat %datasource% %catalog% %user% %pwd% @FILE >> log.txt"
forfiles -m *Sync_With_Meas*.sql -c "CMD /C Run_A_Script.bat %datasource% %catalog% %user% %pwd% @FILE >> log.txt"

