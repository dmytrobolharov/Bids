IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleBOMConfig_StyleBOMConfigID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleBOMConfig] DROP CONSTRAINT [DF_pStyleBOMConfig_StyleBOMConfigID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleBOMConfig_DimBOM]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleBOMConfig] DROP CONSTRAINT [DF_pStyleBOMConfig_DimBOM]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleBOMConfig_DefaultBOMPage]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleBOMConfig] DROP CONSTRAINT [DF_pStyleBOMConfig_DefaultBOMPage]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleBOMConfig_FillColorway]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleBOMConfig] DROP CONSTRAINT [DF_pStyleBOMConfig_FillColorway]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleBOMConfig_ActiveColor]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleBOMConfig] DROP CONSTRAINT [DF_pStyleBOMConfig_ActiveColor]
END

GO

/****** Object:  Table [dbo].[pStyleBOMConfig]    Script Date: 08/12/2013 15:13:47 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMConfig]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleBOMConfig]
GO

/****** Object:  Table [dbo].[pStyleBOMConfig]    Script Date: 08/12/2013 15:13:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleBOMConfig](
	[StyleBOMConfigID] [uniqueidentifier] NOT NULL,
	[StyleBOMDimensionID] [uniqueidentifier] NOT NULL,
	[DimBOM] [bit] NOT NULL,
	[DefaultBOMPage] [bit] NOT NULL,
	[FillColorway] [bit] NOT NULL,
	[ActiveColor] [bit] NOT NULL,
 CONSTRAINT [PK_pStyleBOMConfig] PRIMARY KEY CLUSTERED 
(
	[StyleBOMConfigID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleBOMConfig] ADD  CONSTRAINT [DF_pStyleBOMConfig_StyleBOMConfigID]  DEFAULT (newid()) FOR [StyleBOMConfigID]
GO

ALTER TABLE [dbo].[pStyleBOMConfig] ADD  CONSTRAINT [DF_pStyleBOMConfig_DimBOM]  DEFAULT ((1)) FOR [DimBOM]
GO

ALTER TABLE [dbo].[pStyleBOMConfig] ADD  CONSTRAINT [DF_pStyleBOMConfig_DefaultBOMPage]  DEFAULT ((1)) FOR [DefaultBOMPage]
GO

ALTER TABLE [dbo].[pStyleBOMConfig] ADD  CONSTRAINT [DF_pStyleBOMConfig_FillColorway]  DEFAULT ((1)) FOR [FillColorway]
GO

ALTER TABLE [dbo].[pStyleBOMConfig] ADD  CONSTRAINT [DF_pStyleBOMConfig_ActiveColor]  DEFAULT ((1)) FOR [ActiveColor]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06141', GetDate())
GO
