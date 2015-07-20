
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupSourcingFolder_AccessSourcingID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupSourcingFolder] DROP CONSTRAINT [DF_sAccessGroupSourcingFolder_AccessSourcingID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupSourcingFolder_AccessRoleId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupSourcingFolder] DROP CONSTRAINT [DF_sAccessGroupSourcingFolder_AccessRoleId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupSourcingFolder_AccessView]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupSourcingFolder] DROP CONSTRAINT [DF_sAccessGroupSourcingFolder_AccessView]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupSourcingFolder_AccessCreate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupSourcingFolder] DROP CONSTRAINT [DF_sAccessGroupSourcingFolder_AccessCreate]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupSourcingFolder_AccessModify]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupSourcingFolder] DROP CONSTRAINT [DF_sAccessGroupSourcingFolder_AccessModify]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupSourcingFolder_AccessDelete]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupSourcingFolder] DROP CONSTRAINT [DF_sAccessGroupSourcingFolder_AccessDelete]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupSourcingFolder_AccessPrint]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupSourcingFolder] DROP CONSTRAINT [DF_sAccessGroupSourcingFolder_AccessPrint]
END

GO

/****** Object:  Table [dbo].[sAccessGroupSourcingFolder]    Script Date: 10/01/2012 18:22:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroupSourcingFolder]') AND type in (N'U'))
DROP TABLE [dbo].[sAccessGroupSourcingFolder]
GO


/****** Object:  Table [dbo].[sAccessGroupSourcingFolder]    Script Date: 10/01/2012 18:22:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[sAccessGroupSourcingFolder](
	[AccessSourcingID] [uniqueidentifier] NOT NULL,
	[SourcingTypeId] [char](10) NOT NULL,
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
 CONSTRAINT [PK_sAccessGroupSourcingFolder] PRIMARY KEY CLUSTERED 
(
	[AccessSourcingID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[sAccessGroupSourcingFolder] ADD  CONSTRAINT [DF_sAccessGroupSourcingFolder_AccessSourcingID]  DEFAULT (newid()) FOR [AccessSourcingID]
GO

ALTER TABLE [dbo].[sAccessGroupSourcingFolder] ADD  CONSTRAINT [DF_sAccessGroupSourcingFolder_AccessRoleId]  DEFAULT ((0)) FOR [AccessRoleId]
GO

ALTER TABLE [dbo].[sAccessGroupSourcingFolder] ADD  CONSTRAINT [DF_sAccessGroupSourcingFolder_AccessView]  DEFAULT ((0)) FOR [AccessView]
GO

ALTER TABLE [dbo].[sAccessGroupSourcingFolder] ADD  CONSTRAINT [DF_sAccessGroupSourcingFolder_AccessCreate]  DEFAULT ((0)) FOR [AccessCreate]
GO

ALTER TABLE [dbo].[sAccessGroupSourcingFolder] ADD  CONSTRAINT [DF_sAccessGroupSourcingFolder_AccessModify]  DEFAULT ((0)) FOR [AccessModify]
GO

ALTER TABLE [dbo].[sAccessGroupSourcingFolder] ADD  CONSTRAINT [DF_sAccessGroupSourcingFolder_AccessDelete]  DEFAULT ((0)) FOR [AccessDelete]
GO

ALTER TABLE [dbo].[sAccessGroupSourcingFolder] ADD  CONSTRAINT [DF_sAccessGroupSourcingFolder_AccessPrint]  DEFAULT ((0)) FOR [AccessPrint]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04048', GetDate())

GO
