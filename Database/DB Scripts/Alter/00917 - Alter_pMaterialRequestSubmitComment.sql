ALTER TABLE pMaterialRequestSubmitComment ALTER COLUMN MaterialRequestSubmitComment [nvarchar](4000) NULL
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '917', GetDate())

GO