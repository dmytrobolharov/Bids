IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pControlBOMConfig_DimBOM]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pControlBOMConfig] DROP CONSTRAINT [DF_pControlBOMConfig_DimBOM]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pControlBOMConfig_DefBOMPage]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pControlBOMConfig] DROP CONSTRAINT [DF_Table_1_DefBOMPage]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pControlBOMConfig_FillColorway]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pControlBOMConfig] DROP CONSTRAINT [DF_pControlBOMConfig_FillColorway]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pControlBOMConfig_ActiveColor]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pControlBOMConfig] DROP CONSTRAINT [DF_pControlBOMConfig_ActiveColor]
END

GO

/****** Object:  Table [dbo].[pControlBOMConfig]    Script Date: 08/09/2013 16:10:58 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pControlBOMConfig]') AND type in (N'U'))
DROP TABLE [dbo].[pControlBOMConfig]
GO

/****** Object:  Table [dbo].[pControlBOMConfig]    Script Date: 08/09/2013 16:10:58 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pControlBOMConfig](
	[DivisionID] [uniqueidentifier] NOT NULL,
	[StyleTypeID] [int] NOT NULL,
	[StyleCategoryID] [uniqueidentifier] NOT NULL,
	[DimBOM] [bit] NOT NULL,
	[DefaultBOMPage] [bit] NOT NULL,
	[FillColorway] [bit] NOT NULL,
	[ActiveColor] [bit] NOT NULL,
 CONSTRAINT [PK_pControlBOMConfig] PRIMARY KEY CLUSTERED 
(
	[DivisionID] ASC,
	[StyleTypeID] ASC,
	[StyleCategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pControlBOMConfig] ADD  CONSTRAINT [DF_pControlBOMConfig_DimBOM]  DEFAULT ((1)) FOR [DimBOM]
GO

ALTER TABLE [dbo].[pControlBOMConfig] ADD  CONSTRAINT [DF_pControlBOMConfig_DefBOMPage]  DEFAULT ((1)) FOR [DefaultBOMPage]
GO

ALTER TABLE [dbo].[pControlBOMConfig] ADD  CONSTRAINT [DF_pControlBOMConfig_FillColorway]  DEFAULT ((1)) FOR [FillColorway]
GO

ALTER TABLE [dbo].[pControlBOMConfig] ADD  CONSTRAINT [DF_pControlBOMConfig_ActiveColor]  DEFAULT ((1)) FOR [ActiveColor]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06139', GetDate())
GO
