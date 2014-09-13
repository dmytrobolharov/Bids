
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRProductCompany' and COLUMN_NAME = N'IsLinked')
       BEGIN 
             ALTER TABLE pGRProductCompany ADD IsLinked Integer NULL
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRSizeClassCompany' and COLUMN_NAME = N'IsLinked')
       BEGIN 
             ALTER TABLE pGRSizeClassCompany ADD IsLinked Integer NULL
       END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '923', GetDate())
GO

