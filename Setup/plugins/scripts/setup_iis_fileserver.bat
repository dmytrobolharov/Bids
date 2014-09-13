@echo off

IF EXIST ./environ.bat call environ.bat

echo *****************************************************
echo Setting up fileserver virtual directories.....

set plmOnRootDir="%PLM.Installation.InstallPath%"
set V=%PLM.AppServer.SiteID%

echo setup_iis_fileserver.bat %plmOnRootDir% %V% >> cli.log

call create_vdir.bat plmOn%V%Download %plmOnRootDir%\Software-Etc\Store\Download
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

REM These are no longer necessary
rem call create_vdir.bat plmOn%V%Image %plmOnRootDir%\Software-Etc\Store\Images\Thumb
rem call create_vdir.bat plmOn%V%ImageCare %plmOnRootDir%\Software-Etc\Store\Images\Care
rem call create_vdir.bat plmOn%V%ImageColor %plmOnRootDir%\Software-Etc\Store\Images\Color
rem call create_vdir.bat plmOn%V%ImagePOM %plmOnRootDir%\Software-Etc\Store\Images\POM\Thumbnail
rem call create_vdir.bat plmOn%V%Sample %plmOnRootDir%\Software-Etc\Store\Sample

call create_vdir.bat srmOn%V%Download %plmOnRootDir%\Software-Etc\Store\Download
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

goto EndLabel
 
:ErrorLabel
EXIT /b 1
 
:EndLabel

echo Done!
echo *****************************************************

