@echo off

IF EXIST ./environ.bat call environ.bat

set fps=%PLM.Firewall.EnableFilePrinterSharing%
set rdp=%PLM.Firewall.EnableRemoteDesktop%
set web=%PLM.Firewall.EnableHTTP%
set sql=%PLM.Firewall.EnableSQLServer%
set png=%PLM.Firewall.EnableCMPEcho%

if "%fps%" == "no" goto skipFPS
REM File and Printer
netsh advfirewall firewall set rule group=”File and Printer Sharing” new enable=Yes
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel
:skipFPS

if "%rdp%" == "no" goto skipRDP
REM Remote Desktop
netsh advfirewall firewall set rule group="remote desktop" new enable=Yes
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel
:skipRDP

if "%web%" == "no" goto skipWEB
REM Web Server
netsh advfirewall firewall add rule name=”HTTP (In)” dir=in action=allow protocol=TCP localport=80
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel
:skipWEB

if "%sql%" == "no" goto skipSQL
REM SQL Server
netsh advfirewall firewall add rule name=”SQL Server (Data)” dir=in action=allow protocol=TCP localport=1433
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel
netsh advfirewall firewall add rule name=”SQL Server (Browse)” dir=in action=allow protocol=UDP localport=1434
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel
:skipSQL

if "%png%" == "no" goto skipPNG
REM Reply to Ping (ICMP Echo Request)
netsh advfirewall firewall add rule name=”ICMP Allow incoming V4 echo request” protocol=icmpv4:8,any dir=in action=allow
IF %ERRORLEVEL% NEQ 0 goto ErrorLabel
:skipPNG

goto EndLabel 

:ErrorLabel
EXIT /b 1
 
:EndLabel