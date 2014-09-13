IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingQuotationDetails_SourcingQuotationDetailsID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingQuotationDetails] DROP CONSTRAINT [DF_pSourcingQuotationDetails_SourcingQuotationDetailsID]
END

GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingQuotationDetails]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingQuotationDetails]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSourcingQuotationDetails](
	[SourcingQuotationDetailsID] [uniqueidentifier] NOT NULL,
	[QuoteItemID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleDimensionID] [uniqueidentifier] NULL,
	[ItemDim1TypeId] [uniqueidentifier] NULL,
	[ItemDim2TypeId] [uniqueidentifier] NULL,
	[ItemDim3TypeId] [uniqueidentifier] NULL,
	[ItemDim1TypeName] [nvarchar](50) NULL,
	[ItemDim2TypeName] [nvarchar](50) NULL,
	[ItemDim3TypeName] [nvarchar](50) NULL,
	[Quantity] [decimal](18, 4) NULL,
	[Cost] [decimal](18, 4) NULL,
	[Total] [decimal](18, 4) NULL,
	[PartnerCost] [decimal](18, 4) NULL,
	[PartnerTotal] [decimal](18, 4) NULL,
	[Sort] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pSourcingQuotationDetails] PRIMARY KEY CLUSTERED 
(
	[SourcingQuotationDetailsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSourcingQuotationDetails] ADD  CONSTRAINT [DF_pSourcingQuotationDetails_SourcingQuotationDetailsID]  DEFAULT (newsequentialid()) FOR [SourcingQuotationDetailsID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04175', GetDate())
GO

