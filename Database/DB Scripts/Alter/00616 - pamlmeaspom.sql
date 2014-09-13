/****** Object:  Table [dbo].[sDeskTop]    Script Date: 10/11/2010 10:30:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pAMLMeasPOM]') AND type in (N'U'))
DROP TABLE [dbo].[pAMLMeasPOM]

GO
/****** Object:  Table [dbo].[pAMLMeasPOM]    Script Date: 10/28/2010 12:47:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pAMLMeasPOM](
	[AMLMeasPOMId] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_pAMLMeasPOM_AMLMeasPOMId]  DEFAULT (newid()),
	[AMLMeasHdrId] [uniqueidentifier] NULL,
	[PDMPageId] [int] NULL,
	[GRPOMCompanyId] [uniqueidentifier] NULL,
	[POMGuidId] [uniqueidentifier] NULL,
	[POMAlternatesId] [uniqueidentifier] NULL,
	[POM_Row] [int] NOT NULL,
	[RefCode] [nvarchar](12) NULL,
	[Description] [nvarchar](204) NULL,
	[TolPlus] [numeric](18, 4) NULL CONSTRAINT [DF_pAMLMeasPOM_TolPlus]  DEFAULT ((0)),
	[TolMinus] [numeric](18, 4) NULL CONSTRAINT [DF_pAMLMeasPOM_TolMinus]  DEFAULT ((0)),
	[TolPlusConv] [numeric](18, 4) NULL CONSTRAINT [DF_pAMLMeasPOM_TolPlusConv]  DEFAULT ((0)),
	[TolMinusConv] [numeric](18, 4) NULL CONSTRAINT [DF_pAMLMeasPOM_TolMinusConv]  DEFAULT ((0)),
	[Flag4QA] [int] NULL CONSTRAINT [DF_pAMLMeasPOM_Flag4QA]  DEFAULT ((0)),
	[WSRowId] [int] NOT NULL,
	[SortId] [int] NOT NULL CONSTRAINT [DF_pAMLMeasPOM_SortId]  DEFAULT ((0)),
	[VideoSerialnumber] [int] NULL CONSTRAINT [DF_pAMLMeasPOM_VideoSerialnumber]  DEFAULT ((0)),
	[ImageSerialnumber] [int] NULL CONSTRAINT [DF_pAMLMeasPOM_ImageSerialnumber]  DEFAULT ((0)),
	[ImageId] [uniqueidentifier] NULL,
	[How2MeasText] [nvarchar](500) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pAMLMeasPOM] PRIMARY KEY CLUSTERED 
(
	[AMLMeasPOMId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '616', GetDate())
GO