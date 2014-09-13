IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pAMLMeasHdr' and COLUMN_NAME = N'ImageId')
       BEGIN 
            ALTER TABLE pAMLMeasHdr DROP COLUMN ImageId
       END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '759', GetDate())

GO