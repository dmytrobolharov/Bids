IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'pPlanningFinancial' AND COLUMN_NAME = 'HeaderEditable')
BEGIN
	ALTER TABLE pPlanningFinancial ADD HeaderEditable INT
END
GO

UPDATE pPlanningFinancial SET HeaderEditable = AllowPercentInput
UPDATE pPlanningFinancial SET HeaderEditable = 0 WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000020'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07779', GetDate())
GO
