IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pMaterial' AND COLUMN_NAME = 'IntroSeasonYearID')
BEGIN
	ALTER TABLE pMaterial ADD IntroSeasonYearID UNIQUEIDENTIFIER NULL
END
GO

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pMaterial' AND COLUMN_NAME = 'TACalTemplateId')
BEGIN
	ALTER TABLE pMaterial ADD TACalTemplateId UNIQUEIDENTIFIER NULL
END
GO

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pMaterial' AND COLUMN_NAME = 'EnableProductPages')
BEGIN
	ALTER TABLE pMaterial ADD EnableProductPages INT NULL
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08622', GetDate())
GO
