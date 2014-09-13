IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pPlanningBusiness' AND COLUMN_NAME = 'PlanningSubCategoryID')
BEGIN
	ALTER TABLE pPlanningBusiness ADD PlanningSubCategoryID UNIQUEIDENTIFIER
END

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pPlanningBusiness' AND COLUMN_NAME = 'PlanningSubCategory')
BEGIN
	ALTER TABLE pPlanningBusiness ADD PlanningSubCategory NVARCHAR(200)
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06846', GetDate())
GO
