IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingCommitmentCostOptionDetail_SourcingCostOptionDetailID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCommitmentCostOptionDetail] DROP CONSTRAINT [DF_pSourcingCommitmentCostOptionDetail_SourcingCostOptionDetailID]
END

GO

/****** Object:  Table [dbo].[pSourcingCommitmentCostOptionDetail]    Script Date: 01/30/2013 16:18:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCommitmentCostOptionDetail]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingCommitmentCostOptionDetail]
GO


/****** Object:  Table [dbo].[pSourcingCommitmentCostOptionDetail]    Script Date: 01/30/2013 16:18:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSourcingCommitmentCostOptionDetail](
	[SourcingCommitmentCostOptionDetailID] [uniqueidentifier] NOT NULL,
	[SourcingCommitmentCostOptionId] [uniqueidentifier] NOT NULL,
	[SourcingQuotationBOMDetailsID] [uniqueidentifier] NOT NULL,
	[MinQuantity] [decimal](18, 4) NULL,
	[MaxQuantity] [decimal](18, 4) NULL,
	[CostUnit] [decimal](18, 4) NULL,
	[Active] [int] NULL,
	[ItemDim1Id] [uniqueidentifier] NULL,
	[ItemDim2Id] [uniqueidentifier] NULL,
	[ItemDim3Id] [uniqueidentifier] NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSourcingCommitmentCostOptionDetail] ADD  CONSTRAINT [DF_pSourcingCommitmentCostOptionDetail_SourcingCostOptionDetailID]  DEFAULT (newid()) FOR [SourcingCommitmentCostOptionDetailID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04923', GetDate())
GO