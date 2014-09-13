UPDATE pStyleCosting SET StyleCostingHTS = (SELECT TOP 1 CustomID FROM pStyleCostingDuty WHERE Custom=pStyleCosting.StyleCostingHTS) 
WHERE NOT StyleCostingHTS IS NULL AND StyleCostingHTS IN (SELECT Custom FROM pStyleCostingDuty)

UPDATE pStyleCosting SET StyleCostingHTS = NULL
WHERE NOT StyleCostingHTS IS NULL AND StyleCostingHTS NOT IN (SELECT CAST(CustomID as nvarchar(50)) FROM pStyleCostingDuty)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '06251', GetDate())
GO
