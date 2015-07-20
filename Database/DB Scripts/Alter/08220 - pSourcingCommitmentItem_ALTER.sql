IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pSourcingCommitmentItem' AND COLUMN_NAME = 'StyleSKUItemID')
BEGIN
	ALTER TABLE pSourcingCommitmentItem ADD StyleSKUItemID UNIQUEIDENTIFIER
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08220', GetDate())
GO
