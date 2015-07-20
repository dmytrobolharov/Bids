IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Users' AND COLUMN_NAME = 'AdobePluginAccess')
BEGIN
	ALTER TABLE Users ADD AdobePluginAccess INT NOT NULL DEFAULT(0)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06493', GetDate())
GO
