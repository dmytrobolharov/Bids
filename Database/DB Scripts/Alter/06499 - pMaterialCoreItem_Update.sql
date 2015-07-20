UPDATE pMaterialCoreItem SET Qty = REPLACE(Qty, ',', '.')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06499', GetDate())
GO
