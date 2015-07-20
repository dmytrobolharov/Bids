
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingQuotationBOMOption_StyleOptionID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingQuotationBOMOption] DROP CONSTRAINT [DF_pSourcingQuotationBOMOption_StyleOptionID]
END

GO



/****** Object:  Table [dbo].[pSourcingQuotationBOMOption]    Script Date: 11/19/2012 17:01:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingQuotationBOMOption]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingQuotationBOMOption]
GO



/****** Object:  Table [dbo].[pSourcingQuotationBOMOption]    Script Date: 11/19/2012 17:01:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSourcingQuotationBOMOption](
	[StyleOptionID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[StyleQuoteItemID] [uniqueidentifier] NULL,
	[SourcingHeaderId] [uniqueidentifier] NULL,
	[SourcingStyleID] [uniqueidentifier] NULL,
	[StyleID] [uniqueidentifier] NULL,
	[styleset] [int] NULL,
	[OptionNo] [int] NULL,
	[OptionStatus] [int] NULL,
	[OptionSystem] [int] NULL,
	[WorkFlowID] [uniqueidentifier] NULL,
	[WorkFlowItemID] [uniqueidentifier] NULL,
	[StyleBOMDimensionId] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[MUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pSourcingQuotationBOMOption] PRIMARY KEY CLUSTERED 
(
	[StyleOptionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSourcingQuotationBOMOption] ADD  CONSTRAINT [DF_pSourcingQuotationBOMOption_StyleOptionID]  DEFAULT (newid()) FOR [StyleOptionID]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04384', GetDate())
GO