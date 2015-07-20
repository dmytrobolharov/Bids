IF NOT EXISTS(SELECT * FROM information_schema.columns c WHERE c.table_name = 'pControlBOMConfig' AND c.column_name = 'AutoSetSize')
	ALTER TABLE pControlBOMConfig ADD AutoSetSize BIT DEFAULT 1
GO

UPDATE pControlBOMConfig SET AutoSetSize = 1
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09936', GetDate())
GO
