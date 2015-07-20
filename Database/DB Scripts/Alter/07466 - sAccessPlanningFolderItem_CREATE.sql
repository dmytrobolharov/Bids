IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessPlanningFolderItem_AccessPlanningItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessPlanningFolderItem] DROP CONSTRAINT [DF_sAccessPlanningFolderItem_AccessPlanningItemID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessPlanningFolderItem_AccessRoleId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessPlanningFolderItem] DROP CONSTRAINT [DF_sAccessPlanningFolderItem_AccessRoleId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessPlanningFolderItem_AccessView]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessPlanningFolderItem] DROP CONSTRAINT [DF_sAccessPlanningFolderItem_AccessView]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessPlanningFolderItem_AccessCreate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessPlanningFolderItem] DROP CONSTRAINT [DF_sAccessPlanningFolderItem_AccessCreate]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessPlanningFolderItem_AccessModify]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessPlanningFolderItem] DROP CONSTRAINT [DF_sAccessPlanningFolderItem_AccessModify]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessPlanningFolderItem_AccessDelete]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessPlanningFolderItem] DROP CONSTRAINT [DF_sAccessPlanningFolderItem_AccessDelete]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessPlanningFolderItem_AccessPrint]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessPlanningFolderItem] DROP CONSTRAINT [DF_sAccessPlanningFolderItem_AccessPrint]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessPlanningFolderItem_CDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessPlanningFolderItem] DROP CONSTRAINT [DF_sAccessPlanningFolderItem_CDate]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessPlanningFolderItem_MDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessPlanningFolderItem] DROP CONSTRAINT [DF_sAccessPlanningFolderItem_MDate]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessPlanningFolderItem]') AND type in (N'U'))
DROP TABLE [dbo].[sAccessPlanningFolderItem]
GO

CREATE TABLE [dbo].[sAccessPlanningFolderItem](
	[AccessPlanningItemID] [uniqueidentifier] NOT NULL,
	[AccessPlanningID] [uniqueidentifier] NOT NULL,
	[PlanningTypeID] [uniqueidentifier] NOT NULL,
	[PlanningItemID] [uniqueidentifier] NOT NULL,
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
	[MDate] [datetime] NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sAccessPlanningFolderItem] ADD  CONSTRAINT [DF_sAccessPlanningFolderItem_AccessPlanningItemID]  DEFAULT (newid()) FOR [AccessPlanningItemID]
GO

ALTER TABLE [dbo].[sAccessPlanningFolderItem] ADD  CONSTRAINT [DF_sAccessPlanningFolderItem_AccessRoleId]  DEFAULT ((0)) FOR [AccessRoleId]
GO

ALTER TABLE [dbo].[sAccessPlanningFolderItem] ADD  CONSTRAINT [DF_sAccessPlanningFolderItem_AccessView]  DEFAULT ((0)) FOR [AccessView]
GO

ALTER TABLE [dbo].[sAccessPlanningFolderItem] ADD  CONSTRAINT [DF_sAccessPlanningFolderItem_AccessCreate]  DEFAULT ((0)) FOR [AccessCreate]
GO

ALTER TABLE [dbo].[sAccessPlanningFolderItem] ADD  CONSTRAINT [DF_sAccessPlanningFolderItem_AccessModify]  DEFAULT ((0)) FOR [AccessModify]
GO

ALTER TABLE [dbo].[sAccessPlanningFolderItem] ADD  CONSTRAINT [DF_sAccessPlanningFolderItem_AccessDelete]  DEFAULT ((0)) FOR [AccessDelete]
GO

ALTER TABLE [dbo].[sAccessPlanningFolderItem] ADD  CONSTRAINT [DF_sAccessPlanningFolderItem_AccessPrint]  DEFAULT ((0)) FOR [AccessPrint]
GO

ALTER TABLE [dbo].[sAccessPlanningFolderItem] ADD  CONSTRAINT [DF_sAccessPlanningFolderItem_CDate]  DEFAULT (getdate()) FOR [CDate]
GO

ALTER TABLE [dbo].[sAccessPlanningFolderItem] ADD  CONSTRAINT [DF_sAccessPlanningFolderItem_MDate]  DEFAULT (getdate()) FOR [MDate]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07466', GetDate())
GO