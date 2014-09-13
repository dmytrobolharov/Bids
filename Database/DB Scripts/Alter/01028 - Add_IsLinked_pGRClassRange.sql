IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRClassRange' and COLUMN_NAME = N'IsLinked')
    BEGIN 
        ALTER TABLE pGRClassRange ADD IsLinked int NULL
    END
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRClassRange' 
                                          and COLUMN_NAME = N'IsLinked'
                                          and COLUMN_DEFAULT LIKE '%0%')
    BEGIN
         ALTER TABLE pGRClassRange ADD CONSTRAINT DF_pGRClassRange_IsLinked DEFAULT 0 FOR IsLinked
    END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01028', GetDate())
GO