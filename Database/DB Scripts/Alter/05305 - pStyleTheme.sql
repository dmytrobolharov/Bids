IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleTheme_PStyleThemeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleTheme] DROP CONSTRAINT [DF_pStyleTheme_PStyleThemeID]
END

GO


/****** Object:  Table [dbo].[pStyleTheme]    Script Date: 03/15/2013 18:36:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleTheme]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleTheme]
GO


/****** Object:  Table [dbo].[pStyleTheme]    Script Date: 03/15/2013 18:36:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleTheme](
	[StyleThemeID] [uniqueidentifier] NOT NULL,
	[ThemeCode] [nvarchar](200) NULL,
	[ThemeName] [nvarchar](200) NULL,
	[Active] [int] NULL,
	[Sort] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleTheme] ADD  CONSTRAINT [DF_pStyleTheme_PStyleThemeID]  DEFAULT (newid()) FOR [StyleThemeID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05305', GetDate())
GO