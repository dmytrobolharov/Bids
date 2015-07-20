

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingCommitmentBOMDetails_SourcingCommitmentBOMDetailsID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCommitmentBOMDetails] DROP CONSTRAINT [DF_pSourcingCommitmentBOMDetails_SourcingCommitmentBOMDetailsID]
END

GO


/****** Object:  Table [dbo].[pSourcingCommitmentBOMDetails]    Script Date: 11/20/2012 16:03:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCommitmentBOMDetails]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingCommitmentBOMDetails]
GO



/****** Object:  Table [dbo].[pSourcingCommitmentBOMDetails]    Script Date: 11/20/2012 16:03:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSourcingCommitmentBOMDetails](
	[SourcingCommitmentBOMDetailsID] [uniqueidentifier] NOT NULL,
	[SourcingCommitmentItemID] [uniqueidentifier] NULL,
	[StyleQuoteItemID] [uniqueidentifier] NULL,
	[SourcingHeaderId] [uniqueidentifier] NULL,
	[SourcingStyleID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[styleset] [int] NULL,
	[WorkFlowID] [uniqueidentifier] NULL,
	[WorkFlowItemID] [uniqueidentifier] NULL,
	[StyleBOMDimensionId] [uniqueidentifier] NULL,
	[StyleBOMDimensionItemId] [uniqueidentifier] NULL,
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
	[Quantity] [decimal](18, 4) NULL,
	[Cost] [decimal](18, 4) NULL,
	[TotalCost] [decimal](18, 4) NULL,
	[PartnerCost] [decimal](18, 4) NULL,
	[PartnerTotal] [decimal](18, 4) NULL,
	[CUser] [nvarchar](200) NULL,
	[MUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pSourcingCommitmentBOMDetails] PRIMARY KEY CLUSTERED 
(
	[SourcingCommitmentBOMDetailsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSourcingCommitmentBOMDetails] ADD  CONSTRAINT [DF_pSourcingCommitmentBOMDetails_SourcingCommitmentBOMDetailsID]  DEFAULT (newsequentialid()) FOR [SourcingCommitmentBOMDetailsID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04400', GetDate())
GO
