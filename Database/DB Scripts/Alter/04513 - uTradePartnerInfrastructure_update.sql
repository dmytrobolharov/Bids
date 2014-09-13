UPDATE  uTradePartnerInfrastructure 

set TradePartnerInfrastructureTypeID = 1

WHERE TradePartnerInfrastructureTypeID is null 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04513', GetDate())
GO
      