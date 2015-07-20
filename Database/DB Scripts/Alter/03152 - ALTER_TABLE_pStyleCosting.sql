IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCosting' and COLUMN_NAME = N'StyleSourcingID')
BEGIN 
	ALTER TABLE pStyleCosting 
	ADD StyleSourcingID uniqueidentifier NULL
END
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCostingType' and COLUMN_NAME = N'StyleSourcingID')
BEGIN 
	ALTER TABLE pStyleCostingType 
	DROP COLUMN StyleSourcingID
END
GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03152'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03152', GetDate())

END
GO