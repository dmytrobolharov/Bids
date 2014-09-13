
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingQuoteStyleBOMDimensionItem_SourcingQuoteStyleBOMDimensionItem]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingQuoteStyleBOM] DROP CONSTRAINT [DF_pSourcingQuoteStyleBOMDimensionItem_SourcingQuoteStyleBOMDimensionItem]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingQuoteStyleBOMDimensionItem_ItemDim1Sort]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingQuoteStyleBOM] DROP CONSTRAINT [DF_pSourcingQuoteStyleBOMDimensionItem_ItemDim1Sort]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingQuoteStyleBOMDimensionItem_ItemDim2Sort]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingQuoteStyleBOM] DROP CONSTRAINT [DF_pSourcingQuoteStyleBOMDimensionItem_ItemDim2Sort]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingQuoteStyleBOMDimensionItem_ItemDim3Sort]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingQuoteStyleBOM] DROP CONSTRAINT [DF_pSourcingQuoteStyleBOMDimensionItem_ItemDim3Sort]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingQuoteStyleBOMDimensionItem_ItemDim1Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingQuoteStyleBOM] DROP CONSTRAINT [DF_pSourcingQuoteStyleBOMDimensionItem_ItemDim1Active]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingQuoteStyleBOMDimensionItem_ItemDim2Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingQuoteStyleBOM] DROP CONSTRAINT [DF_pSourcingQuoteStyleBOMDimensionItem_ItemDim2Active]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingQuoteStyleBOMDimensionItem_ItemDim3Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingQuoteStyleBOM] DROP CONSTRAINT [DF_pSourcingQuoteStyleBOMDimensionItem_ItemDim3Active]
END

GO


GO

/****** Object:  Table [dbo].[pSourcingQuoteStyleBOM]    Script Date: 10/15/2012 10:57:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingQuoteStyleBOM]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingQuoteStyleBOM]
GO


GO

/****** Object:  Table [dbo].[pSourcingQuoteStyleBOM]    Script Date: 10/15/2012 10:57:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSourcingQuoteStyleBOM](
	[SourcingQuoteStyleBOMId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[StyleBOMDimensionItemID] [uniqueidentifier] NULL,
	[StyleQuoteItemID] [uniqueidentifier] NULL,
	[SourcingHeaderID] [uniqueidentifier] NULL,
	[StyleBOMDimensionID] [uniqueidentifier] NULL,
	[WorkFlowID] [uniqueidentifier] NULL,
	[WorkFlowItemID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[ItemDim1TypeId] [uniqueidentifier] NULL,
	[ItemDim2TypeId] [uniqueidentifier] NULL,
	[ItemDim3TypeId] [uniqueidentifier] NULL,
	[ItemDim1Id] [uniqueidentifier] NULL,
	[ItemDim2Id] [uniqueidentifier] NULL,
	[ItemDim3Id] [uniqueidentifier] NULL,
	[ItemDim1Name] [nvarchar](50) NULL,
	[ItemDim2Name] [nvarchar](50) NULL,
	[ItemDim3Name] [nvarchar](50) NULL,
	[ItemDim1Sort] [int] NULL,
	[ItemDim2Sort] [int] NULL,
	[ItemDim3Sort] [int] NULL,
	[ItemDim1Active] [int] NULL,
	[ItemDim2Active] [int] NULL,
	[ItemDim3Active] [int] NULL,
	[Comments] [nvarchar](510) NULL,
	[ImageId] [uniqueidentifier] NULL,
	[CDate] [datetime] NULL,
	[CUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[Amlmeashdrid] [uniqueidentifier] NULL,
	[Sizerangeid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pSourcingQuoteStyleBOMDimensionItem] PRIMARY KEY CLUSTERED 
(
	[SourcingQuoteStyleBOMId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSourcingQuoteStyleBOM] ADD  CONSTRAINT [DF_pSourcingQuoteStyleBOMDimensionItem_SourcingQuoteStyleBOMDimensionItem]  DEFAULT (newsequentialid()) FOR [SourcingQuoteStyleBOMId]
GO

ALTER TABLE [dbo].[pSourcingQuoteStyleBOM] ADD  CONSTRAINT [DF_pSourcingQuoteStyleBOMDimensionItem_ItemDim1Sort]  DEFAULT ((0)) FOR [ItemDim1Sort]
GO

ALTER TABLE [dbo].[pSourcingQuoteStyleBOM] ADD  CONSTRAINT [DF_pSourcingQuoteStyleBOMDimensionItem_ItemDim2Sort]  DEFAULT ((0)) FOR [ItemDim2Sort]
GO

ALTER TABLE [dbo].[pSourcingQuoteStyleBOM] ADD  CONSTRAINT [DF_pSourcingQuoteStyleBOMDimensionItem_ItemDim3Sort]  DEFAULT ((0)) FOR [ItemDim3Sort]
GO

ALTER TABLE [dbo].[pSourcingQuoteStyleBOM] ADD  CONSTRAINT [DF_pSourcingQuoteStyleBOMDimensionItem_ItemDim1Active]  DEFAULT ((1)) FOR [ItemDim1Active]
GO

ALTER TABLE [dbo].[pSourcingQuoteStyleBOM] ADD  CONSTRAINT [DF_pSourcingQuoteStyleBOMDimensionItem_ItemDim2Active]  DEFAULT ((1)) FOR [ItemDim2Active]
GO

ALTER TABLE [dbo].[pSourcingQuoteStyleBOM] ADD  CONSTRAINT [DF_pSourcingQuoteStyleBOMDimensionItem_ItemDim3Active]  DEFAULT ((1)) FOR [ItemDim3Active]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04182', GetDate())
GO