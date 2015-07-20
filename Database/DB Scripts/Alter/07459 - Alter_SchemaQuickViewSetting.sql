
update sAppSetting
set AppSettingValue = '/ClientSetup/YuniquePLM.Toolkit.Portable.application'
where AppSettingKey = 'YuniqueToolkitSchemaQuickView'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '07459', GetDate())
GO