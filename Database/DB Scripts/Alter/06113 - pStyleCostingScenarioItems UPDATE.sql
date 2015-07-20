update pStyleCostingScenarioItems set StyleCostingHTS = (SELECT TOP 1 CustomID FROM pStyleCostingDuty WHERE Custom=pStyleCostingScenarioItems.StyleCostingHTS) where not StyleCostingHTS is null

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06113', GetDate())
GO