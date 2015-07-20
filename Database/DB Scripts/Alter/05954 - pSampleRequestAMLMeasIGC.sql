IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestAMLMeasIGC_AMLMeasIGCId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasIGC] DROP CONSTRAINT [DF_pSampleRequestAMLMeasIGC_AMLMeasIGCId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestAMLMeasIGC_Incr]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasIGC] DROP CONSTRAINT [DF_pSampleRequestAMLMeasIGC_Incr]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestAMLMeasIGC_Grade]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasIGC] DROP CONSTRAINT [DF_pSampleRequestAMLMeasIGC_Grade]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestAMLMeasIGC_ConvGrade]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasIGC] DROP CONSTRAINT [DF_pSampleRequestAMLMeasIGC_ConvGrade]
END

GO


/****** Object:  Table [dbo].[pSampleRequestAMLMeasIGC]    Script Date: 07/02/2013 15:38:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestAMLMeasIGC]') AND type in (N'U'))
DROP TABLE [dbo].[pSampleRequestAMLMeasIGC]
GO


/****** Object:  Table [dbo].[pSampleRequestAMLMeasIGC]    Script Date: 07/02/2013 15:38:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSampleRequestAMLMeasIGC](
	[SampleRequestAMLMeasIGCId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SampleRequestAMLMeasHdrId] [uniqueidentifier] NULL,
	[SampleRequestAMLMeasPOMId] [uniqueidentifier] NULL,
	[PDMPageId] [int] NULL,
	[POM_Row] [int] NOT NULL,
	[WSRowId] [int] NOT NULL,
	[SizeCol] [int] NOT NULL,
	[Incr] [numeric](18, 4) NULL,
	[Grade] [numeric](18, 4) NULL,
	[ConvGrade] [numeric](18, 4) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pSampleRequestAMLMeasIGC] PRIMARY KEY CLUSTERED 
(
	[SampleRequestAMLMeasIGCId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasIGC] ADD  CONSTRAINT [DF_pSampleRequestAMLMeasIGC_AMLMeasIGCId]  DEFAULT (newid()) FOR [SampleRequestAMLMeasIGCId]
GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasIGC] ADD  CONSTRAINT [DF_pSampleRequestAMLMeasIGC_Incr]  DEFAULT ((0)) FOR [Incr]
GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasIGC] ADD  CONSTRAINT [DF_pSampleRequestAMLMeasIGC_Grade]  DEFAULT ((0)) FOR [Grade]
GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasIGC] ADD  CONSTRAINT [DF_pSampleRequestAMLMeasIGC_ConvGrade]  DEFAULT ((0)) FOR [ConvGrade]
GO

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05954', GetDate())
GO