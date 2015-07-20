IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessOldSourcing_AccessOldSourcing]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessOldSourcing] DROP CONSTRAINT [DF_sAccessOldSourcing_AccessOldSourcing]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessOldSourcing_AccessRoleId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessOldSourcing] DROP CONSTRAINT [DF_sAccessOldSourcing_AccessRoleId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessOldSourcing_AccessView]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessOldSourcing] DROP CONSTRAINT [DF_sAccessOldSourcing_AccessView]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessOldSourcing_AccessCreate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessOldSourcing] DROP CONSTRAINT [DF_sAccessOldSourcing_AccessCreate]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessOldSourcing_AccessModify]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessOldSourcing] DROP CONSTRAINT [DF_sAccessOldSourcing_AccessModify]
END

GO

/****** Object:  Table [dbo].[sAccessOldSourcing]    Script Date: 02/11/2013 15:43:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessOldSourcing]') AND type in (N'U'))
DROP TABLE [dbo].[sAccessOldSourcing]
GO

/****** Object:  Table [dbo].[sAccessOldSourcing]    Script Date: 02/11/2013 15:43:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sAccessOldSourcing](
	[AccessOldSourcingID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[StyleTypeId] [int] NOT NULL,
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
 CONSTRAINT [PK_AccessOldSourcingID] PRIMARY KEY CLUSTERED 
(
	[AccessOldSourcingID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sAccessOldSourcing] ADD  CONSTRAINT [DF_sAccessOldSourcing_AccessOldSourcingID]  DEFAULT (newid()) FOR [AccessOldSourcingID]
GO

ALTER TABLE [dbo].[sAccessOldSourcing] ADD  CONSTRAINT [DF_sAccessOldSourcing_AccessRoleId]  DEFAULT ((0)) FOR [AccessRoleId]
GO

ALTER TABLE [dbo].[sAccessOldSourcing] ADD  CONSTRAINT [DF_sAccessOldSourcing_AccessView]  DEFAULT ((0)) FOR [AccessView]
GO

ALTER TABLE [dbo].[sAccessOldSourcing] ADD  CONSTRAINT [DF_sAccessOldSourcing_AccessCreate]  DEFAULT ((0)) FOR [AccessCreate]
GO

ALTER TABLE [dbo].[sAccessOldSourcing] ADD  CONSTRAINT [DF_sAccessOldSourcing_AccessModify]  DEFAULT ((0)) FOR [AccessModify]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05028', GetDate())
GO
