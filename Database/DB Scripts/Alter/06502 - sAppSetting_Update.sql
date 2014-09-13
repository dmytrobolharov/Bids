update sAppSetting set AppSettingValue = 'http://IntellimasDomain.com/IntellimasServer/clickoncedeploy/client.application?token=$token$&module=RequestTracker'   where AppSettingKey = 'IntellimasClientUrl'
GO
update sAppSetting set AppSettingValue = 'http://IntellimasDomain.com/IntellimasServer/clickoncedeploy/client.application?token=$token$&module=RTAdminScreen'   where AppSettingKey = 'IntellimasAdminUrl'
GO
update sAppSetting set AppSettingValue = 'http://IntellimasDomain.com/IntellimasServer/clickoncedeploy/client.application?token=$token$&module=ApplyLicense'   where AppSettingKey = 'IntellimasLicenseUrl'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06502', GetDate())
GO
