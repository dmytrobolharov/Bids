IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pTACalTemplateTask' AND COLUMN_NAME = 'TaskStatus')
BEGIN
	ALTER TABLE pTACalTemplateTask ADD TaskStatus INT
END
GO

UPDATE pTACalTemplateTask SET TaskStatus = 1 WHERE TaskStatus IS NULL
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09045', GetDate())
GO
