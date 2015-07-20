IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='sAppSetting' AND COLUMN_NAME='AppSettingDescription')
BEGIN
	ALTER TABLE sAppSetting ADD AppSettingDescription NVARCHAR(MAX) NULL
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05823', GetDate())
GO
