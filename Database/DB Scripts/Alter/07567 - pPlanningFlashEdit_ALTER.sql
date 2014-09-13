IF NOT EXISTS(SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='pPlanningFlashEdit' AND COLUMN_NAME='PlanningFlashEditSaveSPX')
	ALTER TABLE pPlanningFlashEdit ADD PlanningFlashEditSaveSPX NVARCHAR(200) NULL
GO

UPDATE pPlanningFlashEdit SET PlanningFlashEditSaveSPX = 'spx_PlanningFlashEdit_StyleHeader_SAVE'
WHERE PlanningFlashEditName = 'Style Header'

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07567', GetDate())
GO