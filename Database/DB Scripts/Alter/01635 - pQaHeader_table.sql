
/****** Object:  Table [dbo].[pQAHeader]    Script Date: 07/14/2011 11:52:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pQAHeader]') AND type in (N'U'))
	DROP TABLE [dbo].[pQAHeader]
GO

CREATE TABLE [dbo].[pQAHeader](
	[SampleRequestHeaderId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SampleRequestTradeID] [uniqueidentifier] NULL,
	[SampleRequestWorkflowID] [uniqueidentifier] NULL,
	[SampleWorkflowID] [nvarchar](5) NULL,
	[TradePartnerVendorID] [uniqueidentifier] NULL,
	[WorkflowID] [uniqueidentifier] NULL,
	[WorkFlowItemId] [uniqueidentifier] NULL,
	[StyleId] [uniqueidentifier] NOT NULL,
	[StyleColorID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[AMLMeasHdrId] [uniqueidentifier] NOT NULL,
	[Submit] [int] NULL,
	[CompanyName] [nvarchar](60) NULL,
	[IsRelative] [int] NULL,
	[IsMetric] [int] NULL,
	[SizeClassId] [uniqueidentifier] NULL,
	[SizeClass] [nvarchar](60) NULL,
	[SizeRangeId] [uniqueidentifier] NULL,
	[SizeRange] [nvarchar](60) NULL,
	[ProductTypeId] [uniqueidentifier] NULL,
	[ProductType] [nvarchar](100) NULL,
	[SampleSizeId] [uniqueidentifier] NULL,
	[SampleSize] [nvarchar](24) NULL,
	[FactoryId] [uniqueidentifier] NULL,
	[FactoryName] [nvarchar](100) NULL,
	[DateSampProv] [datetime] NULL,
	[SampleMeasurer] [nvarchar](100) NULL,
	[LotNumber] [nvarchar](100) NULL,
	[Color] [nvarchar](100) NULL,
	[TotalUnitsShipped] [nvarchar](100) NULL,
	[Comments] [text] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pQAHeader] PRIMARY KEY CLUSTERED 
(
	[SampleRequestHeaderId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[pQAHeader] ADD  CONSTRAINT [DF_pQAHeader_SampleRequestHeaderId]  DEFAULT (newid()) FOR [SampleRequestHeaderId]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES      ('DB_Version', '4.1.0000', '01635', GetDate())
GO