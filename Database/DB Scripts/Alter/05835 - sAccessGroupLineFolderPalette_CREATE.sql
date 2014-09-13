IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupLineFolderPalette_AccessLinePaletteID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupLineFolderPalette] DROP CONSTRAINT [DF_sAccessGroupLineFolderPalette_AccessLinePaletteID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupLineFolderPalette_AccessRoleId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupLineFolderPalette] DROP CONSTRAINT [DF_sAccessGroupLineFolderPalette_AccessRoleId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupLineFolderPalette_AccessRead]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupLineFolderPalette] DROP CONSTRAINT [DF_sAccessGroupLineFolderPalette_AccessRead]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupLineFolderPalette_AccessCreate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupLineFolderPalette] DROP CONSTRAINT [DF_sAccessGroupLineFolderPalette_AccessCreate]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupLineFolderPalette_AccessModify]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupLineFolderPalette] DROP CONSTRAINT [DF_sAccessGroupLineFolderPalette_AccessModify]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupLineFolderPalette_AccessDelete]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupLineFolderPalette] DROP CONSTRAINT [DF_sAccessGroupLineFolderPalette_AccessDelete]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupLineFolderPalette_AccessPrint]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupLineFolderPalette] DROP CONSTRAINT [DF_sAccessGroupLineFolderPalette_AccessPrint]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupLineFolderPalette_CDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupLineFolderPalette] DROP CONSTRAINT [DF_sAccessGroupLineFolderPalette_CDate]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupLineFolderPalette_MDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupLineFolderPalette] DROP CONSTRAINT [DF_sAccessGroupLineFolderPalette_MDate]
END

GO

/****** Object:  Table [dbo].[sAccessGroupLineFolderPalette]    Script Date: 06/11/2013 13:37:32 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroupLineFolderPalette]') AND type in (N'U'))
DROP TABLE [dbo].[sAccessGroupLineFolderPalette]
GO

/****** Object:  Table [dbo].[sAccessGroupLineFolderPalette]    Script Date: 06/11/2013 13:37:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sAccessGroupLineFolderPalette](
	[AccessLinePaletteID] [uniqueidentifier] NOT NULL,
	[AccessLineID] [uniqueidentifier] NOT NULL,
	[LineTypeID] [uniqueidentifier] NOT NULL,
	[LinePaletteID] [uniqueidentifier] NOT NULL,
	[AccessRoleId] [int] NULL,
	[AccessView] [int] NULL,
	[AccessCreate] [int] NULL,
	[AccessModify] [int] NULL,
	[AccessDelete] [int] NULL,
	[AccessPrint] [int] NULL,
	[GroupID] [uniqueidentifier] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_sAccessGroupLineFolderPalette] PRIMARY KEY CLUSTERED 
(
	[AccessLinePaletteID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sAccessGroupLineFolderPalette] ADD  CONSTRAINT [DF_sAccessGroupLineFolderPalette_AccessLinePaletteID]  DEFAULT (newid()) FOR [AccessLinePaletteID]
GO

ALTER TABLE [dbo].[sAccessGroupLineFolderPalette] ADD  CONSTRAINT [DF_sAccessGroupLineFolderPalette_AccessRoleId]  DEFAULT ((0)) FOR [AccessRoleId]
GO

ALTER TABLE [dbo].[sAccessGroupLineFolderPalette] ADD  CONSTRAINT [DF_sAccessGroupLineFolderPalette_AccessRead]  DEFAULT ((0)) FOR [AccessView]
GO

ALTER TABLE [dbo].[sAccessGroupLineFolderPalette] ADD  CONSTRAINT [DF_sAccessGroupLineFolderPalette_AccessCreate]  DEFAULT ((0)) FOR [AccessCreate]
GO

ALTER TABLE [dbo].[sAccessGroupLineFolderPalette] ADD  CONSTRAINT [DF_sAccessGroupLineFolderPalette_AccessModify]  DEFAULT ((0)) FOR [AccessModify]
GO

ALTER TABLE [dbo].[sAccessGroupLineFolderPalette] ADD  CONSTRAINT [DF_sAccessGroupLineFolderPalette_AccessDelete]  DEFAULT ((0)) FOR [AccessDelete]
GO

ALTER TABLE [dbo].[sAccessGroupLineFolderPalette] ADD  CONSTRAINT [DF_sAccessGroupLineFolderPalette_AccessPrint]  DEFAULT ((0)) FOR [AccessPrint]
GO

ALTER TABLE [dbo].[sAccessGroupLineFolderPalette] ADD  CONSTRAINT [DF_sAccessGroupLineFolderPalette_CDate]  DEFAULT (getdate()) FOR [CDate]
GO

ALTER TABLE [dbo].[sAccessGroupLineFolderPalette] ADD  CONSTRAINT [DF_sAccessGroupLineFolderPalette_MDate]  DEFAULT (getdate()) FOR [MDate]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05835', GetDate())
GO
