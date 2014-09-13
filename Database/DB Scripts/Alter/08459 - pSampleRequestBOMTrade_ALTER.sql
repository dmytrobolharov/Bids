IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pSampleRequestTrade' AND COLUMN_NAME = 'EnableSampleRequestPages')
BEGIN
	ALTER TABLE pSampleRequestTrade ADD EnableSampleRequestPages INT
END

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pSampleRequestBOMTrade' AND COLUMN_NAME = 'EnableSampleRequestPages')
BEGIN
	ALTER TABLE pSampleRequestBOMTrade ADD EnableSampleRequestPages INT
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08459', GetDate())
GO
