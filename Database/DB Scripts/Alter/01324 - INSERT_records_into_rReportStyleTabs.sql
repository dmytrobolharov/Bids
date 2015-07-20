/*#01*/
IF((SELECT COUNT(*) FROM rReportStyleTabs WHERE SettingType = 'StyleDetail1') = 0)
	BEGIN
		INSERT INTO rReportStyleTabs
		(
			SettingID
			,SettingType
			,SettingValue
		)
		VALUES
		(
			'1'
			,'StyleDetail1'
			,'Style Detail'
		)	
	END


/*#02*/
IF((SELECT COUNT(*) FROM rReportStyleTabs WHERE SettingType = 'StyleDetail2') = 0)
	BEGIN
		INSERT INTO rReportStyleTabs
		(
			SettingID
			,SettingType
			,SettingValue
		)
		VALUES
		(
			'2'
			,'StyleDetail2'
			,'Buyer Notes'
		)	
	END


/*#03*/
IF((SELECT COUNT(*) FROM rReportStyleTabs WHERE SettingType = 'StyleDetail3') = 0)
	BEGIN
		INSERT INTO rReportStyleTabs
		(
			SettingID
			,SettingType
			,SettingValue
		)
		VALUES
		(
			'3'
			,'StyleDetail3'
			,'Commercial Invoice'
		)	
	END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01324', GetDate())
GO