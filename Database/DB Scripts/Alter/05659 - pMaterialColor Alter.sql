IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='pMaterialColor' AND COLUMN_NAME='Status')
BEGIN
	ALTER TABLE pMaterialColor
	ADD [Status] nvarchar(100) DEFAULT 'In Progress'
END

GO

UPDATE pMaterialColor SET [Status]= 'In Progress' WHERE [Status] IS NULL

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05659', GetDate())
GO
