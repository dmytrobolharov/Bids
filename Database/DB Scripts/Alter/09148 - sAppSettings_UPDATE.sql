Update sAppSetting Set AppSettingValue = 'FALSE' where AppSettingKey = 'Silhouette_Only' and ConfigFileName = 'Style.Config'
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '6.0.0001', '09148', GetDate())
GO