IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleMaterialTemp' and COLUMN_NAME = N'MaterialCoreItemID')
       BEGIN 
            ALTER TABLE pStyleMaterialTemp ADD MaterialCoreItemID UNIQUEIDENTIFIER Null
       END
GO




