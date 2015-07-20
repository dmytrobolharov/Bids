IF NOT EXISTS(SELECT * FROM sys.columns WHERE Name = N'SeasonYearID' AND Object_ID = Object_ID(N'pPlanningDocument'))
BEGIN
	ALTER TABLE dbo.pPlanningDocument ADD SeasonYearID uniqueidentifier NULL
END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08307', GetDate())
GO