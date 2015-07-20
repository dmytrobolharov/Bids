IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pAMLMeasPOM' and COLUMN_NAME = N'IsLinked')
       BEGIN 
            ALTER TABLE pAMLMeasPOM ADD IsLinked int NULL
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pAMLMeasPOM' 
                                          and COLUMN_NAME = N'IsLinked'
                                          and COLUMN_DEFAULT LIKE '%0%')
    BEGIN
         ALTER TABLE pAMLMeasPOM ADD CONSTRAINT DF_pAMLMeasPOM_IsLinked DEFAULT 0 FOR IsLinked
    END
GO


IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pAMLMeasPOM' and COLUMN_NAME = N'Critical')
       BEGIN 
            ALTER TABLE pAMLMeasPOM ADD Critical int NULL
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pAMLMeasPOM' 
                                          and COLUMN_NAME = N'Critical'
                                          and COLUMN_DEFAULT LIKE '%0%')
    BEGIN
         ALTER TABLE pAMLMeasPOM ADD CONSTRAINT DF_pAMLMeasPOM_Critical DEFAULT 0 FOR Critical
    END
GO


IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pAMLMeasPOM' and COLUMN_NAME = N'How2MeasName')
       BEGIN 
            ALTER TABLE pAMLMeasPOM ADD How2MeasName nvarchar(200) NULL
       END
GO

 
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02154'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02154', GetDate())
END	
GO
