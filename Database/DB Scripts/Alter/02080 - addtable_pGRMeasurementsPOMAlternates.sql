
/****** Object:  Table [dbo].[pGRMeasurementsAlternates]    Script Date: 11/01/2011 14:42:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pGRMeasurementsPOMAlternates]') AND type in (N'U'))
DROP TABLE [dbo].[pGRMeasurementsPOMAlternates]
GO
/****** Object:  Table [dbo].[pGRMeasurementsPOMAlternates]    Script Date: 11/01/2011 14:46:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pGRMeasurementsPOMAlternates](
	[POMAlternatesId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[POMId] [uniqueidentifier] NOT NULL,
	[AlternatesId] [uniqueidentifier] NOT NULL,
	[POMCode] [nvarchar](50) NULL,
	[POMDesc] [nvarchar](200) NULL,
	[AlternatesCode] [nvarchar](10) NULL,
	[AlternatesDesc] [nvarchar](100) NULL,
	[Active] [int] NOT NULL,
	[POMSort] [int] NOT NULL,
	[AlternateSort] [int] NOT NULL,
	[ImageId] [uniqueidentifier] NULL,
	[How2MeasName] [nvarchar](200) NULL,
	[How2MeasText] [nvarchar](4000) NULL,
	[IsLinked] [int] NOT NULL,
	[Cuser] [nvarchar](200) NULL,
	[MUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MDate] [datetime] NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pGRMeasurementsPOMAlternates] ADD  CONSTRAINT [DF_pGRMeasurementsPOMAlternates_POMAlternatesId]  DEFAULT (newid()) FOR [POMAlternatesId]
GO

ALTER TABLE [dbo].[pGRMeasurementsPOMAlternates] ADD  CONSTRAINT [DF_pGRMeasurementsPOMAlternates_POMSort]  DEFAULT ((0)) FOR [POMSort]
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02080'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02080', GetDate())
	END
GO