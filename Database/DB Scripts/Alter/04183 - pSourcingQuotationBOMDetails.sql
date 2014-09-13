
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingQuotationBOMDetails_SourcingQuotationBOMDetailsID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingQuotationBOMDetails] DROP CONSTRAINT [DF_pSourcingQuotationBOMDetails_SourcingQuotationBOMDetailsID]
END

GO


GO

/****** Object:  Table [dbo].[pSourcingQuotationBOMDetails]    Script Date: 10/15/2012 10:57:25 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingQuotationBOMDetails]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingQuotationBOMDetails]
GO


GO

/****** Object:  Table [dbo].[pSourcingQuotationBOMDetails]    Script Date: 10/15/2012 10:57:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSourcingQuotationBOMDetails](
	[SourcingQuotationBOMDetailsID] [uniqueidentifier] NOT NULL,
	[StyleQuoteItemID] [uniqueidentifier] NULL,
	[SourcingHeaderId] [uniqueidentifier] NULL,
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
 CONSTRAINT [PK_pSourcingQuotationBOMDetails] PRIMARY KEY CLUSTERED 
(
	[SourcingQuotationBOMDetailsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSourcingQuotationBOMDetails] ADD  CONSTRAINT [DF_pSourcingQuotationBOMDetails_SourcingQuotationBOMDetailsID]  DEFAULT (newid()) FOR [SourcingQuotationBOMDetailsID]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04183', GetDate())
GO