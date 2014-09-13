@echo off

IF EXIST ./environ.bat call environ.bat

echo *****************************************************
echo Setting up application server virtual dirs, and application pools...

set plmOnRootDir="%PLM.Installation.InstallPath%"
set V=%PLM.AppServer.SiteID%

echo setup_iis_appserver.bat %plmOnRootDir% %V% >> cli.log

if NOT "%PLM.Installation.InstallComponent_SRM%" == "yes" goto skipSRM
  call create_apool.bat srmOn%V%
  IF %ERRORLEVEL% NEQ 0 goto ErrorLabel
  call create_app.bat srmOn%V% srmOn%V% %plmOnRootDir%\Software\Application\srmOn2
  IF %ERRORLEVEL% NEQ 0 goto ErrorLabel
:skipSRM

if NOT "%PLM.Installation.InstallComponent_PLM%" == "yes" goto skipPLM
  call create_apool.bat plmOn%V%
  IF %ERRORLEVEL% NEQ 0 goto ErrorLabel
  call create_app.bat plmOn%V% plmOn%V% %plmOnRootDir%\Software\Application\plmOn2
  IF %ERRORLEVEL% NEQ 0 goto ErrorLabel


REM =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
REM "Reporting" Sites
REM =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

call create_apool.bat plmOn%V%Report
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel
call create_app.bat plmOn%V%Report plmOn%V%Report %plmOnRootDir%\Software\Application\plmOn2Report
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

call create_apool.bat YuniqueBI%V%
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel
call create_app.bat YuniqueBI%V% YuniqueBI%V% %plmOnRootDir%\Software\Application\YuniqueBI
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

call create_apool.bat plmOn%V%Dashboard
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel
call create_app.bat plmOn%V%Dashboard plmOn%V%Dashboard %plmOnRootDir%\Software\Application\plmOnDashboard
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

REM =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
REM Web/File/Image Services
REM =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

call create_apool.bat plmOn%V%WebServices
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel
call create_app.bat plmOn%V%WebServices plmOn%V%WebServices %plmOnRootDir%\Software\Application\plmOnWebServices
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

call create_apool.bat plmOn%V%ImageServices
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel
call create_app.bat plmOn%V%ImageServer plmOn%V%ImageServices %plmOnRootDir%\Software\Application\plmOnFileServices
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

call create_apool.bat plmOn%V%FileServices
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel
call create_app.bat plmOn%V%FileServices plmOn%V%FileServices %plmOnRootDir%\Software\Application\plmOnFileServices
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

REM =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
REM Toolkit Related Sites
REM =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
call create_apool.bat YuniqueToolkit%V%
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel
call create_app.bat YuniqueToolkit%V% YuniqueToolkit%V% %plmOnRootDir%\Software\Application\YuniqueToolkit
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel


call create_apool.bat Yunique.Toolkit%V%.API
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel
call create_app.bat Yunique.Toolkit%V%.API Yunique.Toolkit%V%.API %plmOnRootDir%\Software\Application\Yunique.Toolkit.API
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

REM =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
REM Yunique API Services
REM =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

call create_apool.bat YuniqueAPI%V%
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel
call create_app.bat YuniqueAPI%V% YuniqueAPI%V% %plmOnRootDir%\Software\Application\YuniqueAPI
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

call create_apool.bat YuniqueAPI%V%.SOAP
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel
call create_app.bat YuniqueAPI%V%.SOAP YuniqueAPI%V%.SOAP %plmOnRootDir%\Software\Application\Yunique.API.Soap
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

call create_apool.bat YuniqueAPI%V%.Rest
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel
call create_app.bat YuniqueAPI%V%.Rest YuniqueAPI%V%.Rest %plmOnRootDir%\Software\Application\Yunique.API.Rest
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

:skipPLM

REM =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
REM No longer used
REM =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
REM call create_apool.bat YuniqueAppManager%V%
REM IF %ERRORLEVEL% NEQ 0 goto ErrorLabel
REM call create_app.bat YuniqueAppManager%V% YuniqueAppManager%V% %plmOnRootDir%\Software\Application\YuniqueAppManager
REM IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

goto EndLabel

:ErrorLabel
EXIT /b 1
 
:EndLabel

echo Done!
echo *****************************************************

