REM s@echo off

IF EXIST ./environ.bat call environ.bat

set mspath=%SYSTEMDRIVE%\Program Files\YuniquePLM\ChilkatSmtpQ
set qpath=%PLM.Mail.QueueFolder%
set qpath2=%PLM.Mail.QueueFolderDblSlash%
set dosave=%PLM.Mail.SaveSentMessages%
set threads=20

IF EXIST %mspath%\ChilkatSmtpQ.exe goto skipMailInstall

echo *****************************************
echo Installing plmOnMS....
echo setup_installmailservice.bat "%mspath%" "%qpath%" "%qpath2%" %dosave% >> cli.log

REM Create a .reg file to import?

echo Windows Registry Editor Version 5.00 > smtpq.reg
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Chilkat Software, Inc.\SmtpQ] >> smtpq.reg
echo "QueueDir"="%qpath2%\\queue" >> smtpq.reg
echo "UndelivDir"="%qpath2%\\undeliverable" >> smtpq.reg
echo "SentDir"="%qpath2%\\sent" >> smtpq.reg
echo "LogDir"="%qpath2%\\Log" >> smtpq.reg
echo "SaveSent"="%dosave%" >> smtpq.reg
echo "MaxThreads"="%threads%" >> smtpq.reg

mkdir "%qpath%\queue"
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

mkdir "%qpath%\undeliverable"
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

mkdir "%qpath%\sent"
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

mkdir "%qpath%\Log"
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

echo "registry entries"
%SYSTEMDRIVE%\WINDOWS\system32\reg.exe import smtpq.reg
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

echo "register dlls"
echo %SYSTEMDRIVE%\WINDOWS\system32\regsvr32.exe /s "%mspath%\ChilkatUtil.dll"
%SYSTEMDRIVE%\WINDOWS\system32\regsvr32.exe /s "%mspath%\ChilkatUtil.dll"
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

echo %SYSTEMDRIVE%\WINDOWS\system32\regsvr32.exe /s "%mspath%\SmtpQMgr.dll"
%SYSTEMDRIVE%\WINDOWS\system32\regsvr32.exe /s "%mspath%\SmtpQMgr.dll"
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

echo "service install"
%SYSTEMDRIVE%\WINDOWS\system32\sc.exe create ChilkatSmtpQ binPath= "%mspath%\ChilkatSmtpQ.exe" start= auto DisplayName= "YuniquePLM Chilkat SMTPQ"
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

%SYSTEMDRIVE%\WINDOWS\system32\sc.exe start ChilkatSmtpQ
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

REM del smtpq.reg
REM IF %ERRORLEVEL% NEQ 0 goto ErrorLabel

goto EndLabel
 
:ErrorLabel
echo %ERRORLEVEL%
EXIT /b 1
 
:skipMailInstall
:EndLabel

echo Done!
echo ******************************************
