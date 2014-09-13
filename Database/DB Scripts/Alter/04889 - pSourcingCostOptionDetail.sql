IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingCostOptionDetail_SourcingCostOptionDetailID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingCostOptionDetail] DROP CONSTRAINT [DF_pSourcingCostOptionDetail_SourcingCostOptionDetailID]
END

GO

/****** Object:  Table [dbo].[pSourcingCostOptionDetail]    Script Date: 01/24/2013 19:08:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingCostOptionDetail]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingCostOptionDetail]
GO


/****** Object:  Table [dbo].[pSourcingCostOptionDetail]    Script Date: 01/24/2013 19:08:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSourcingCostOptionDetail](
	[SourcingCostOptionDetailID] [uniqueidentifier] NOT NULL,
	[SourcingCostOptionId] [uniqueidentifier] NOT NULL,
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

ALTER TABLE [dbo].[pSourcingCostOptionDetail] ADD  CONSTRAINT [DF_pSourcingCostOptionDetail_SourcingCostOptionDetailID]  DEFAULT (newid()) FOR [SourcingCostOptionDetailID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04889', GetDate())
GO
