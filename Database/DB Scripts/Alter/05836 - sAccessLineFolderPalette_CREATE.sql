IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessLineFolderPalette_AccessLinePaletteID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessLineFolderPalette] DROP CONSTRAINT [DF_sAccessLineFolderPalette_AccessLinePaletteID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessLineFolderPalette_AccessRoleId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessLineFolderPalette] DROP CONSTRAINT [DF_sAccessLineFolderPalette_AccessRoleId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Table_1_AccessRead]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessLineFolderPalette] DROP CONSTRAINT [DF_sAccessLineFolderPalette_AccessRead]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessLineFolderPalette_AccessCreate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessLineFolderPalette] DROP CONSTRAINT [DF_sAccessLineFolderPalette_AccessCreate]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessLineFolderPalette_AccessModify]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessLineFolderPalette] DROP CONSTRAINT [DF_sAccessLineFolderPalette_AccessModify]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessLineFolderPalette_AccessDelete]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessLineFolderPalette] DROP CONSTRAINT [DF_sAccessLineFolderPalette_AccessDelete]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessLineFolderPalette_AccessPrint]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessLineFolderPalette] DROP CONSTRAINT [DF_sAccessLineFolderPalette_AccessPrint]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessLineFolderPalette_CDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessLineFolderPalette] DROP CONSTRAINT [DF_sAccessLineFolderPalette_CDate]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessLineFolderPalette_MDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessLineFolderPalette] DROP CONSTRAINT [DF_sAccessLineFolderPalette_MDate]
END

GO

/****** Object:  Table [dbo].[sAccessLineFolderPalette]    Script Date: 06/11/2013 13:18:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessLineFolderPalette]') AND type in (N'U'))
DROP TABLE [dbo].[sAccessLineFolderPalette]
GO

/****** Object:  Table [dbo].[sAccessLineFolderPalette]    Script Date: 06/11/2013 13:18:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sAccessLineFolderPalette](
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
	[TeamID] [uniqueidentifier] NOT NULL,
	[GroupID] [uniqueidentifier] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_sAccessLineFolderPalette] PRIMARY KEY CLUSTERED 
(
	[AccessLinePaletteID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sAccessLineFolderPalette] ADD  CONSTRAINT [DF_sAccessLineFolderPalette_AccessLinePaletteID]  DEFAULT (newid()) FOR [AccessLinePaletteID]
GO

ALTER TABLE [dbo].[sAccessLineFolderPalette] ADD  CONSTRAINT [DF_sAccessLineFolderPalette_AccessRoleId]  DEFAULT ((0)) FOR [AccessRoleId]
GO

ALTER TABLE [dbo].[sAccessLineFolderPalette] ADD  CONSTRAINT [DF_sAccessLineFolderPalette_AccessRead]  DEFAULT ((0)) FOR [AccessView]
GO

ALTER TABLE [dbo].[sAccessLineFolderPalette] ADD  CONSTRAINT [DF_sAccessLineFolderPalette_AccessCreate]  DEFAULT ((0)) FOR [AccessCreate]
GO

ALTER TABLE [dbo].[sAccessLineFolderPalette] ADD  CONSTRAINT [DF_sAccessLineFolderPalette_AccessModify]  DEFAULT ((0)) FOR [AccessModify]
GO

ALTER TABLE [dbo].[sAccessLineFolderPalette] ADD  CONSTRAINT [DF_sAccessLineFolderPalette_AccessDelete]  DEFAULT ((0)) FOR [AccessDelete]
GO

ALTER TABLE [dbo].[sAccessLineFolderPalette] ADD  CONSTRAINT [DF_sAccessLineFolderPalette_AccessPrint]  DEFAULT ((0)) FOR [AccessPrint]
GO

ALTER TABLE [dbo].[sAccessLineFolderPalette] ADD  CONSTRAINT [DF_sAccessLineFolderPalette_CDate]  DEFAULT (getdate()) FOR [CDate]
GO

ALTER TABLE [dbo].[sAccessLineFolderPalette] ADD  CONSTRAINT [DF_sAccessLineFolderPalette_MDate]  DEFAULT (getdate()) FOR [MDate]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05836', GetDate())
GO
