IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pComponentType' and COLUMN_NAME = N'ComponentStyleBOMPrintSchema')
       BEGIN 
            ALTER TABLE pComponentType ADD ComponentStyleBOMPrintSchema nvarchar(200) NULL            
       END
GO

update pComponentType set ComponentStyleBOMPrintSchema = ComponentStyleBOMSchema where ComponentStyleBOMPrintSchema is null

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04644', GetDate())
GO
