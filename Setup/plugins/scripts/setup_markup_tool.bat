@echo off

IF EXIST ./environ.bat call environ.bat

echo *****************************************************
echo Setting up markup tool application server virtual dir, and application pool...

set plmOnRootDir="%PLM.Installation.InstallPath%"
set V=%PLM.AppServer.SiteID%

echo setup_markup_tool.bat %plmOnRootDir% %V% >> cli.log

call create_apool.bat plmOn%V%CodrawMarkup
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel
call create_app.bat plmOn%V%CodrawMarkup plmOn%V%CodrawMarkup %plmOnRootDir%\Software\Application\codrawyuniquemarkup
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

goto EndLabel

:ErrorLabel
EXIT /b 1
 
:EndLabel

echo Done!
echo *****************************************************