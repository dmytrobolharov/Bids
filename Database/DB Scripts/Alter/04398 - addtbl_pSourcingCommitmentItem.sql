
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingCommitmentItem_SourcingCommitmentItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCommitmentItem] DROP CONSTRAINT [DF_pSourcingCommitmentItem_SourcingCommitmentItemID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingCommitmentItem_StyleQuoteItemShare]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCommitmentItem] DROP CONSTRAINT [DF_pSourcingCommitmentItem_StyleQuoteItemShare]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingCommitmentItem_StyleQuoteItemCustomField11]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCommitmentItem] DROP CONSTRAINT [DF_pSourcingCommitmentItem_StyleQuoteItemCustomField11]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingCommitmentItem_StyleQuoteItemCustomField17]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCommitmentItem] DROP CONSTRAINT [DF_pSourcingCommitmentItem_StyleQuoteItemCustomField17]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingCommitmentItem_StyleQuoteItemCustomField18]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCommitmentItem] DROP CONSTRAINT [DF_pSourcingCommitmentItem_StyleQuoteItemCustomField18]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingCommitmentItem_StyleQuoteItemCustomField19]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCommitmentItem] DROP CONSTRAINT [DF_pSourcingCommitmentItem_StyleQuoteItemCustomField19]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingCommitmentItem_StyleQuoteItemCustomField20]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCommitmentItem] DROP CONSTRAINT [DF_pSourcingCommitmentItem_StyleQuoteItemCustomField20]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingCommitmentItem_AgentView]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCommitmentItem] DROP CONSTRAINT [DF_pSourcingCommitmentItem_AgentView]
END

GO


