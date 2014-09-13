IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pPlanningFlashEdit' AND COLUMN_NAME = 'PlanningFlashEditPage')
BEGIN
	ALTER TABLE pPlanningFlashEdit ADD PlanningFlashEditPage NVARCHAR(200)
END
GO

IF EXISTS (SELECT * FROM pPlanningFlashEdit WHERE PlanningFlashEditPage IS NULL)
BEGIN
	UPDATE pPlanningFlashEdit SET PlanningFlashEditPage = 'Planning_Folder_FlashEditPage.aspx'
	UPDATE pPlanningFlashEdit SET PlanningFlashEditPage = 'Planning_Folder_FlashEditCostingPage.aspx' WHERE PlanningFlashEditName = 'Style Costing Property'
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08076', GetDate())
GO
