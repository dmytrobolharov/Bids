IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRPOM' and COLUMN_NAME = N'CompanyGuidIdXXX')
       BEGIN
            EXEC sp_rename 'pGRPOM.CompanyGuidIdXXX', 'CompanyGuidId', 'COLUMN';
       END

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '668', GetDate())

GO