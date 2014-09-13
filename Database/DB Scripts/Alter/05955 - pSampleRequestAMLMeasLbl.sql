IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestAMLMeasLbl_AMLMeasLblId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasLbl] DROP CONSTRAINT [DF_pSampleRequestAMLMeasLbl_AMLMeasLblId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestAMLMeasLbl_IsVisible]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasLbl] DROP CONSTRAINT [DF_pSampleRequestAMLMeasLbl_IsVisible]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSampleRequestAMLMeasLbl_IsSample]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSampleRequestAMLMeasLbl] DROP CONSTRAINT [DF_pSampleRequestAMLMeasLbl_IsSample]
END

GO


/****** Object:  Table [dbo].[pSampleRequestAMLMeasLbl]    Script Date: 07/02/2013 15:38:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSampleRequestAMLMeasLbl]') AND type in (N'U'))
DROP TABLE [dbo].[pSampleRequestAMLMeasLbl]
GO


/****** Object:  Table [dbo].[pSampleRequestAMLMeasLbl]    Script Date: 07/02/2013 15:38:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pSampleRequestAMLMeasLbl](
	[SampleRequestAMLMeasLblId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SampleRequestAMLMeasHdrId] [uniqueidentifier] NULL,
	[PDMPageId] [int] NULL,
	[SizeRangeId] [uniqueidentifier] NULL,
	[SizeRangeDetailId] [uniqueidentifier] NULL,
	[SizeCol] [int] NOT NULL,
	[MeasLbl] [nvarchar](24) NULL,
	[IsVisible] [int] NOT NULL,
	[IsSample] [int] NOT NULL,
	[MeasDesc] [nvarchar](20) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[MeasLblDesc] [nvarchar](200) NULL,
 CONSTRAINT [PK_pSampleRequestAMLMeasLbl] PRIMARY KEY CLUSTERED 
(
	[SampleRequestAMLMeasLblId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasLbl] ADD  CONSTRAINT [DF_pSampleRequestAMLMeasLbl_AMLMeasLblId]  DEFAULT (newid()) FOR [SampleRequestAMLMeasLblId]
GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasLbl] ADD  CONSTRAINT [DF_pSampleRequestAMLMeasLbl_IsVisible]  DEFAULT ((0)) FOR [IsVisible]
GO

ALTER TABLE [dbo].[pSampleRequestAMLMeasLbl] ADD  CONSTRAINT [DF_pSampleRequestAMLMeasLbl_IsSample]  DEFAULT ((0)) FOR [IsSample]
GO

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05955', GetDate())
GO