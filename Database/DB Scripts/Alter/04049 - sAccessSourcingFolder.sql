IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessSourcingFolder_AccessSourcingID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessSourcingFolder] DROP CONSTRAINT [DF_sAccessSourcingFolder_AccessSourcingID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessSourcingFolder_AccessRoleId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessSourcingFolder] DROP CONSTRAINT [DF_sAccessSourcingFolder_AccessRoleId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessSourcingFolder_AccessView]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessSourcingFolder] DROP CONSTRAINT [DF_sAccessSourcingFolder_AccessView]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessSourcingFolder_AccessCreate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessSourcingFolder] DROP CONSTRAINT [DF_sAccessSourcingFolder_AccessCreate]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessSourcingFolder_AccessModify]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessSourcingFolder] DROP CONSTRAINT [DF_sAccessSourcingFolder_AccessModify]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessSourcingFolder_AccessDelete]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessSourcingFolder] DROP CONSTRAINT [DF_sAccessSourcingFolder_AccessDelete]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessSourcingFolder_AccessPrint]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessSourcingFolder] DROP CONSTRAINT [DF_sAccessSourcingFolder_AccessPrint]
END

GO

/****** Object:  Table [dbo].[sAccessSourcingFolder]    Script Date: 10/01/2012 18:27:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessSourcingFolder]') AND type in (N'U'))
DROP TABLE [dbo].[sAccessSourcingFolder]
GO

/****** Object:  Table [dbo].[sAccessSourcingFolder]    Script Date: 10/01/2012 18:27:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[sAccessSourcingFolder](
	[AccessSourcingID] [uniqueidentifier] NOT NULL,
	[SourcingTypeId] [char](10) NOT NULL,
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
 CONSTRAINT [PK_sAccessSourcingFolder] PRIMARY KEY CLUSTERED 
(
	[AccessSourcingID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[sAccessSourcingFolder] ADD  CONSTRAINT [DF_sAccessSourcingFolder_AccessSourcingID]  DEFAULT (newid()) FOR [AccessSourcingID]
GO

ALTER TABLE [dbo].[sAccessSourcingFolder] ADD  CONSTRAINT [DF_sAccessSourcingFolder_AccessRoleId]  DEFAULT ((0)) FOR [AccessRoleId]
GO

ALTER TABLE [dbo].[sAccessSourcingFolder] ADD  CONSTRAINT [DF_sAccessSourcingFolder_AccessView]  DEFAULT ((0)) FOR [AccessView]
GO

ALTER TABLE [dbo].[sAccessSourcingFolder] ADD  CONSTRAINT [DF_sAccessSourcingFolder_AccessCreate]  DEFAULT ((0)) FOR [AccessCreate]
GO

ALTER TABLE [dbo].[sAccessSourcingFolder] ADD  CONSTRAINT [DF_sAccessSourcingFolder_AccessModify]  DEFAULT ((0)) FOR [AccessModify]
GO

ALTER TABLE [dbo].[sAccessSourcingFolder] ADD  CONSTRAINT [DF_sAccessSourcingFolder_AccessDelete]  DEFAULT ((0)) FOR [AccessDelete]
GO

ALTER TABLE [dbo].[sAccessSourcingFolder] ADD  CONSTRAINT [DF_sAccessSourcingFolder_AccessPrint]  DEFAULT ((0)) FOR [AccessPrint]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04049', GetDate())

GO

