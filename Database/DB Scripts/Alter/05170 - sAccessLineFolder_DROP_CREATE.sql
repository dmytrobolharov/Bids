IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessLineFolder_AccessLineId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessLineFolder] DROP CONSTRAINT [DF_sAccessLineFolder_AccessLineId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessLineFolder_AccessRoleId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessLineFolder] DROP CONSTRAINT [DF_sAccessLineFolder_AccessRoleId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessLineFolder_AccessView]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessLineFolder] DROP CONSTRAINT [DF_sAccessLineFolder_AccessView]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessLineFolder_AccessCreate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessLineFolder] DROP CONSTRAINT [DF_sAccessLineFolder_AccessCreate]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessLineFolder_AccessModify]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessLineFolder] DROP CONSTRAINT [DF_sAccessLineFolder_AccessModify]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessLineFolder_AccessDelete]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessLineFolder] DROP CONSTRAINT [DF_sAccessLineFolder_AccessDelete]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessLineFolder_AcessPrint]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessLineFolder] DROP CONSTRAINT [DF_sAccessLineFolder_AcessPrint]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__sAccessLi__LineT__3A4FD659]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessLineFolder] DROP CONSTRAINT [DF__sAccessLi__LineT__3A4FD659]
END

GO

/****** Object:  Table [dbo].[sAccessLineFolder]    Script Date: 02/26/2013 17:05:52 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessLineFolder]') AND type in (N'U'))
DROP TABLE [dbo].[sAccessLineFolder]
GO

/****** Object:  Table [dbo].[sAccessLineFolder]    Script Date: 02/26/2013 17:05:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sAccessLineFolder](
	[AccessLineId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[AccessRoleId] [int] NOT NULL,
	[AccessView] [int] NOT NULL,
	[AccessCreate] [int] NOT NULL,
	[AccessModify] [int] NOT NULL,
	[AccessDelete] [int] NOT NULL,
	[AccessPrint] [int] NOT NULL,
	[TeamId] [uniqueidentifier] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[LineTypeID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_sAccessLineFolder] PRIMARY KEY CLUSTERED 
(
	[AccessLineId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sAccessLineFolder] ADD  CONSTRAINT [DF_sAccessLineFolder_AccessLineId]  DEFAULT (newid()) FOR [AccessLineId]
GO

ALTER TABLE [dbo].[sAccessLineFolder] ADD  CONSTRAINT [DF_sAccessLineFolder_AccessRoleId]  DEFAULT ((0)) FOR [AccessRoleId]
GO

ALTER TABLE [dbo].[sAccessLineFolder] ADD  CONSTRAINT [DF_sAccessLineFolder_AccessView]  DEFAULT ((0)) FOR [AccessView]
GO

ALTER TABLE [dbo].[sAccessLineFolder] ADD  CONSTRAINT [DF_sAccessLineFolder_AccessCreate]  DEFAULT ((0)) FOR [AccessCreate]
GO

ALTER TABLE [dbo].[sAccessLineFolder] ADD  CONSTRAINT [DF_sAccessLineFolder_AccessModify]  DEFAULT ((0)) FOR [AccessModify]
GO

ALTER TABLE [dbo].[sAccessLineFolder] ADD  CONSTRAINT [DF_sAccessLineFolder_AccessDelete]  DEFAULT ((0)) FOR [AccessDelete]
GO

ALTER TABLE [dbo].[sAccessLineFolder] ADD  CONSTRAINT [DF_sAccessLineFolder_AcessPrint]  DEFAULT ((0)) FOR [AccessPrint]
GO

ALTER TABLE [dbo].[sAccessLineFolder] ADD  DEFAULT ('00000000-0000-0000-0000-000000000000') FOR [LineTypeID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05170', GetDate())
GO
