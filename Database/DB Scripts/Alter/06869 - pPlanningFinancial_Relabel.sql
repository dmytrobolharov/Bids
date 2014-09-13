UPDATE pPlanningFinancial SET PlanningFinancialText = '# of Over Dev. Styles' 
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000020'

UPDATE pPlanningBusiness SET PlanningFinancialText = '# of Over Dev. Styles' 
WHERE PlanningFinancialID = '10000000-0000-0000-0000-000000000020'

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06869', GetDate())
GO
