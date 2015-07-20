IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'StitchType' and COLUMN_NAME = N'CustomSort')
       BEGIN 
             ALTER TABLE StitchType ADD CustomSort NVARCHAR(5) NULL
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pMaterialContentType' and COLUMN_NAME = N'CustomSort')
       BEGIN 
             ALTER TABLE pMaterialContentType ADD CustomSort NVARCHAR(5) NULL
       END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pYear' and COLUMN_NAME = N'CustomSort')
       BEGIN 
             ALTER TABLE pYear ADD CustomSort NVARCHAR(5) NULL
       END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '925', GetDate())
GO