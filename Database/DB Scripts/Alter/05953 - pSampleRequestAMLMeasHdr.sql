IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestAMLMeasHdr_AMLMeasHdrId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasHdr] DROP CONSTRAINT [DF_pSampleRequestAMLMeasHdr_AMLMeasHdrId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestAMLMeasHdr_IsRelative]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasHdr] DROP CONSTRAINT [DF_pSampleRequestAMLMeasHdr_IsRelative]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestAMLMeasHdr_IsNegative]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasHdr] DROP CONSTRAINT [DF_pSampleRequestAMLMeasHdr_IsNegative]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestAMLMeasHdr_IsMetric]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasHdr] DROP CONSTRAINT [DF_pSampleRequestAMLMeasHdr_IsMetric]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestAMLMeasHdr_BaseSizeGrdCol]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasHdr] DROP CONSTRAINT [DF_pSampleRequestAMLMeasHdr_BaseSizeGrdCol]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestAMLMeasHdr_HaveHistory]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasHdr] DROP CONSTRAINT [DF_pSampleRequestAMLMeasHdr_HaveHistory]
END

GO

/****** Object:  Table [dbo].[pSampleRequestAMLMeasHdr]    Script Date: 07/02/2013 15:38:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestAMLMeasHdr]') AND type in (N'U'))
DROP TABLE [dbo].[pSampleRequestAMLMeasHdr]
GO

/****** Object:  Table [dbo].[pSampleRequestAMLMeasHdr]    Script Date: 07/02/2013 15:38:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSampleRequestAMLMeasHdr](
	[SampleRequestAMLMeasHdrId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SampleRequestTradeID] [uniqueidentifier] NULL,
	[Submit] [int] NULL,
	[Workflowid] [uniqueidentifier] NULL,
	[StyleId] [uniqueidentifier] NULL,
	[CompanyId] [uniqueidentifier] NOT NULL,
	[PDMPageId] [int] NULL,
	[CompanyName] [nvarchar](60) NULL,
	[PDMCompanyId] [int] NULL,
	[IsRelative] [int] NOT NULL,
	[IsNegative] [int] NOT NULL,
	[IsMetric] [int] NOT NULL,
	[SizeClass] [nvarchar](60) NULL,
	[SizeClassId] [uniqueidentifier] NULL,
	[SizeClassCode] [int] NULL,
	[SizeRange] [nvarchar](60) NULL,
	[SizeRangeId] [uniqueidentifier] NULL,
	[SizeRangeCode] [int] NULL,
	[ProductType] [nvarchar](100) NULL,
	[ProductTypeId] [uniqueidentifier] NULL,
	[ProductTypeCode] [int] NULL,
	[BaseSizeGrdCol] [int] NOT NULL,
	[SelectedRange] [nvarchar](500) NULL,
	[MeasRowCnt] [int] NULL,
	[HaveHistory] [int] NULL,
	[HistoryMsg] [text] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[WorkFlowItemId] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
 CONSTRAINT [PK_pSampleRequestAMLMeasHdr] PRIMARY KEY CLUSTERED 
(
	[SampleRequestAMLMeasHdrId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasHdr] ADD  CONSTRAINT [DF_pSampleRequestAMLMeasHdr_AMLMeasHdrId]  DEFAULT (newid()) FOR [SampleRequestAMLMeasHdrId]
GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasHdr] ADD  CONSTRAINT [DF_pSampleRequestAMLMeasHdr_IsRelative]  DEFAULT ((0)) FOR [IsRelative]
GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasHdr] ADD  CONSTRAINT [DF_pSampleRequestAMLMeasHdr_IsNegative]  DEFAULT ((0)) FOR [IsNegative]
GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasHdr] ADD  CONSTRAINT [DF_pSampleRequestAMLMeasHdr_IsMetric]  DEFAULT ((0)) FOR [IsMetric]
GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasHdr] ADD  CONSTRAINT [DF_pSampleRequestAMLMeasHdr_BaseSizeGrdCol]  DEFAULT ((0)) FOR [BaseSizeGrdCol]
GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasHdr] ADD  CONSTRAINT [DF_pSampleRequestAMLMeasHdr_HaveHistory]  DEFAULT ((0)) FOR [HaveHistory]
GO

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05953', GetDate())
GO
