
/****** Object:  Table [dbo].[pQAPom]    Script Date: 07/14/2011 11:56:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pQAPom]') AND type in (N'U'))
	DROP TABLE [dbo].[pQAPom]
GO

CREATE TABLE [dbo].[pQAPom](
	[SamplePomId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[SampleRequestHeaderId] [uniqueidentifier] NOT NULL,
	[AMLMeasHdrId] [uniqueidentifier] NULL,
	[AmlMeaspomid] [uniqueidentifier] NULL,
	[POMRow] [int] NOT NULL,
	[Refcode] [nvarchar](12) NULL,
	[POMDescription] [nvarchar](204) NULL,
	[TolPlus] [numeric](18, 4) NOT NULL,
	[TolMinus] [numeric](18, 4) NOT NULL,
	[WSRowId] [int] NOT NULL,
	[HowToMeasurText] [nvarchar](4000) NULL,
	[ImageId] [uniqueidentifier] NULL,
	[SortId] [int] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pQAPom] PRIMARY KEY CLUSTERED 
(
	[SamplePomId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pQAPom] ADD  CONSTRAINT [DF_pQAPom_SamplePomId]  DEFAULT (newid()) FOR [SamplePomId]
GO

ALTER TABLE [dbo].[pQAPom] ADD  CONSTRAINT [DF_pQAPom_TolPlus]  DEFAULT ((0)) FOR [TolPlus]
GO

ALTER TABLE [dbo].[pQAPom] ADD  CONSTRAINT [DF_pQAPom_TolMinus]  DEFAULT ((0)) FOR [TolMinus]
GO

ALTER TABLE [dbo].[pQAPom] ADD  CONSTRAINT [DF_pQAPom_SortId]  DEFAULT ((0)) FOR [SortId]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES      ('DB_Version', '4.1.0000', '01636', GetDate())
GO