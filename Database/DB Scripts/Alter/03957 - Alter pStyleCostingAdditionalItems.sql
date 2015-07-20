ALTER TABLE pStyleCostingAdditionalItems 
ADD StyleAdditionalItemID UNIQUEIDENTIFIER NULL

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03957', GetDate())
GO