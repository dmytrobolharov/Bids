IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pBOLFactoryRates_uTradePartnerVendor]') AND parent_object_id = OBJECT_ID(N'[dbo].[pBOLFactoryRates]'))
ALTER TABLE [dbo].[pBOLFactoryRates] DROP CONSTRAINT [FK_pBOLFactoryRates_uTradePartnerVendor]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pBOLFactoryRates_FactoryRateId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pBOLFactoryRates] DROP CONSTRAINT [DF_pBOLFactoryRates_FactoryRateId]
END
GO

/****** Object:  Table [dbo].[pBOLFactoryRates]    Script Date: 08/31/2011 17:20:14 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pBOLFactoryRates]') AND type in (N'U'))
DROP TABLE [dbo].[pBOLFactoryRates]
GO

/****** Object:  Table [dbo].[pBOLFactoryRates]    Script Date: 08/31/2011 17:20:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pBOLFactoryRates](
	[FactoryRateId] [uniqueidentifier] NOT NULL,
	[FactoryId] [uniqueidentifier] NULL,
	[BaseRateId] [uniqueidentifier] NULL,
	[SeasonYearId] [uniqueidentifier] NULL,
	[CurrencyId] [uniqueidentifier] NULL,
	[RateValue] [numeric](18, 2) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
	[TradePartnerVendorID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pBOLFactoryRates] PRIMARY KEY CLUSTERED 
(
	[FactoryRateId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pBOLFactoryRates]  WITH CHECK ADD  CONSTRAINT [FK_pBOLFactoryRates_uTradePartnerVendor] FOREIGN KEY([TradePartnerVendorID])
REFERENCES [dbo].[uTradePartnerVendor] ([TradePartnerVendorID])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pBOLFactoryRates] CHECK CONSTRAINT [FK_pBOLFactoryRates_uTradePartnerVendor]
GO

ALTER TABLE [dbo].[pBOLFactoryRates] ADD  CONSTRAINT [DF_pBOLFactoryRates_FactoryRateId]  DEFAULT (newid()) FOR [FactoryRateId]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01801'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01801', GetDate())
END

GO 

