IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pMaterialRequestSubmitWorkflow' AND COLUMN_NAME = 'RevisedStart')
BEGIN
	ALTER TABLE pMaterialRequestSubmitWorkflow ADD RevisedStart DATE
END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pMaterialRequestSubmitWorkflow' AND COLUMN_NAME = 'RevisedEnd')
BEGIN
	ALTER TABLE pMaterialRequestSubmitWorkflow ADD RevisedEnd DATE
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08638', GetDate())
GO
