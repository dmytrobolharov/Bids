IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pGRProductCompany' 
                                                         AND COLUMN_NAME = N'ProductCompanyId' 
                                                         AND COLUMN_DEFAULT LIKE N'%NewID()%' )
       BEGIN 
            ALTER TABLE pGRProductCompany ADD CONSTRAINT
	                DF_pGRProductCompany_ProductCompanyId DEFAULT NewId() FOR ProductCompanyId
       END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '729', GetDate())
GO
