IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='WorkFlowItemID' AND TABLE_NAME='pSampleRequestBOMTrade')
BEGIN
	ALTER TABLE pSampleRequestBOMTrade	ADD WorkFlowItemID uniqueIdentifier NULL
END 

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleBOMDimensionID' AND TABLE_NAME='pSampleRequestBOMTrade')
BEGIN
	ALTER TABLE pSampleRequestBOMTrade	ADD StyleBOMDimensionID uniqueIdentifier NULL
END 

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleBOMDimensionItemID' AND TABLE_NAME='pSampleRequestBOMTrade')
BEGIN
	ALTER TABLE pSampleRequestBOMTrade	ADD StyleBOMDimensionItemID uniqueIdentifier NULL
END 

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02962'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02962', GetDate())
END
GO