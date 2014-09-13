@echo off

IF EXIST ./environ.bat call environ.bat

set iPath="%PLM.Installation.InstallPath%"

echo setup_installABC.bat %ipath% %1 %2 %3 %4 >> cli.log

set abcREG=ABC.reg

echo Windows Registry Editor Version 5.00 > %abcREG%
echo [HKEY_LOCAL_MACHINE\SOFTWARE\WebSupergoo\ABCpdfNET] >> %abcREG%
echo [HKEY_LOCAL_MACHINE\SOFTWARE\WebSupergoo\ABCpdfNET\4] >> %abcREG%
echo "RegKey"=hex:02,00,00,00,00,00,00,00,44,32,f9,f1,6b,5b,cb,01,44,b2,5d,ea,fe,72,\ >> %abcREG%
echo   cb,01 >> %abcREG%
echo "LicenseKey"=hex:35,32,38,2d,32,39,38,2d,38,34,34,2d,31,31,37,2d,33,36,32,33,\ >> %abcREG%
echo   2d,36,38,39 >> %abcREG%
echo "LogErrors"=dword:00000000 >> %abcREG%

%SYSTEMDRIVE%\WINDOWS\system32\reg.exe import %abcREG%
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

mkdir "%SYSTEMDRIVE%\Program Files\YuniquePLM\ABCPDF"
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

copy %iPath%\Vendor\ABCPDF\*.* "%SYSTEMDRIVE%\Program Files\YuniquePLM\ABCPDF\*.*"
gacutil.exe /i "%SYSTEMDRIVE%\Program Files\YuniquePLM\ABCPDF\ABCPDF.dll"

IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

del %abcREG%
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

goto EndLabel

:ErrorLabel
echo %ERRORLEVEL%
EXIT /b 1
 
:EndLabel