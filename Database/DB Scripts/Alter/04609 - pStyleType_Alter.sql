
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleType' and COLUMN_NAME = N'StyleSchemaCoverPrint')
       BEGIN 
			
            ALTER TABLE pStyleType ADD StyleSchemaCoverPrint nvarchar(200) NULL

       END

GO

Update pStyleType set StyleSchemaCoverPrint = StyleSchemaPrint

GO

Update pStyleType set StyleSchemaCoverPrint = 'Style_Cover_Apparel.xml' where StyleSchemaCoverPrint = 'Style_Header_Apparel.xml'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04609', GetDate())
GO