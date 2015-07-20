IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupOldSourcing_AccessOldSourcingID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupOldSourcing] DROP CONSTRAINT [DF_sAccessGroupOldSourcing_AccessOldSourcingID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupOldSourcing_AccessRoleId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupOldSourcing] DROP CONSTRAINT [DF_sAccessGroupOldSourcing_AccessRoleId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupOldSourcing_AccessView]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupOldSourcing] DROP CONSTRAINT [DF_sAccessGroupOldSourcing_AccessView]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupOldSourcing_AccessCreate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupOldSourcing] DROP CONSTRAINT [DF_sAccessGroupOldSourcing_AccessCreate]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupOldSourcing_AccessModify]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupOldSourcing] DROP CONSTRAINT [DF_sAccessGroupOldSourcing_AccessModify]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupOldSourcing_AccessDelete]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupOldSourcing] DROP CONSTRAINT [DF_sAccessGroupOldSourcing_AccessDelete]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupOldSourcing_AccessPrint]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupOldSourcing] DROP CONSTRAINT [DF_sAccessGroupOldSourcing_AccessPrint]
END

GO

/****** Object:  Table [dbo].[sAccessGroupOldSourcing]    Script Date: 02/11/2013 15:48:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroupOldSourcing]') AND type in (N'U'))
DROP TABLE [dbo].[sAccessGroupOldSourcing]
GO

/****** Object:  Table [dbo].[sAccessGroupOldSourcing]    Script Date: 02/11/2013 15:48:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sAccessGroupOldSourcing](
	[AccessOldSourcingID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[StyleTypeId] [int] NOT NULL,
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
 CONSTRAINT [PK_sAccessGroupOldSourcing] PRIMARY KEY CLUSTERED 
(
	[AccessOldSourcingID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sAccessGroupOldSourcing] ADD  CONSTRAINT [DF_sAccessGroupOldSourcing_AccessOldSourcingID]  DEFAULT (newid()) FOR [AccessOldSourcingID]
GO

ALTER TABLE [dbo].[sAccessGroupOldSourcing] ADD  CONSTRAINT [DF_sAccessGroupOldSourcing_AccessRoleId]  DEFAULT ((0)) FOR [AccessRoleId]
GO

ALTER TABLE [dbo].[sAccessGroupOldSourcing] ADD  CONSTRAINT [DF_sAccessGroupOldSourcing_AccessView]  DEFAULT ((0)) FOR [AccessView]
GO

ALTER TABLE [dbo].[sAccessGroupOldSourcing] ADD  CONSTRAINT [DF_sAccessGroupOldSourcing_AccessCreate]  DEFAULT ((0)) FOR [AccessCreate]
GO

ALTER TABLE [dbo].[sAccessGroupOldSourcing] ADD  CONSTRAINT [DF_sAccessGroupOldSourcing_AccessModify]  DEFAULT ((0)) FOR [AccessModify]
GO

ALTER TABLE [dbo].[sAccessGroupOldSourcing] ADD  CONSTRAINT [DF_sAccessGroupOldSourcing_AccessDelete]  DEFAULT ((0)) FOR [AccessDelete]
GO

ALTER TABLE [dbo].[sAccessGroupOldSourcing] ADD  CONSTRAINT [DF_sAccessGroupOldSourcing_AccessPrint]  DEFAULT ((0)) FOR [AccessPrint]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05029', GetDate())
GO
