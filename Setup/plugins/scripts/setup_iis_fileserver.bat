@echo off

IF EXIST ./environ.bat call environ.bat

echo *****************************************************
echo Setting up fileserver virtual directories.....

set plmOnRootDir="%PLM.Installation.InstallPath%"
set V=%PLM.AppServer.SiteID%

echo setup_iis_fileserver.bat %plmOnRootDir% %V% >> cli.log

if NOT "%PLM.Installation.InstallComponent_PLM%" == "yes" goto skipPLM
  call create_vdir.bat plmOn%V%Download %plmOnRootDir%\Software-Etc\Store\Download
  IF %ERRORLEVEL% NEQ 0 goto ErrorLabel
:skipPLM

if NOT "%PLM.Installation.InstallComponent_SRM%" == "yes" goto skipSRM
  call create_vdir.bat srmOn%V%Download %plmOnRootDir%\Software-Etc\Store\Download
  IF %ERRORLEVEL% NEQ 0 goto ErrorLabel
:skipSRM

goto EndLabel
 
:ErrorLabel
EXIT /b 1
 
:EndLabel

echo Done!
echo *****************************************************

