IF NOT EXISTS (SELECT * FROM   sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[pImageCatalog]') AND name = 'PlanningID')
BEGIN 
	ALTER TABLE dbo.pImageCatalog ADD PlanningID uniqueidentifier NULL
END
GO

IF NOT EXISTS (SELECT * FROM   sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[pImageCatalog]') AND name = 'SeasonYearID')
BEGIN 
	ALTER TABLE dbo.pImageCatalog ADD SeasonYearID uniqueidentifier NULL
END
GO

IF NOT EXISTS (SELECT * FROM   sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[pImageCatalog]') AND name = 'Sort')
BEGIN 
	ALTER TABLE dbo.pImageCatalog ADD Sort int NULL
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08143', GetDate())
GO