IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleBOMDimensionTempColor_pStyleBOMDimensionTempColorID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleBOMDimensionTempColor] DROP CONSTRAINT [DF_pStyleBOMDimensionTempColor_pStyleBOMDimensionTempColorID]
END

GO

/****** Object:  Table [dbo].[pStyleBOMDimensionTempColor]    Script Date: 04/29/2013 14:46:03 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleBOMDimensionTempColor]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleBOMDimensionTempColor]
GO

/****** Object:  Table [dbo].[pStyleBOMDimensionTempColor]    Script Date: 04/29/2013 14:46:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleBOMDimensionTempColor](
	[StyleBOMDimensionTempColorID] [uniqueidentifier] NOT NULL,
	[TeamID] [uniqueidentifier] NULL,
	[ColorPaletteID] [uniqueidentifier] NULL,
	[StyleBOMDimensionID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_pStyleBOMDimensionTempColor] PRIMARY KEY CLUSTERED 
(
	[StyleBOMDimensionTempColorID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleBOMDimensionTempColor] ADD  CONSTRAINT [DF_pStyleBOMDimensionTempColor_pStyleBOMDimensionTempColorID]  DEFAULT (newid()) FOR [StyleBOMDimensionTempColorID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05649', GetDate())
GO