/****** Object:  Table [dbo].[pSourcingCommitmentItem]    Script Date: 11/20/2012 15:58:11 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCommitmentItem]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingCommitmentItem]
GO



/****** Object:  Table [dbo].[pSourcingCommitmentItem]    Script Date: 11/20/2012 15:58:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[pSourcingCommitmentItem](
	[SourcingCommitmentItemID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[StyleCommitmentNo] [int] IDENTITY(1,1) NOT NULL,
	[StyleQuoteItemID] [uniqueidentifier] NULL,
	[StyleQuoteItemNo] [int] NULL,
	[StyleQuoteItemShare] [int] NULL,
	[StyleQuoteItemStatusId] [int] NULL,
	[StyleQuoteVariationId] [uniqueidentifier] NULL,
	[StyleQuoteID] [uniqueidentifier] NULL,
	[StyleQuotaDutyID] [uniqueidentifier] NULL,
	[StyleDevelopmentID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleQuoteTradePartnerID] [uniqueidentifier] NULL,
	[StyleCostingID] [uniqueidentifier] NULL,
	[StyleCostingType] [int] NULL,
	[StyleCostingFreightTypeID] [int] NULL,
	[TradePartnerID] [uniqueidentifier] NULL,
	[TradePartnerVendorID] [uniqueidentifier] NULL,
	[StyleQuoteItemDueDate] [datetime] NULL,
	[StyleQuoteItemApprovedBy] [nvarchar](200) NULL,
	[StyleQuoteItemApprovedDate] [datetime] NULL,
	[StyleQuoteItemCustomField1] [nvarchar](200) NULL,
	[StyleQuoteItemCustomField2] [decimal](18, 3) NULL,
	[StyleQuoteItemCustomField3] [nvarchar](200) NULL,
	[StyleQuoteItemCustomField4] [nvarchar](200) NULL,
	[StyleQuoteItemCustomField5] [decimal](18, 3) NULL,
	[StyleQuoteItemCustomField6] [decimal](18, 3) NULL,
	[StyleQuoteItemCustomField7] [decimal](18, 5) NULL,
	[StyleQuoteItemCustomField8] [decimal](18, 3) NULL,
	[StyleQuoteItemCustomField9] [decimal](18, 5) NULL,
	[StyleQuoteItemCustomField10] [decimal](18, 3) NULL,
	[StyleQuoteItemCustomField11] [decimal](18, 5) NULL,
	[StyleQuoteItemCustomField12] [decimal](18, 3) NULL,
	[StyleQuoteItemCustomField13] [decimal](18, 3) NULL,
	[StyleQuoteItemCustomField14] [decimal](18, 3) NULL,
	[StyleQuoteItemCustomField15] [decimal](18, 5) NULL,
	[StyleQuoteItemCustomField16] [int] NULL,
	[StyleQuoteItemCustomField17] [decimal](18, 5) NULL,
	[StyleQuoteItemCustomField18] [decimal](18, 3) NULL,
	[StyleQuoteItemCustomField19] [decimal](18, 3) NULL,
	[StyleQuoteItemCustomField20] [decimal](18, 3) NULL,
	[StyleQuoteItemCustomField21] [nvarchar](200) NULL,
	[StyleQuoteItemCustomField22] [decimal](18, 3) NULL,
	[StyleQuoteItemCustomField23] [decimal](18, 4) NULL,
	[StyleQuoteItemCustomField24] [decimal](18, 4) NULL,
	[StyleQuoteItemCustomField25] [nvarchar](200) NULL,
	[StyleQuoteItemCustomField26] [nvarchar](200) NULL,
	[StyleQuoteItemCustomField27] [nvarchar](200) NULL,
	[StyleQuoteItemCustomField28] [nvarchar](200) NULL,
	[StyleQuoteItemCustomField29] [nvarchar](200) NULL,
	[StyleQuoteItemCustomField30] [decimal](18, 3) NULL,
	[StyleQuoteItemCustomField31] [decimal](18, 3) NULL,
	[StyleQuoteItemCustomField32] [decimal](18, 5) NULL,
	[StyleQuoteItemCustomField33] [decimal](18, 3) NULL,
	[StyleQuoteItemCustomField34] [nvarchar](200) NULL,
	[StyleQuoteItemCustomField35] [nvarchar](200) NULL,
	[StyleQuoteItemNotes] [ntext] NULL,
	[StyleCostingCustomField1] [decimal](18, 3) NULL,
	[StyleCostingCustomField2] [decimal](18, 3) NULL,
	[StyleCostingCustomField3] [int] NULL,
	[StyleCostingCustomField4] [int] NULL,
	[StyleCostingCustomField5] [int] NULL,
	[StyleCostingCustomField6] [decimal](18, 3) NULL,
	[StyleCostingCustomField7] [decimal](18, 5) NULL,
	[StyleCostingCustomField8] [decimal](18, 3) NULL,
	[StyleCostingCustomField9] [decimal](18, 5) NULL,
	[StyleCostingCustomField10] [decimal](18, 3) NULL,
	[StyleCostingCustomField11] [decimal](18, 5) NULL,
	[StyleCostingCustomField12] [decimal](18, 3) NULL,
	[StyleCostingCustomField13] [decimal](18, 3) NULL,
	[StyleCostingCustomField14] [decimal](18, 3) NULL,
	[StyleCostingCustomField15] [decimal](18, 3) NULL,
	[StyleCostingCustomField16] [decimal](18, 3) NULL,
	[StyleCostingCustomField17] [datetime] NULL,
	[StyleCostingCustomField18] [decimal](18, 3) NULL,
	[StyleCostingCustomField19] [decimal](18, 3) NULL,
	[StyleCostingCustomField20] [decimal](18, 3) NULL,
	[StyleCostingCustomField21] [decimal](18, 3) NULL,
	[StyleCostingCustomField22] [decimal](18, 3) NULL,
	[StyleCostingCustomField23] [decimal](18, 5) NULL,
	[StyleCostingCustomField24] [decimal](18, 3) NULL,
	[StyleCostingCustomField25] [varchar](50) NULL,
	[StyleCostingCustomField26] [varchar](50) NULL,
	[StyleCostingCustomField27] [varchar](50) NULL,
	[StyleCostingCustomField28] [varchar](50) NULL,
	[StyleCostingCustomField29] [varchar](50) NULL,
	[StyleCostingCustomField30] [varchar](50) NULL,
	[StyleCostingCustomField31] [varchar](50) NULL,
	[StyleCostingCustomField32] [decimal](18, 5) NULL,
	[StyleCostingCustomField33] [varchar](50) NULL,
	[StyleCostingCustomField34] [nvarchar](200) NULL,
	[StyleCostingCustomField35] [nvarchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[QuoteFolderSort] [nvarchar](5) NULL,
	[AgentView] [int] NULL,
	[StyleColorID] [uniqueidentifier] NULL,
	[StyleSourcingID] [uniqueidentifier] NULL,
	[StyleSeasonYearID] [uniqueidentifier] NULL,
	[BOMCost] [decimal](18, 3) NULL,
	[BOLCost] [decimal](18, 3) NULL,
	[BOLCurr] [nvarchar](5) NULL,
	[StyleQuotaVendorDutyID] [uniqueidentifier] NULL,
	[SourcingHeaderID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pSourcingCommitmentItem] PRIMARY KEY CLUSTERED 
(
	[SourcingCommitmentItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[pSourcingCommitmentItem] ADD  CONSTRAINT [DF_pSourcingCommitmentItem_SourcingCommitmentItemID]  DEFAULT (newsequentialid()) FOR [SourcingCommitmentItemID]
GO

ALTER TABLE [dbo].[pSourcingCommitmentItem] ADD  CONSTRAINT [DF_pSourcingCommitmentItem_StyleQuoteItemShare]  DEFAULT ((0)) FOR [StyleQuoteItemShare]
GO

ALTER TABLE [dbo].[pSourcingCommitmentItem] ADD  CONSTRAINT [DF_pSourcingCommitmentItem_StyleQuoteItemCustomField11]  DEFAULT ((0)) FOR [StyleQuoteItemCustomField11]
GO

ALTER TABLE [dbo].[pSourcingCommitmentItem] ADD  CONSTRAINT [DF_pSourcingCommitmentItem_StyleQuoteItemCustomField17]  DEFAULT ((0)) FOR [StyleQuoteItemCustomField17]
GO

ALTER TABLE [dbo].[pSourcingCommitmentItem] ADD  CONSTRAINT [DF_pSourcingCommitmentItem_StyleQuoteItemCustomField18]  DEFAULT ((0)) FOR [StyleQuoteItemCustomField18]
GO

ALTER TABLE [dbo].[pSourcingCommitmentItem] ADD  CONSTRAINT [DF_pSourcingCommitmentItem_StyleQuoteItemCustomField19]  DEFAULT ((0)) FOR [StyleQuoteItemCustomField19]
GO

ALTER TABLE [dbo].[pSourcingCommitmentItem] ADD  CONSTRAINT [DF_pSourcingCommitmentItem_StyleQuoteItemCustomField20]  DEFAULT ((0)) FOR [StyleQuoteItemCustomField20]
GO

ALTER TABLE [dbo].[pSourcingCommitmentItem] ADD  CONSTRAINT [DF_pSourcingCommitmentItem_AgentView]  DEFAULT ((0)) FOR [AgentView]
GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04398', GetDate())
GO
