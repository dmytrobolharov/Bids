IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestAMLMeasPOM_AMLMeasPOMId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] DROP CONSTRAINT [DF_pSampleRequestAMLMeasPOM_AMLMeasPOMId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestAMLMeasPOM_TolPlus]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] DROP CONSTRAINT [DF_pSampleRequestAMLMeasPOM_TolPlus]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestAMLMeasPOM_TolMinus]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] DROP CONSTRAINT [DF_pSampleRequestAMLMeasPOM_TolMinus]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestAMLMeasPOM_TolPlusConv]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] DROP CONSTRAINT [DF_pSampleRequestAMLMeasPOM_TolPlusConv]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestAMLMeasPOM_TolMinusConv]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] DROP CONSTRAINT [DF_pSampleRequestAMLMeasPOM_TolMinusConv]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestAMLMeasPOM_Flag4QA]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] DROP CONSTRAINT [DF_pSampleRequestAMLMeasPOM_Flag4QA]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestAMLMeasPOM_SortId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] DROP CONSTRAINT [DF_pSampleRequestAMLMeasPOM_SortId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestSampleRequestAMLMeasPOM_VideoSerialnumber]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] DROP CONSTRAINT [DF_pSampleRequestSampleRequestAMLMeasPOM_VideoSerialnumber]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestAMLMeasPOM_ImageSerialnumber]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] DROP CONSTRAINT [DF_pSampleRequestAMLMeasPOM_ImageSerialnumber]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestAMLMeasPOM_IsLinked]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] DROP CONSTRAINT [DF_pSampleRequestAMLMeasPOM_IsLinked]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestAMLMeasPOM_Critical]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] DROP CONSTRAINT [DF_pSampleRequestAMLMeasPOM_Critical]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestAMLMeasPOM_IsLength]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] DROP CONSTRAINT [DF_pSampleRequestAMLMeasPOM_IsLength]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestAMLMeasPOM_IsWidth]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] DROP CONSTRAINT [DF_pSampleRequestAMLMeasPOM_IsWidth]
END

GO

/****** Object:  Table [dbo].[pSampleRequestAMLMeasPOM]    Script Date: 07/02/2013 15:39:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestAMLMeasPOM]') AND type in (N'U'))
DROP TABLE [dbo].[pSampleRequestAMLMeasPOM]
GO


/****** Object:  Table [dbo].[pSampleRequestAMLMeasPOM]    Script Date: 07/02/2013 15:39:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSampleRequestAMLMeasPOM](
	[SampleRequestAMLMeasPOMId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SampleRequestAMLMeasHdrId] [uniqueidentifier] NULL,
	[PDMPageId] [int] NULL,
	[GRPOMCompanyId] [uniqueidentifier] NULL,
	[POMGuidId] [uniqueidentifier] NULL,
	[POMAlternatesId] [uniqueidentifier] NULL,
	[POM_Row] [int] NOT NULL,
	[RefCode] [nvarchar](50) NULL,
	[Description] [nvarchar](204) NULL,
	[TolPlus] [numeric](18, 4) NULL,
	[TolMinus] [numeric](18, 4) NULL,
	[TolPlusConv] [numeric](18, 4) NULL,
	[TolMinusConv] [numeric](18, 4) NULL,
	[Flag4QA] [int] NULL,
	[WSRowId] [int] NOT NULL,
	[SortId] [int] NOT NULL,
	[VideoSerialnumber] [int] NULL,
	[ImageSerialnumber] [int] NULL,
	[ImageId] [uniqueidentifier] NULL,
	[How2MeasText] [nvarchar](500) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[IsLinked] [int] NULL,
	[Critical] [int] NULL,
	[How2MeasName] [nvarchar](200) NULL,
	[FabricType] [nvarchar](100) NULL,
	[IsLength] [int] NULL,
	[IsWidth] [int] NULL,
	[ShrinkX] [numeric](18, 4) NULL,
	[ShrinkY] [numeric](18, 4) NULL,
	[CADModelId] [nvarchar](100) NULL,
	[BeforeTreat] [numeric](18, 4) NULL,
	[SampMeasValue] [numeric](18, 4) NULL,
	[SampDelta] [numeric](18, 4) NULL,
	[RevisedSpec] [numeric](18, 4) NULL,
 CONSTRAINT [PK_pSampleRequestAMLMeasPOM] PRIMARY KEY CLUSTERED 
(
	[SampleRequestAMLMeasPOMId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] ADD  CONSTRAINT [DF_pSampleRequestAMLMeasPOM_AMLMeasPOMId]  DEFAULT (newid()) FOR [SampleRequestAMLMeasPOMId]
GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] ADD  CONSTRAINT [DF_pSampleRequestAMLMeasPOM_TolPlus]  DEFAULT ((0)) FOR [TolPlus]
GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] ADD  CONSTRAINT [DF_pSampleRequestAMLMeasPOM_TolMinus]  DEFAULT ((0)) FOR [TolMinus]
GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] ADD  CONSTRAINT [DF_pSampleRequestAMLMeasPOM_TolPlusConv]  DEFAULT ((0)) FOR [TolPlusConv]
GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] ADD  CONSTRAINT [DF_pSampleRequestAMLMeasPOM_TolMinusConv]  DEFAULT ((0)) FOR [TolMinusConv]
GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] ADD  CONSTRAINT [DF_pSampleRequestAMLMeasPOM_Flag4QA]  DEFAULT ((0)) FOR [Flag4QA]
GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] ADD  CONSTRAINT [DF_pSampleRequestAMLMeasPOM_SortId]  DEFAULT ((0)) FOR [SortId]
GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] ADD  CONSTRAINT [DF_pSampleRequestSampleRequestAMLMeasPOM_VideoSerialnumber]  DEFAULT ((0)) FOR [VideoSerialnumber]
GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] ADD  CONSTRAINT [DF_pSampleRequestAMLMeasPOM_ImageSerialnumber]  DEFAULT ((0)) FOR [ImageSerialnumber]
GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] ADD  CONSTRAINT [DF_pSampleRequestAMLMeasPOM_IsLinked]  DEFAULT ((0)) FOR [IsLinked]
GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] ADD  CONSTRAINT [DF_pSampleRequestAMLMeasPOM_Critical]  DEFAULT ((0)) FOR [Critical]
GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] ADD  CONSTRAINT [DF_pSampleRequestAMLMeasPOM_IsLength]  DEFAULT ((0)) FOR [IsLength]
GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasPOM] ADD  CONSTRAINT [DF_pSampleRequestAMLMeasPOM_IsWidth]  DEFAULT ((0)) FOR [IsWidth]
GO

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05956', GetDate())
GO