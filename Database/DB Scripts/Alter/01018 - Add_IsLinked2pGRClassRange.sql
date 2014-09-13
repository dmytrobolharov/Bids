
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRClassRange' and COLUMN_NAME = N'IsLinked')
       BEGIN 
             ALTER TABLE pGRClassRange ADD IsLinked Integer NULL
       END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01018', GetDate())
GO

