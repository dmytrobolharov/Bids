
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRPOMCompany' and COLUMN_NAME = N'ImageId')
       BEGIN 
             ALTER TABLE pGRPOMCompany ADD ImageId uniqueidentifier NULL
       END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '921', GetDate())
GO

