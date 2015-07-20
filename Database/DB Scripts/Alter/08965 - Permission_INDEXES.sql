/*** sPermissionWorkflow ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sPermissionWorkflow]') AND name = N'IX_sPermissionWorkflow_GroupID')
DROP INDEX [IX_sPermissionWorkflow_GroupID] ON [dbo].[sPermissionWorkflow] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_sPermissionWorkflow_GroupID] ON [dbo].[sPermissionWorkflow] 
(
	[GroupId] ASC
)
INCLUDE ( [PermissionRoleId],
[PermissionView],
[PermissionCreate],
[PermissionRemove],
[PermissionModify],
[PermissionDelete],
[PermissionPrint],
[PermissionFolderId]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sPermissionWorkflow]') AND name = N'IX_sPermissionWorkflow_PermissionProductTypeID')
DROP INDEX [IX_sPermissionWorkflow_PermissionProductTypeID] ON [dbo].[sPermissionWorkflow] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_sPermissionWorkflow_PermissionProductTypeID] ON [dbo].[sPermissionWorkflow] 
(
	[PermissionProductTypeId] ASC
)
INCLUDE ( [PermissionFolderId],
[GroupId],
[PermissionRoleId],
[PermissionView],
[PermissionCreate],
[PermissionRemove],
[PermissionModify],
[PermissionDelete],
[PermissionPrint]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sPermissionWorkflow]') AND name = N'IX_sPermissionWorkflow_PermissionFolderId')
DROP INDEX [IX_sPermissionWorkflow_PermissionFolderId] ON [dbo].[sPermissionWorkflow] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_sPermissionWorkflow_PermissionFolderId] ON [dbo].[sPermissionWorkflow] 
(
	[PermissionFolderId] ASC,
	[GroupId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO




/*** sPermissionFolder ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sPermissionFolder]') AND name = N'IX_sPermissionFolder_PermissionFolderTypeID')
DROP INDEX [IX_sPermissionFolder_PermissionFolderTypeID] ON [dbo].[sPermissionFolder] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_sPermissionFolder_PermissionFolderTypeID] ON [dbo].[sPermissionFolder] 
(
	[PermissionFolderTypeId] ASC
)
INCLUDE ( [PermissionFolderNotLocked]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/*** sPermissionProductType ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sPermissionProductType]') AND name = N'IX_sPermissionProductType_PermissionProductTypeMapId')
DROP INDEX [IX_sPermissionProductType_PermissionProductTypeMapId] ON [dbo].[sPermissionProductType] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_sPermissionProductType_PermissionProductTypeMapId] ON [dbo].[sPermissionProductType] 
(
	[PermissionProductTypeMapId] ASC
)
INCLUDE ( [PermissionProductTypeNotLocked]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[sPermissionProductType]') AND name = N'IX_sPermissionProductType_GroupID')
DROP INDEX [IX_sPermissionProductType_GroupID] ON [dbo].[sPermissionProductType] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_sPermissionProductType_GroupID] ON [dbo].[sPermissionProductType] 
(
	[GroupId] ASC,
	[PermissionFolderId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/*** Users ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND name = N'IX_Users_TeamID')
DROP INDEX [IX_Users_TeamID] ON [dbo].[Users] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_Users_TeamID] ON [dbo].[Users] 
(
	[TeamID] ASC
)
INCLUDE ( [FirstName],
[LastName],
[ReadOnly]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** uUserGroup ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[uUserGroup]') AND name = N'IX_uUserGroup_TeamID')
DROP INDEX [IX_uUserGroup_TeamID] ON [dbo].[uUserGroup] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_uUserGroup_TeamID] ON [dbo].[uUserGroup] 
(
	[TeamID] ASC
)
INCLUDE ( [GroupID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[uUserGroup]') AND name = N'IX_uUserGroup_GroupID')
DROP INDEX [IX_uUserGroup_GroupID] ON [dbo].[uUserGroup] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_uUserGroup_GroupID] ON [dbo].[uUserGroup] 
(
	[GroupID] ASC
)
INCLUDE ( [TeamID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO



/*** cDeskGroupFolderAccess ***/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[cDeskGroupFolderAccess]') AND name = N'IX_cDeskGroupFolderAccess_DeskFolderId')
DROP INDEX [IX_cDeskGroupFolderAccess_DeskFolderId] ON [dbo].[cDeskGroupFolderAccess] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_cDeskGroupFolderAccess_DeskFolderId] ON [dbo].[cDeskGroupFolderAccess] 
(
	[DeskFolderId] ASC,
	[GroupID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '08965', GetDate())
GO
