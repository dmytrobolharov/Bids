UPDATE pPlanningFinancial SET PlanningFinancialCssClass = 'fontHead'
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07505', GetDate())
GO
