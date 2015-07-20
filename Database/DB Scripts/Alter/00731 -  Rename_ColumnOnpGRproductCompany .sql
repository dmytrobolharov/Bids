IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRProductCompany' and COLUMN_NAME = N'CompanyId')
       BEGIN
            EXEC sp_rename 'pGRProductCompany.CompanyId', 'CompanyGuidId', 'COLUMN';
       END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '731', GetDate())

GO