ALTER TABLE pMSEvalSampMeas ALTER COLUMN RevisedSpec [numeric](18, 4) NULL
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '967', GetDate())

GO