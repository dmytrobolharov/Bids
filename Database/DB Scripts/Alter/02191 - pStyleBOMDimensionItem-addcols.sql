IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleBOMDimensionItem' and COLUMN_NAME = N'Amlmeashdrid')
       BEGIN 
            ALTER TABLE pStyleBOMDimensionItem ADD Amlmeashdrid uniqueidentifier NULL
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleBOMDimensionItem' and COLUMN_NAME = N'Sizerangeid')
       BEGIN 
            ALTER TABLE pStyleBOMDimensionItem ADD Sizerangeid uniqueidentifier NULL
       END
GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02191'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02191', GetDate())
END	
GO