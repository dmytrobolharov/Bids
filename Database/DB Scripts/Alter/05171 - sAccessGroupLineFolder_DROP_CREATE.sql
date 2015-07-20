
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupLineFolder_AccessLineId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupLineFolder] DROP CONSTRAINT [DF_sAccessGroupLineFolder_AccessLineId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupLineFolder_AccessRoleId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupLineFolder] DROP CONSTRAINT [DF_sAccessGroupLineFolder_AccessRoleId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupLineFolder_AccessView]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupLineFolder] DROP CONSTRAINT [DF_sAccessGroupLineFolder_AccessView]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupLineFolder_AccessCreate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupLineFolder] DROP CONSTRAINT [DF_sAccessGroupLineFolder_AccessCreate]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupLineFolder_AccessModify]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupLineFolder] DROP CONSTRAINT [DF_sAccessGroupLineFolder_AccessModify]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupLineFolder_AccessDelete]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupLineFolder] DROP CONSTRAINT [DF_sAccessGroupLineFolder_AccessDelete]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupLineFolder_AccessPrint]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupLineFolder] DROP CONSTRAINT [DF_sAccessGroupLineFolder_AccessPrint]
END

GO

/****** Object:  Table [dbo].[sAccessGroupLineFolder]    Script Date: 02/26/2013 17:06:39 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroupLineFolder]') AND type in (N'U'))
DROP TABLE [dbo].[sAccessGroupLineFolder]
GO

/****** Object:  Table [dbo].[sAccessGroupLineFolder]    Script Date: 02/26/2013 17:06:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sAccessGroupLineFolder](
	[AccessLineId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[LineTypeId] [uniqueidentifier] NOT NULL,
	[AccessRoleId] [int] NOT NULL,
	[AccessView] [int] NOT NULL,
	[AccessCreate] [int] NOT NULL,
	[AccessModify] [int] NOT NULL,
	[AccessDelete] [int] NOT NULL,
	[AccessPrint] [int] NOT NULL,
	[GroupID] [uniqueidentifier] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_sAccessGroupLineFolder] PRIMARY KEY CLUSTERED 
(
	[AccessLineId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sAccessGroupLineFolder] ADD  CONSTRAINT [DF_sAccessGroupLineFolder_AccessLineId]  DEFAULT (newid()) FOR [AccessLineId]
GO

ALTER TABLE [dbo].[sAccessGroupLineFolder] ADD  CONSTRAINT [DF_sAccessGroupLineFolder_AccessRoleId]  DEFAULT ((0)) FOR [AccessRoleId]
GO

ALTER TABLE [dbo].[sAccessGroupLineFolder] ADD  CONSTRAINT [DF_sAccessGroupLineFolder_AccessView]  DEFAULT ((0)) FOR [AccessView]
GO

ALTER TABLE [dbo].[sAccessGroupLineFolder] ADD  CONSTRAINT [DF_sAccessGroupLineFolder_AccessCreate]  DEFAULT ((0)) FOR [AccessCreate]
GO

ALTER TABLE [dbo].[sAccessGroupLineFolder] ADD  CONSTRAINT [DF_sAccessGroupLineFolder_AccessModify]  DEFAULT ((0)) FOR [AccessModify]
GO

ALTER TABLE [dbo].[sAccessGroupLineFolder] ADD  CONSTRAINT [DF_sAccessGroupLineFolder_AccessDelete]  DEFAULT ((0)) FOR [AccessDelete]
GO

ALTER TABLE [dbo].[sAccessGroupLineFolder] ADD  CONSTRAINT [DF_sAccessGroupLineFolder_AccessPrint]  DEFAULT ((0)) FOR [AccessPrint]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05171', GetDate())
GO
