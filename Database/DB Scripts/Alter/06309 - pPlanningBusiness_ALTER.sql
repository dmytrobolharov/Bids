IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pPlanningBusiness' AND COLUMN_NAME = 'PlanningBrandID')
begin
	ALTER TABLE pPlanningBusiness ADD PlanningBrandID UNIQUEIDENTIFIER
end

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pPlanningBusiness' AND COLUMN_NAME = 'PlanningBrand')
begin
	ALTER TABLE pPlanningBusiness ADD PlanningBrand NVARCHAR(200)
end
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06309', GetDate())
GO
