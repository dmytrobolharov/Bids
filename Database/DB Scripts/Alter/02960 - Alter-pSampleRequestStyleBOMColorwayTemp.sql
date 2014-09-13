IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='WorkFlowItemID' AND TABLE_NAME='pSampleRequestStyleBOMColorwayTemp')
BEGIN
	ALTER TABLE pSampleRequestStyleBOMColorwayTemp ADD WorkFlowItemID uniqueIdentifier NULL
END 

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleBOMDimensionID' AND TABLE_NAME='pSampleRequestStyleBOMColorwayTemp')
BEGIN
	ALTER TABLE pSampleRequestStyleBOMColorwayTemp	ADD StyleBOMDimensionID uniqueIdentifier NULL
END 

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='StyleBOMDimensionItemID' AND TABLE_NAME='pSampleRequestStyleBOMColorwayTemp')
BEGIN
	ALTER TABLE pSampleRequestStyleBOMColorwayTemp	ADD StyleBOMDimensionItemID uniqueIdentifier NULL
END 

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02960'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02960', GetDate())
END
GO