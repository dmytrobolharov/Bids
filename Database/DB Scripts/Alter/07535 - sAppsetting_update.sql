UPDATE sAppSetting set AppSettingValue = '350'
WHERE     ConfigFileName = 'Report.config'
AND AppSettingKey = 'AspxSampleReportHeight'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '07535', GetDate())
GO
