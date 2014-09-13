@echo off

IF EXIST ./environ.bat call environ.bat

set iPath="%PLM.Installation.InstallPath%"

echo setup_installIG.bat %iPath% %1 %2 %3 %4 >> cli.log

set igREG=IG.reg

echo Windows Registry Editor Version 5.00 > %igREG%
echo [HKEY_LOCAL_MACHINE\SOFTWARE\WebSupergoo\ImageGlueNET] >> %igREG%
echo [HKEY_LOCAL_MACHINE\SOFTWARE\WebSupergoo\ImageGlueNET\6] >> %igREG%
echo "RegKey"=hex:00,00,00,00,03,00,00,00,cc,93,e1,6f,6b,5b,cb,01,cc,13,46,68,fe,72,\ >> %igREG%
echo   cb,01 >> %igREG%
echo "LicenseKey"=hex:32,35,34,2d,33,31,34,2d,33,34,36,2d,37,36,38,2d,39,31,30,35,\ >> %igREG%
echo   2d,38,38,31 >> %igREG%
echo "ColorProfileDirectory"=hex:43,3a,5c,57,69,6e,64,6f,77,73,5c,53,59,53,54,45,4d,\ >> %igREG%
echo   33,32,5c,53,50,4f,4f,4c,5c,44,52,49,56,45,52,53,5c,43,4f,4c,4f,52,5c >> %igREG%
echo "EnableImpersonation"=dword:00000000 >> %igREG%
echo "IJLExport"=dword:00000001 >> %igREG%
echo "IJLImport"=dword:00000001 >> %igREG%
echo "IMExport"=dword:00000001 >> %igREG%
echo "IMImport"=dword:00000001 >> %igREG%
echo "IMInfo"=dword:00000001 >> %igREG%
echo "IPLTransform"=dword:00000001 >> %igREG%
echo "LittleCMS"=dword:00000001 >> %igREG%
echo "LogDirectory"=hex: >> %igREG%
echo "LogErrors"=dword:00000000 >> %igREG%
echo "LogOperations"=dword:00000000 >> %igREG%
echo "LogMaxFileSize"=dword:0000ffff >> %igREG%
echo "MaxOperationTime"=dword:000003e8 >> %igREG%
echo "MaxSize"=dword:00004e20 >> %igREG%
echo "MaxTxtFile"=dword:00001388 >> %igREG%
echo "QTExport"=dword:00000001 >> %igREG%
echo "QTImport"=dword:00000001 >> %igREG%
echo "QTImportMovies"=dword:00000001 >> %igREG%
echo "QTImportMPEG"=dword:00000001 >> %igREG%
echo "QTInfo"=dword:00000001 >> %igREG%
echo "QTInfoMovies"=dword:00000001 >> %igREG%
echo "UseQuickTime"=dword:00000001 >> %igREG%
echo "QTMemoryIP"=dword:00000001 >> %igREG%
echo "QTMemoryOP"=dword:00000001 >> %igREG%
echo "UnloadQuickTime"=dword:00000000 >> %igREG%
echo "UnloadQuickTimePeriod"=dword:00002710 >> %igREG%
echo "JPEGInfo"=dword:00000001 >> %igREG%
echo "EPSFInfo"=dword:00000001 >> %igREG%
echo "EPSFImport"=dword:00000001 >> %igREG%
echo "GDIPlusImport"=dword:00000001 >> %igREG%
echo "APSImport"=dword:00000001 >> %igREG%
echo "PSImport"=dword:00000001 >> %igREG%
echo "PSInfo"=dword:00000001 >> %igREG%

%SYSTEMDRIVE%\WINDOWS\system32\reg.exe import %igREG%
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

mkdir "%SYSTEMDRIVE%\Program Files\YuniquePLM\ImageGlue"
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

copy %iPath%\Vendor\ImageGlue\*.* "%SYSTEMDRIVE%\Program Files\YuniquePLM\ImageGlue\*.*"
..\utils\gacutil.exe /i "%SYSTEMDRIVE%\Program Files\YuniquePLM\ImageGlue\ImageGlue.dll"
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

del %igREG%
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

goto EndLabel

:ErrorLabel
EXIT /b 1
 
:EndLabel
 