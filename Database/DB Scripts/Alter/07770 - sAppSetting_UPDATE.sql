UPDATE sAppSetting SET AppSettingValue='FALSE' WHERE ConfigFileName='LinePlan.config' AND AppSettingKey='AllowMultiCloth' 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07770', GetDate())
GO