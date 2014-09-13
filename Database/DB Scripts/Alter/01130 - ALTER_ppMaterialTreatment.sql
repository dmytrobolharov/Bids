IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pMaterialTreatment' and COLUMN_NAME = N'CustomSort')
    BEGIN 
        ALTER TABLE pMaterialTreatment ADD CustomSort varchar(5) NULL
    END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01130', GetDate())
GO
