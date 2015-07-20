UPDATE pPlanningFinancial SET AllowPercentInput = 1
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000024'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06870', GetDate())
GO
