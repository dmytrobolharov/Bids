IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pMaterialWorkflowPage' AND COLUMN_NAME = 'ActualStart')
BEGIN
	ALTER TABLE pMaterialWorkflowPage ADD ActualStart DATETIME NULL
END
GO

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pMaterialWorkflowPage' AND COLUMN_NAME = 'ActualEnd')
BEGIN
	ALTER TABLE pMaterialWorkflowPage ADD ActualEnd DATETIME NULL
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08623', GetDate())
GO
