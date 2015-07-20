IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pSourcingCommitmentComment' AND COLUMN_NAME = 'CContactID')
BEGIN
	ALTER TABLE pSourcingCommitmentComment ADD CContactID UNIQUEIDENTIFIER
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06807', GetDate())
GO
