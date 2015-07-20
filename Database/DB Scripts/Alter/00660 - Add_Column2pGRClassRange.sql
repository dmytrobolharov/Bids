IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRClassRange' and COLUMN_NAME = N'SizeClassCompanyId')
       BEGIN 
            ALTER TABLE pGRClassRange ADD SizeClassCompanyId uniqueidentifier NULL
       END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '660', GetDate())

GO