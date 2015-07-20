IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pSampleRequestSubmitFitVideo' AND COLUMN_NAME = 'FileName')
BEGIN
	ALTER TABLE pSampleRequestSubmitFitVideo ADD FileName NVARCHAR(400)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07210', GetDate())
GO
