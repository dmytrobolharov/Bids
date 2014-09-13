UPDATE pPlanningFinancial
SET AllowPercentInput = 1
WHERE PlanningFinancialID IN ('10000000-0000-0000-0000-000000000004', '10000000-0000-0000-0000-000000000005')
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06310', GetDate())
GO
