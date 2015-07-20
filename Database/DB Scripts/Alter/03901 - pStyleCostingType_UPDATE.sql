update pStyleCostingType set ShowBOL = 1, ShowBOM = 1
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03901', GetDate())
GO
