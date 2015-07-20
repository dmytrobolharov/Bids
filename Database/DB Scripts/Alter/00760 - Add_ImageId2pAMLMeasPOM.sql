IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pAMLMeasPOM' and COLUMN_NAME = N'ImageId')
       BEGIN 
            ALTER TABLE pAMLMeasPOM ADD ImageId UniqueIdentifier Null
       END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '760', GetDate())

GO