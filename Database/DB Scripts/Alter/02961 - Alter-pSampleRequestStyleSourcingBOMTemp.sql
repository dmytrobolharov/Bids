IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='WorkFlowItemID' AND TABLE_NAME='pSampleRequestStyleSourcingBOMTemp')
BEGIN
	ALTER TABLE pSampleRequestStyleSourcingBOMTemp	ADD WorkFlowItemID uniqueIdentifier NULL
END 

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleBOMDimensionID' AND TABLE_NAME='pSampleRequestStyleSourcingBOMTemp')
BEGIN
	ALTER TABLE pSampleRequestStyleSourcingBOMTemp	ADD StyleBOMDimensionID uniqueIdentifier NULL
END 

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleBOMDimensionItemID' AND TABLE_NAME='pSampleRequestStyleSourcingBOMTemp')
BEGIN
	ALTER TABLE pSampleRequestStyleSourcingBOMTemp	ADD StyleBOMDimensionItemID uniqueIdentifier NULL
END 

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02961'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02961', GetDate())
END
GO