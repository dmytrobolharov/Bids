IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCosting' and COLUMN_NAME = N'StyleBOMDimensionID')
BEGIN 
	ALTER TABLE pStyleCosting 
	ADD StyleBOMDimensionID uniqueidentifier NULL
END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleCosting' and COLUMN_NAME = N'StyleSourcingID')
BEGIN 
	ALTER TABLE pStyleCostingType 
	ADD StyleSourcingID uniqueidentifier NULL
END
GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03149'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03149', GetDate())

END
GO