UPDATE sAppSetting set AppSettingValue = '0' WHERE AppSettingKey = 'StyleMenuImageSize'
GO



	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03506', GetDate())


GO

