IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_uTradePartnerProductType_TradePartnerProductTypeId]') AND type = 'D')
	BEGIN
		ALTER TABLE [dbo].[uTradePartnerProductType] DROP CONSTRAINT [DF_uTradePartnerProductType_TradePartnerProductTypeId]
	END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[PK_uTradePartnerProductType]') AND type = 'K')
	BEGIN
		ALTER TABLE [dbo].[uTradePartnerProductType] DROP CONSTRAINT [PK_uTradePartnerProductType]
	END

GO

ALTER TABLE uTradePartnerProductType ADD  CONSTRAINT [PK_uTradePartnerProductType] PRIMARY KEY CLUSTERED
 ([TradePartnerProductTypeId] ASC)

Go

ALTER TABLE [dbo].[uTradePartnerProductType] ADD  CONSTRAINT [DF_uTradePartnerProductType_TradePartnerProductTypeId]  DEFAULT (newsequentialid()) FOR [TradePartnerProductTypeId]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04077', GetDate())

GO
