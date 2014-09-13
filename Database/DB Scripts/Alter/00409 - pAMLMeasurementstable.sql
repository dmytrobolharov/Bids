SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pAMLMeasHdr](
	[AMLMeasHdrId] [uniqueidentifier] ROWGUIDCOL NOT NULL CONSTRAINT [DF_pAMLMeasHdr_AMLMeasHdrId]  DEFAULT (newid()),
	[Workflowid] [uniqueidentifier] NULL,
	[StyleId] [uniqueidentifier] NULL,
	[CompanyId] [uniqueidentifier] NOT NULL,
	[PDMPageId] [int] NULL,
	[CompanyName] [nvarchar](60) NULL,
	[PDMCompanyId] [int] NULL,
	[IsRelative] [int] NOT NULL CONSTRAINT [DF_pAMLMeasHdr_IsRelative]  DEFAULT ((0)),
	[IsNegative] [int] NOT NULL CONSTRAINT [DF_pAMLMeasHdr_IsNegative]  DEFAULT ((0)),
	[IsMetric] [int] NOT NULL CONSTRAINT [DF_pAMLMeasHdr_IsMetric]  DEFAULT ((0)),
	[SizeClass] [nvarchar](60)  NULL,
	[SizeClassId] [uniqueidentifier] NULL,
	[SizeClassCode] [int] NULL,
	[SizeRange] [nvarchar](60)  NULL,
	[SizeRangeId] [uniqueidentifier] NULL,
	[SizeRangeCode] [int] NULL,
	[ProductType] [nvarchar](100)  NULL,
	[ProductTypeId] [uniqueidentifier] NULL,
	[ProductTypeCode] [int] NULL,
	[BaseSizeGrdCol] [int] NOT NULL CONSTRAINT [DF_pAMLMeasHdr_BaseSizeGrdCol]  DEFAULT ((0)),
	[SelectedRange] [nvarchar](500) NULL,
	[MeasRowCnt] [int] NULL,
	[HaveHistory] [int] NULL CONSTRAINT [DF_pAMLMeasHdr_HaveHistory]  DEFAULT ((0)),
	[HistoryMsg] [text]  NULL,
	[CUser] [nvarchar](200)  NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200)  NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pAMLMeasHdr] PRIMARY KEY CLUSTERED 
(
	[AMLMeasHdrId] ASC
))

GO

CREATE TABLE [dbo].[pAMLMeasIGC](
	[AMLMeasIGCId] [uniqueidentifier] ROWGUIDCOL NOT NULL CONSTRAINT [DF_pAMLMeasIGC_AMLMeasIGCId]  DEFAULT (newid()),
	[AMLMeasHdrId] [uniqueidentifier] NULL,
	[AMLMeasPOMId] [uniqueidentifier] NULL,
	[PDMPageId] [int] NULL,
	[POM_Row] [int] NOT NULL,
	[WSRowId] [int] NOT NULL,
	[SizeCol] [int] NOT NULL,
	[Incr] [numeric](18, 4) NULL CONSTRAINT [DF_pAMLMeasIGC_Incr]  DEFAULT ((0)),
	[Grade] [numeric](18, 4) NULL CONSTRAINT [DF_pAMLMeasIGC_Grade]  DEFAULT ((0)),
	[ConvGrade] [numeric](18, 4) NULL CONSTRAINT [DF_pAMLMeasIGC_ConvGrade]  DEFAULT ((0)),
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pAMLMeasIGC] PRIMARY KEY CLUSTERED 
(
	[AMLMeasIGCId] ASC
))

GO

CREATE TABLE [dbo].[pAMLMeasLbl](
	[AMLMeasLblId] [uniqueidentifier] ROWGUIDCOL NOT NULL CONSTRAINT [DF_pAMLMeasLbl_AMLMeasLblId]  DEFAULT (newid()),
	[AMLMeasHdrId] [uniqueidentifier] NULL,
	[PDMPageId] [int] NULL,
	[SizeRangeId] [uniqueidentifier] NULL,
	[SizeRangeDetailId] [uniqueidentifier] NULL,
	[SizeCol] [int] NOT NULL,
	[MeasLbl] [nvarchar](24)  NULL,
	[IsVisible] [int] NOT NULL CONSTRAINT [DF_pAMLMeasLbl_IsVisible]  DEFAULT ((0)),
	[IsSample] [int] NOT NULL CONSTRAINT [DF_pAMLMeasLbl_IsSample]  DEFAULT ((0)),
	[MeasDesc] [nvarchar](20) NULL,
	[CUser] [nvarchar](200)  NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200)  NULL,
	[MDate] [datetime] NULL,
CONSTRAINT [PK_pAMLMeasLbl] PRIMARY KEY CLUSTERED 
(
	[AMLMeasLblId] ASC
))

GO


CREATE TABLE [dbo].[pAMLMeasPOM](
	[AMLMeasPOMId] [uniqueidentifier] ROWGUIDCOL NOT NULL CONSTRAINT [DF_pAMLMeasPOM_AMLMeasPOMId]  DEFAULT (newid()),
	[AMLMeasHdrId] [uniqueidentifier] NULL,
	[PDMPageId] [int] NULL,
	[GRPOMCompanyId] [uniqueidentifier] NULL,
	[POMGuidId] [uniqueidentifier] NULL,
	[POMAlternatesId] [uniqueidentifier] NULL,
	[POM_Row] [int] NOT NULL,
	[RefCode] [nvarchar](12)  NULL,
	[Description] [nvarchar](204)  NULL,
	[TolPlus] [numeric](18, 4) NULL CONSTRAINT [DF_pAMLMeasPOM_TolPlus]  DEFAULT ((0)),
	[TolMinus] [numeric](18, 4) NULL CONSTRAINT [DF_pAMLMeasPOM_TolMinus]  DEFAULT ((0)),
	[TolPlusConv] [numeric](18, 4) NULL CONSTRAINT [DF_pAMLMeasPOM_TolPlusConv]  DEFAULT ((0)),
	[TolMinusConv] [numeric](18, 4) NULL CONSTRAINT [DF_pAMLMeasPOM_TolMinusConv]  DEFAULT ((0)),
	[Flag4QA] [int] NULL CONSTRAINT [DF_pAMLMeasPOM_Flag4QA]  DEFAULT ((0)),
	[WSRowId] [int] NOT NULL,
	[SortId] [int] NOT NULL CONSTRAINT [DF_pAMLMeasPOM_SortId]  DEFAULT ((0)),
	[VideoSerialNumber] [int] NULL,
	[ImageSerialNumber] [int] NULL,
	[How2MeasText] [nvarchar](500)  NULL,
	[CUser] [nvarchar](200)  NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
CONSTRAINT [PK_pAMLMeasPOM] PRIMARY KEY CLUSTERED 
(
	[AMLMeasPOMId] ASC
))
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '409', GetDate())
GO