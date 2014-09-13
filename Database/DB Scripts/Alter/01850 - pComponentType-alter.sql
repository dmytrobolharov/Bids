IF  NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pComponentType' and COLUMN_NAME = N'ComponentStyleBOMSchema')
       BEGIN 
            ALTER TABLE pComponentType ADD ComponentStyleBOMSchema nvarchar(200) NULL
       END
GO


UPDATE pComponentType SET ComponentStyleBOMSchema = REPLACE(ComponentStyleSchema, '_Style_' , '_StyleBOM_' ) WHERE ComponentStyleBOMSchema IS NULL
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01850'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '4.1.0000', '01850', GetDate())
	END

	GO