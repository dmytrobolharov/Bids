IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uTradePartnerProductType]') AND type in (N'U'))
DROP TABLE [dbo].[uTradePartnerProductType]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[uTradePartnerProductType](
	[TradePartnerProductTypeId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[TradePartnerId] [uniqueidentifier] NULL,
	[StyleCategoryId] [uniqueidentifier] NULL,
	[Active] [int] NOT NULL,
	[Sort] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[uTradePartnerProductType] ADD  CONSTRAINT [DF_uTradePartnerProductType_TradePartnerProductTypeId]  DEFAULT (newsequentialid()) FOR [TradePartnerProductTypeId]
GO

ALTER TABLE [dbo].[uTradePartnerProductType] ADD  CONSTRAINT [DF_uTradePartnerProductType_Active]  DEFAULT ((1)) FOR [Active]
GO

ALTER TABLE [dbo].[uTradePartnerProductType] ADD  CONSTRAINT [DF_uTradePartnerProductType_Sort]  DEFAULT ((0)) FOR [Sort]
GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03283'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03283', GetDate())

END
GO