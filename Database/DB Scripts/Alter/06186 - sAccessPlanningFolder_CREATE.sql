IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessPlanningFolder_AccessPlanningID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessPlanningFolder] DROP CONSTRAINT [DF_sAccessPlanningFolder_AccessPlanningID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessPlanningFolder_AccessRoleId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessPlanningFolder] DROP CONSTRAINT [DF_sAccessPlanningFolder_AccessRoleId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessPlanningFolder_AccessView]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessPlanningFolder] DROP CONSTRAINT [DF_sAccessPlanningFolder_AccessView]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessPlanningFolder_AccessCreate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessPlanningFolder] DROP CONSTRAINT [DF_sAccessPlanningFolder_AccessCreate]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessPlanningFolder_AccessModify]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessPlanningFolder] DROP CONSTRAINT [DF_sAccessPlanningFolder_AccessModify]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessPlanningFolder_AccessDelete]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessPlanningFolder] DROP CONSTRAINT [DF_sAccessPlanningFolder_AccessDelete]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessPlanningFolder_AccessPrint]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessPlanningFolder] DROP CONSTRAINT [DF_sAccessPlanningFolder_AccessPrint]
END

GO

/****** Object:  Table [dbo].[sAccessPlanningFolder]    Script Date: 08/19/2013 12:17:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessPlanningFolder]') AND type in (N'U'))
DROP TABLE [dbo].[sAccessPlanningFolder]
GO

/****** Object:  Table [dbo].[sAccessPlanningFolder]    Script Date: 08/19/2013 12:17:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sAccessPlanningFolder](
	[AccessPlanningID] [uniqueidentifier] NOT NULL,
	[PlanningTypeId] [int] NULL,
	[AccessRoleId] [int] NULL,
	[AccessView] [int] NULL,
	[AccessCreate] [int] NULL,
	[AccessModify] [int] NULL,
	[AccessDelete] [int] NULL,
	[AccessPrint] [int] NULL,
	[TeamId] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_sAccessPlanningFolder] PRIMARY KEY CLUSTERED 
(
	[AccessPlanningID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sAccessPlanningFolder] ADD  CONSTRAINT [DF_sAccessPlanningFolder_AccessPlanningID]  DEFAULT (newid()) FOR [AccessPlanningID]
GO

ALTER TABLE [dbo].[sAccessPlanningFolder] ADD  CONSTRAINT [DF_sAccessPlanningFolder_AccessRoleId]  DEFAULT ((0)) FOR [AccessRoleId]
GO

ALTER TABLE [dbo].[sAccessPlanningFolder] ADD  CONSTRAINT [DF_sAccessPlanningFolder_AccessView]  DEFAULT ((0)) FOR [AccessView]
GO

ALTER TABLE [dbo].[sAccessPlanningFolder] ADD  CONSTRAINT [DF_sAccessPlanningFolder_AccessCreate]  DEFAULT ((0)) FOR [AccessCreate]
GO

ALTER TABLE [dbo].[sAccessPlanningFolder] ADD  CONSTRAINT [DF_sAccessPlanningFolder_AccessModify]  DEFAULT ((0)) FOR [AccessModify]
GO

ALTER TABLE [dbo].[sAccessPlanningFolder] ADD  CONSTRAINT [DF_sAccessPlanningFolder_AccessDelete]  DEFAULT ((0)) FOR [AccessDelete]
GO

ALTER TABLE [dbo].[sAccessPlanningFolder] ADD  CONSTRAINT [DF_sAccessPlanningFolder_AccessPrint]  DEFAULT ((0)) FOR [AccessPrint]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06186', GetDate())
GO
