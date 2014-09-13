

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingCommitmentBOM_SourcingCommitmentBOMID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCommitmentBOM] DROP CONSTRAINT [DF_pSourcingCommitmentBOM_SourcingCommitmentBOMID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingCommitmentBOM_ItemDim1Sort]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCommitmentBOM] DROP CONSTRAINT [DF_pSourcingCommitmentBOM_ItemDim1Sort]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingCommitmentBOM_ItemDim2Sort]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCommitmentBOM] DROP CONSTRAINT [DF_pSourcingCommitmentBOM_ItemDim2Sort]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingCommitmentBOM_ItemDim3Sort]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCommitmentBOM] DROP CONSTRAINT [DF_pSourcingCommitmentBOM_ItemDim3Sort]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingCommitmentBOM_ItemDim1Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCommitmentBOM] DROP CONSTRAINT [DF_pSourcingCommitmentBOM_ItemDim1Active]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingCommitmentBOM_ItemDim2Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCommitmentBOM] DROP CONSTRAINT [DF_pSourcingCommitmentBOM_ItemDim2Active]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingCommitmentBOM_ItemDim3Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCommitmentBOM] DROP CONSTRAINT [DF_pSourcingCommitmentBOM_ItemDim3Active]
END

GO



/****** Object:  Table [dbo].[pSourcingCommitmentBOM]    Script Date: 11/20/2012 16:02:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCommitmentBOM]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingCommitmentBOM]
GO



/****** Object:  Table [dbo].[pSourcingCommitmentBOM]    Script Date: 11/20/2012 16:02:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSourcingCommitmentBOM](
	[SourcingCommitmentBOMID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[StyleBOMDimensionItemID] [uniqueidentifier] NULL,
	[SourcingCommitmentItemID] [uniqueidentifier] NULL,
	[StyleQuoteItemID] [uniqueidentifier] NULL,
	[SourcingHeaderID] [uniqueidentifier] NULL,
	[SourcingStyleID] [uniqueidentifier] NULL,
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
 CONSTRAINT [PK_pSourcingCommitmentBOM] PRIMARY KEY CLUSTERED 
(
	[SourcingCommitmentBOMID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSourcingCommitmentBOM] ADD  CONSTRAINT [DF_pSourcingCommitmentBOM_SourcingCommitmentBOMID]  DEFAULT (newsequentialid()) FOR [SourcingCommitmentBOMID]
GO

ALTER TABLE [dbo].[pSourcingCommitmentBOM] ADD  CONSTRAINT [DF_pSourcingCommitmentBOM_ItemDim1Sort]  DEFAULT ((0)) FOR [ItemDim1Sort]
GO

ALTER TABLE [dbo].[pSourcingCommitmentBOM] ADD  CONSTRAINT [DF_pSourcingCommitmentBOM_ItemDim2Sort]  DEFAULT ((0)) FOR [ItemDim2Sort]
GO

ALTER TABLE [dbo].[pSourcingCommitmentBOM] ADD  CONSTRAINT [DF_pSourcingCommitmentBOM_ItemDim3Sort]  DEFAULT ((0)) FOR [ItemDim3Sort]
GO

ALTER TABLE [dbo].[pSourcingCommitmentBOM] ADD  CONSTRAINT [DF_pSourcingCommitmentBOM_ItemDim1Active]  DEFAULT ((1)) FOR [ItemDim1Active]
GO

ALTER TABLE [dbo].[pSourcingCommitmentBOM] ADD  CONSTRAINT [DF_pSourcingCommitmentBOM_ItemDim2Active]  DEFAULT ((1)) FOR [ItemDim2Active]
GO

ALTER TABLE [dbo].[pSourcingCommitmentBOM] ADD  CONSTRAINT [DF_pSourcingCommitmentBOM_ItemDim3Active]  DEFAULT ((1)) FOR [ItemDim3Active]
GO






INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04399', GetDate())
GO
