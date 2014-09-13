IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='pSampleRequestSubmitImage'
				AND COLUMN_NAME='LinkedFromImageFolder')
BEGIN
	ALTER TABLE pSampleRequestSubmitImage
	ADD LinkedFromImageFolder INT DEFAULT 0
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06055', GetDate())
GO
