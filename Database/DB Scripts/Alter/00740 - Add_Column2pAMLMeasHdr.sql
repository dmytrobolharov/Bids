IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pAMLMeasHdr' and COLUMN_NAME = N'WorkFlowItemId')
       BEGIN 
            ALTER TABLE pAMLMeasHdr ADD WorkFlowItemId uniqueidentifier NULL
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pAMLMeasHdr' and COLUMN_NAME = N'ImageId')
       BEGIN 
            ALTER TABLE pAMLMeasHdr ADD ImageId uniqueidentifier NULL
       END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '740', GetDate())

GO