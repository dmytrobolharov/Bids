IF NOT EXISTS (SELECT * FROM   sys.columns WHERE object_id = OBJECT_ID(N'[dbo].[pPlanning]') AND name = 'PlanningTemplateID')
BEGIN 
	ALTER TABLE dbo.pPlanning ADD PlanningTemplateID uniqueidentifier NULL
END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08236', GetDate())
GO

