
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uUserProductAttribute]') AND type = N'U')
	DROP TABLE [dbo].uUserProductAttribute
GO

CREATE TABLE [dbo].[uUserProductAttribute]
(
[UserProductAttributeID] [uniqueidentifier] NOT NULL ROWGUIDCOL DEFAULT (newsequentialid()),
[UserProductAttributeName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserProductAttributeDescription] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DashFolderItemID] [uniqueidentifier] NULL DEFAULT (newid()),
[TeamID] [uniqueidentifier] NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL,
[MUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MDate] [datetime] NULL,
[Active] [int] NULL
)
GO
ALTER TABLE [dbo].[uUserProductAttribute] ADD PRIMARY KEY CLUSTERED  ([UserProductAttributeID])
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uUserProductAttributeDataFolder]') AND type = N'U')
	DROP TABLE [dbo].uUserProductAttributeDataFolder
GO


CREATE TABLE [dbo].[uUserProductAttributeDataFolder]
(
[UserProductAttributeDataFolderID] [uniqueidentifier] NOT NULL ROWGUIDCOL DEFAULT (newsequentialid()),
[UserProductAttributeDataFolderName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserProductAttributeDataFolderDesc] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserProductAttributeDataFolderOrder] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL DEFAULT (getdate()),
[MUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MDate] [datetime] NULL,
[Active] [int] NULL DEFAULT ((1))
)
GO
ALTER TABLE [dbo].[uUserProductAttributeDataFolder] ADD PRIMARY KEY CLUSTERED  ([UserProductAttributeDataFolderID])
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uUserProductAttributeDataRelation]') AND type = N'U')
	DROP TABLE [dbo].uUserProductAttributeDataRelation
GO

CREATE TABLE [dbo].[uUserProductAttributeDataRelation]
(
[UserProductAttributeDataRelationID] [uniqueidentifier] NOT NULL ROWGUIDCOL DEFAULT (newsequentialid()),
[UserProductAttributeDataFolderID] [uniqueidentifier] NULL,
[UserProductAttributeDataSourceID] [uniqueidentifier] NULL,
[UserProductAttributeID] [uniqueidentifier] NULL,
[UserProductAttributeDataRelationOrder] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL,
[MUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MDate] [datetime] NULL,
[Active] [int] NULL,
[Sort] [int] NULL
)
GO
ALTER TABLE [dbo].[uUserProductAttributeDataRelation] ADD PRIMARY KEY CLUSTERED  ([UserProductAttributeDataRelationID])
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uUserProductAttributeDataRelationItem]') AND type = N'U')
	DROP TABLE [dbo].uUserProductAttributeDataRelationItem
GO

CREATE TABLE [dbo].[uUserProductAttributeDataRelationItem]
(
[UserProductAttributeDataRelationItemID] [uniqueidentifier] NOT NULL ROWGUIDCOL DEFAULT (newsequentialid()),
[UserProductAttributeDataRelationID] [uniqueidentifier] NULL,
[UserProductAttributeDataRelationTablePkID] [uniqueidentifier] NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL DEFAULT (getdate()),
[MUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MDate] [datetime] NULL,
[Sort] [nvarchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [dbo].[uUserProductAttributeDataRelationItem] ADD PRIMARY KEY CLUSTERED  ([UserProductAttributeDataRelationItemID])
GO



IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[uUserProductAttributeDataSource]') AND type = N'U')
	DROP TABLE [dbo].uUserProductAttributeDataSource
GO

CREATE TABLE [dbo].[uUserProductAttributeDataSource]
(
[UserProductAttributeDataSourceID] [uniqueidentifier] NOT NULL ROWGUIDCOL DEFAULT (newsequentialid()),
[UserProductAttributeDataSourceName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserProductAttributeDataSourceDesc] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserProductAttributeTableViewName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserProductAttributeTablePkName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserProductAttributeTableFieldText] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserProductAttributeTableFieldValue] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserProductAttributeTableFieldOrderBy] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CDate] [datetime] NULL DEFAULT (getdate()),
[MUser] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MDate] [datetime] NULL,
[Active] [int] NULL
)
GO
ALTER TABLE [dbo].[uUserProductAttributeDataSource] ADD PRIMARY KEY CLUSTERED  ([UserProductAttributeDataSourceID])
GO



IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02022'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '4.1.0000', '02022', GetDate())

END	  
GO
