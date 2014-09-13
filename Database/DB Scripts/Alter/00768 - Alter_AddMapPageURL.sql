IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'Mapping' and COLUMN_NAME = N'MapPageUrl')
       BEGIN 
            ALTER TABLE Mapping ADD MapPageUrl [nvarchar](50) NULL
       END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '768', GetDate())

GO