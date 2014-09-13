IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupPlanningFolderItem_AccessPlanningItemID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupPlanningFolderItem] DROP CONSTRAINT [DF_sAccessGroupPlanningFolderItem_AccessPlanningItemID]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupPlanningFolderItem_AccessRoleId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupPlanningFolderItem] DROP CONSTRAINT [DF_sAccessGroupPlanningFolderItem_AccessRoleId]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupPlanningFolderItem_AccessView]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupPlanningFolderItem] DROP CONSTRAINT [DF_sAccessGroupPlanningFolderItem_AccessView]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupPlanningFolderItem_AccessCreate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupPlanningFolderItem] DROP CONSTRAINT [DF_sAccessGroupPlanningFolderItem_AccessCreate]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupPlanningFolderItem_AccessModify]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupPlanningFolderItem] DROP CONSTRAINT [DF_sAccessGroupPlanningFolderItem_AccessModify]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupPlanningFolderItem_AccessDelete]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupPlanningFolderItem] DROP CONSTRAINT [DF_sAccessGroupPlanningFolderItem_AccessDelete]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupPlanningFolderItem_AccessPrint]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupPlanningFolderItem] DROP CONSTRAINT [DF_sAccessGroupPlanningFolderItem_AccessPrint]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupPlanningFolderItem_CDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupPlanningFolderItem] DROP CONSTRAINT [DF_sAccessGroupPlanningFolderItem_CDate]
END

GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sAccessGroupPlanningFolderItem_MDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sAccessGroupPlanningFolderItem] DROP CONSTRAINT [DF_sAccessGroupPlanningFolderItem_MDate]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroupPlanningFolderItem]') AND type in (N'U'))
DROP TABLE [dbo].[sAccessGroupPlanningFolderItem]
GO

CREATE TABLE [dbo].[sAccessGroupPlanningFolderItem](
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
	[GroupID] [uniqueidentifier] NOT NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_sAccessGroupPlanningFolderItem] PRIMARY KEY CLUSTERED 
(
	[AccessPlanningItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sAccessGroupPlanningFolderItem] ADD  CONSTRAINT [DF_sAccessGroupPlanningFolderItem_AccessPlanningItemID]  DEFAULT (newid()) FOR [AccessPlanningItemID]
GO

ALTER TABLE [dbo].[sAccessGroupPlanningFolderItem] ADD  CONSTRAINT [DF_sAccessGroupPlanningFolderItem_AccessRoleId]  DEFAULT ((0)) FOR [AccessRoleId]
GO

ALTER TABLE [dbo].[sAccessGroupPlanningFolderItem] ADD  CONSTRAINT [DF_sAccessGroupPlanningFolderItem_AccessView]  DEFAULT ((0)) FOR [AccessView]
GO

ALTER TABLE [dbo].[sAccessGroupPlanningFolderItem] ADD  CONSTRAINT [DF_sAccessGroupPlanningFolderItem_AccessCreate]  DEFAULT ((0)) FOR [AccessCreate]
GO

ALTER TABLE [dbo].[sAccessGroupPlanningFolderItem] ADD  CONSTRAINT [DF_sAccessGroupPlanningFolderItem_AccessModify]  DEFAULT ((0)) FOR [AccessModify]
GO

ALTER TABLE [dbo].[sAccessGroupPlanningFolderItem] ADD  CONSTRAINT [DF_sAccessGroupPlanningFolderItem_AccessDelete]  DEFAULT ((0)) FOR [AccessDelete]
GO

ALTER TABLE [dbo].[sAccessGroupPlanningFolderItem] ADD  CONSTRAINT [DF_sAccessGroupPlanningFolderItem_AccessPrint]  DEFAULT ((0)) FOR [AccessPrint]
GO

ALTER TABLE [dbo].[sAccessGroupPlanningFolderItem] ADD  CONSTRAINT [DF_sAccessGroupPlanningFolderItem_CDate]  DEFAULT (getdate()) FOR [CDate]
GO

ALTER TABLE [dbo].[sAccessGroupPlanningFolderItem] ADD  CONSTRAINT [DF_sAccessGroupPlanningFolderItem_MDate]  DEFAULT (getdate()) FOR [MDate]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07465', GetDate())
GO