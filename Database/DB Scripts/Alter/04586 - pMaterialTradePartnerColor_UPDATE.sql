update pMaterialTradePartnerColor set MaterialRequestShare = 1
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04586', GetDate())
GO
