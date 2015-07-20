IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupPlanningFolder_AccessPlanningID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupPlanningFolder] DROP CONSTRAINT [DF_sAccessGroupPlanningFolder_AccessPlanningID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupPlanningFolder_AccessRoleId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupPlanningFolder] DROP CONSTRAINT [DF_sAccessGroupPlanningFolder_AccessRoleId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupPlanningFolder_AccessView]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupPlanningFolder] DROP CONSTRAINT [DF_sAccessGroupPlanningFolder_AccessView]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupPlanningFolder_AccessCreate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupPlanningFolder] DROP CONSTRAINT [DF_sAccessGroupPlanningFolder_AccessCreate]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupPlanningFolder_AccessModify]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupPlanningFolder] DROP CONSTRAINT [DF_sAccessGroupPlanningFolder_AccessModify]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupPlanningFolder_AccessDelete]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupPlanningFolder] DROP CONSTRAINT [DF_sAccessGroupPlanningFolder_AccessDelete]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupPlanningFolder_AccessPrint]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupPlanningFolder] DROP CONSTRAINT [DF_sAccessGroupPlanningFolder_AccessPrint]
END

GO

/****** Object:  Table [dbo].[sAccessGroupPlanningFolder]    Script Date: 08/19/2013 11:55:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroupPlanningFolder]') AND type in (N'U'))
DROP TABLE [dbo].[sAccessGroupPlanningFolder]
GO

/****** Object:  Table [dbo].[sAccessGroupPlanningFolder]    Script Date: 08/19/2013 11:55:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sAccessGroupPlanningFolder](
	[AccessPlanningID] [uniqueidentifier] NOT NULL,
	[PlanningTypeId] [int] NOT NULL,
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
 CONSTRAINT [PK_sAccessGroupPlanningFolder] PRIMARY KEY CLUSTERED 
(
	[AccessPlanningID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sAccessGroupPlanningFolder] ADD  CONSTRAINT [DF_sAccessGroupPlanningFolder_AccessPlanningID]  DEFAULT (newid()) FOR [AccessPlanningID]
GO

ALTER TABLE [dbo].[sAccessGroupPlanningFolder] ADD  CONSTRAINT [DF_sAccessGroupPlanningFolder_AccessRoleId]  DEFAULT ((0)) FOR [AccessRoleId]
GO

ALTER TABLE [dbo].[sAccessGroupPlanningFolder] ADD  CONSTRAINT [DF_sAccessGroupPlanningFolder_AccessView]  DEFAULT ((0)) FOR [AccessView]
GO

ALTER TABLE [dbo].[sAccessGroupPlanningFolder] ADD  CONSTRAINT [DF_sAccessGroupPlanningFolder_AccessCreate]  DEFAULT ((0)) FOR [AccessCreate]
GO

ALTER TABLE [dbo].[sAccessGroupPlanningFolder] ADD  CONSTRAINT [DF_sAccessGroupPlanningFolder_AccessModify]  DEFAULT ((0)) FOR [AccessModify]
GO

ALTER TABLE [dbo].[sAccessGroupPlanningFolder] ADD  CONSTRAINT [DF_sAccessGroupPlanningFolder_AccessDelete]  DEFAULT ((0)) FOR [AccessDelete]
GO

ALTER TABLE [dbo].[sAccessGroupPlanningFolder] ADD  CONSTRAINT [DF_sAccessGroupPlanningFolder_AccessPrint]  DEFAULT ((0)) FOR [AccessPrint]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06183', GetDate())
GO
