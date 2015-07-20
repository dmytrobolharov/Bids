ALTER TABLE uTradePartnerTemplate ALTER COLUMN TradePartnerTemplateDesc NVARCHAR (MAX)
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04713', GetDate())
GO
