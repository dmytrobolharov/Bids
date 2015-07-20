/****** Object:  ForeignKey [FK_sPermissionFolder_sPermissionFolderType]    Script Date: 05/16/2014 17:50:20 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sPermissionFolder_sPermissionFolderType]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPermissionFolder]'))
ALTER TABLE [dbo].[sPermissionFolder] DROP CONSTRAINT [FK_sPermissionFolder_sPermissionFolderType]
GO
/****** Object:  ForeignKey [FK_sPermissionProductType_sPermissionFolder]    Script Date: 05/16/2014 17:50:20 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sPermissionProductType_sPermissionFolder]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPermissionProductType]'))
ALTER TABLE [dbo].[sPermissionProductType] DROP CONSTRAINT [FK_sPermissionProductType_sPermissionFolder]
GO
/****** Object:  ForeignKey [FK_sPermissionProductType_sPermissionProductTypeMap1]    Script Date: 05/16/2014 17:50:20 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sPermissionProductType_sPermissionProductTypeMap1]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPermissionProductType]'))
ALTER TABLE [dbo].[sPermissionProductType] DROP CONSTRAINT [FK_sPermissionProductType_sPermissionProductTypeMap1]
GO
/****** Object:  ForeignKey [FK_sPermissionWorkflow_sPermissionProductTypeMap]    Script Date: 05/16/2014 17:50:21 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sPermissionWorkflow_sPermissionProductTypeMap]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPermissionWorkflow]'))
ALTER TABLE [dbo].[sPermissionWorkflow] DROP CONSTRAINT [FK_sPermissionWorkflow_sPermissionProductTypeMap]
GO
/****** Object:  ForeignKey [FK_sPermissionWorkflow_sPermissionRole]    Script Date: 05/16/2014 17:50:21 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sPermissionWorkflow_sPermissionRole]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPermissionWorkflow]'))
ALTER TABLE [dbo].[sPermissionWorkflow] DROP CONSTRAINT [FK_sPermissionWorkflow_sPermissionRole]
GO
/****** Object:  Table [dbo].[sPermissionProductType]    Script Date: 05/16/2014 17:50:20 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sPermissionProductType_sPermissionFolder]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPermissionProductType]'))
ALTER TABLE [dbo].[sPermissionProductType] DROP CONSTRAINT [FK_sPermissionProductType_sPermissionFolder]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sPermissionProductType_sPermissionProductTypeMap1]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPermissionProductType]'))
ALTER TABLE [dbo].[sPermissionProductType] DROP CONSTRAINT [FK_sPermissionProductType_sPermissionProductTypeMap1]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPermissionProductType_PermissionProductTypeId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPermissionProductType] DROP CONSTRAINT [DF_sPermissionProductType_PermissionProductTypeId]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPermissionProductType_PermissionProductTypeLocked]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPermissionProductType] DROP CONSTRAINT [DF_sPermissionProductType_PermissionProductTypeLocked]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPermissionProductType_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPermissionProductType] DROP CONSTRAINT [DF_sPermissionProductType_Active]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPermissionProductType]') AND type in (N'U'))
DROP TABLE [dbo].[sPermissionProductType]
GO
/****** Object:  Table [dbo].[sPermissionFolder]    Script Date: 05/16/2014 17:50:20 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sPermissionFolder_sPermissionFolderType]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPermissionFolder]'))
ALTER TABLE [dbo].[sPermissionFolder] DROP CONSTRAINT [FK_sPermissionFolder_sPermissionFolderType]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPermissionFolder_PermissionFolderId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPermissionFolder] DROP CONSTRAINT [DF_sPermissionFolder_PermissionFolderId]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPermissionFolder_PermissionFolderLocked]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPermissionFolder] DROP CONSTRAINT [DF_sPermissionFolder_PermissionFolderLocked]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPermissionFolder]') AND type in (N'U'))
DROP TABLE [dbo].[sPermissionFolder]
GO
/****** Object:  Table [dbo].[sPermissionWorkflow]    Script Date: 05/16/2014 17:50:21 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sPermissionWorkflow_sPermissionProductTypeMap]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPermissionWorkflow]'))
ALTER TABLE [dbo].[sPermissionWorkflow] DROP CONSTRAINT [FK_sPermissionWorkflow_sPermissionProductTypeMap]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sPermissionWorkflow_sPermissionRole]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPermissionWorkflow]'))
ALTER TABLE [dbo].[sPermissionWorkflow] DROP CONSTRAINT [FK_sPermissionWorkflow_sPermissionRole]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPermissionWorkflow_PermissionWorkflowId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPermissionWorkflow] DROP CONSTRAINT [DF_sPermissionWorkflow_PermissionWorkflowId]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPermissionWorkflow_PermissionRoleId]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPermissionWorkflow] DROP CONSTRAINT [DF_sPermissionWorkflow_PermissionRoleId]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPermissionWorkflow_PermissionView]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPermissionWorkflow] DROP CONSTRAINT [DF_sPermissionWorkflow_PermissionView]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPermissionWorkflow_PermissionCreate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPermissionWorkflow] DROP CONSTRAINT [DF_sPermissionWorkflow_PermissionCreate]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPermissionWorkflow_PermissionRemove]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPermissionWorkflow] DROP CONSTRAINT [DF_sPermissionWorkflow_PermissionRemove]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPermissionWorkflow_PermissionModify]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPermissionWorkflow] DROP CONSTRAINT [DF_sPermissionWorkflow_PermissionModify]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPermissionWorkflow_PermissionDelete]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPermissionWorkflow] DROP CONSTRAINT [DF_sPermissionWorkflow_PermissionDelete]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPermissionWorkflow_PermissionPrint]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPermissionWorkflow] DROP CONSTRAINT [DF_sPermissionWorkflow_PermissionPrint]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPermissionWorkflow]') AND type in (N'U'))
DROP TABLE [dbo].[sPermissionWorkflow]
GO
/****** Object:  Table [dbo].[sPermissionFolderType]    Script Date: 05/16/2014 17:50:20 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPermissionFolderType_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPermissionFolderType] DROP CONSTRAINT [DF_sPermissionFolderType_Active]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPermissionFolderType]') AND type in (N'U'))
DROP TABLE [dbo].[sPermissionFolderType]
GO
/****** Object:  Table [dbo].[sPermissionProductTypeMap]    Script Date: 05/16/2014 17:50:20 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPermissionProductTypeMap]') AND type in (N'U'))
DROP TABLE [dbo].[sPermissionProductTypeMap]
GO
/****** Object:  Table [dbo].[sPermissionRole]    Script Date: 05/16/2014 17:50:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPermissionRole]') AND type in (N'U'))
DROP TABLE [dbo].[sPermissionRole]
GO
/****** Object:  Table [dbo].[sPermissionRole]    Script Date: 05/16/2014 17:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPermissionRole]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sPermissionRole](
	[PermissionRoleId] [int] NOT NULL,
	[PermissionRoleCode] [varchar](10) NULL,
	[PermissionRoleName] [nvarchar](100) NULL,
 CONSTRAINT [PK_sPermissionRole] PRIMARY KEY CLUSTERED 
(
	[PermissionRoleId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sPermissionProductTypeMap]    Script Date: 05/16/2014 17:50:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPermissionProductTypeMap]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sPermissionProductTypeMap](
	[PermissionProductTypeMapId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[PermissionFolderTypeId] [int] NULL,
	[GuidProductTypeId] [uniqueidentifier] NULL,
	[IntProductTypeId] [int] NULL,
	[StrProductTypeId] [nvarchar](100) NULL,
 CONSTRAINT [PK_sPermissionProductTypeMap] PRIMARY KEY CLUSTERED 
(
	[PermissionProductTypeMapId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[sPermissionFolderType]    Script Date: 05/16/2014 17:50:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPermissionFolderType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sPermissionFolderType](
	[PermissionFolderTypeId] [int] NOT NULL,
	[PermissionFolderTypeName] [nvarchar](50) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL CONSTRAINT [DF_sPermissionFolderType_Active]  DEFAULT ((1)),
 CONSTRAINT [PK_sPermissionFolderType] PRIMARY KEY CLUSTERED 
(
	[PermissionFolderTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[sPermissionWorkflow]    Script Date: 05/16/2014 17:50:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPermissionWorkflow]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sPermissionWorkflow](
	[PermissionWorkflowId] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_sPermissionWorkflow_PermissionWorkflowId]  DEFAULT (newsequentialid()),
	[PermissionFolderId] [uniqueidentifier] NOT NULL,
	[PermissionProductTypeId] [uniqueidentifier] NOT NULL,
	[PermissionProductTypeMapId] [int] NOT NULL,
	[GroupId] [uniqueidentifier] NOT NULL,
	[WorkflowId] [uniqueidentifier] NOT NULL,
	[PermissionRoleId] [int] NOT NULL CONSTRAINT [DF_sPermissionWorkflow_PermissionRoleId]  DEFAULT ((0)),
	[PermissionView] [int] NOT NULL CONSTRAINT [DF_sPermissionWorkflow_PermissionView]  DEFAULT ((0)),
	[PermissionCreate] [int] NOT NULL CONSTRAINT [DF_sPermissionWorkflow_PermissionCreate]  DEFAULT ((0)),
	[PermissionRemove] [int] NOT NULL CONSTRAINT [DF_sPermissionWorkflow_PermissionRemove]  DEFAULT ((0)),
	[PermissionModify] [int] NOT NULL CONSTRAINT [DF_sPermissionWorkflow_PermissionModify]  DEFAULT ((0)),
	[PermissionDelete] [int] NOT NULL CONSTRAINT [DF_sPermissionWorkflow_PermissionDelete]  DEFAULT ((0)),
	[PermissionPrint] [int] NOT NULL CONSTRAINT [DF_sPermissionWorkflow_PermissionPrint]  DEFAULT ((0)),
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[PermissionWorkflowName] [nvarchar](256) NULL,
 CONSTRAINT [PK_sPermissionWorkflow] PRIMARY KEY CLUSTERED 
(
	[PermissionWorkflowId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[sPermissionFolder]    Script Date: 05/16/2014 17:50:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPermissionFolder]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sPermissionFolder](
	[PermissionFolderId] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_sPermissionFolder_PermissionFolderId]  DEFAULT (newsequentialid()),
	[PermissionFolderTypeId] [int] NOT NULL,
	[GroupId] [uniqueidentifier] NOT NULL,
	[PermissionFolderNotLocked] [int] NULL CONSTRAINT [DF_sPermissionFolder_PermissionFolderLocked]  DEFAULT ((1)),
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_sPermissionFolder] PRIMARY KEY CLUSTERED 
(
	[PermissionFolderId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[sPermissionProductType]    Script Date: 05/16/2014 17:50:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPermissionProductType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sPermissionProductType](
	[PermissionProductTypeId] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_sPermissionProductType_PermissionProductTypeId]  DEFAULT (newsequentialid()),
	[PermissionFolderId] [uniqueidentifier] NULL,
	[PermissionProductTypeMapId] [int] NULL,
	[PermissionProductTypeNotLocked] [int] NULL CONSTRAINT [DF_sPermissionProductType_PermissionProductTypeLocked]  DEFAULT ((1)),
	[GroupId] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL CONSTRAINT [DF_sPermissionProductType_Active]  DEFAULT ((1)),
	[PermissionProductTypeName] [nvarchar](256) NULL,
 CONSTRAINT [PK_sPermissionProductType] PRIMARY KEY CLUSTERED 
(
	[PermissionProductTypeId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  ForeignKey [FK_sPermissionFolder_sPermissionFolderType]    Script Date: 05/16/2014 17:50:20 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sPermissionFolder_sPermissionFolderType]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPermissionFolder]'))
ALTER TABLE [dbo].[sPermissionFolder]  WITH CHECK ADD  CONSTRAINT [FK_sPermissionFolder_sPermissionFolderType] FOREIGN KEY([PermissionFolderTypeId])
REFERENCES [dbo].[sPermissionFolderType] ([PermissionFolderTypeId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sPermissionFolder_sPermissionFolderType]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPermissionFolder]'))
ALTER TABLE [dbo].[sPermissionFolder] CHECK CONSTRAINT [FK_sPermissionFolder_sPermissionFolderType]
GO
/****** Object:  ForeignKey [FK_sPermissionProductType_sPermissionFolder]    Script Date: 05/16/2014 17:50:20 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sPermissionProductType_sPermissionFolder]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPermissionProductType]'))
ALTER TABLE [dbo].[sPermissionProductType]  WITH CHECK ADD  CONSTRAINT [FK_sPermissionProductType_sPermissionFolder] FOREIGN KEY([PermissionFolderId])
REFERENCES [dbo].[sPermissionFolder] ([PermissionFolderId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sPermissionProductType_sPermissionFolder]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPermissionProductType]'))
ALTER TABLE [dbo].[sPermissionProductType] CHECK CONSTRAINT [FK_sPermissionProductType_sPermissionFolder]
GO
/****** Object:  ForeignKey [FK_sPermissionProductType_sPermissionProductTypeMap1]    Script Date: 05/16/2014 17:50:20 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sPermissionProductType_sPermissionProductTypeMap1]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPermissionProductType]'))
ALTER TABLE [dbo].[sPermissionProductType]  WITH CHECK ADD  CONSTRAINT [FK_sPermissionProductType_sPermissionProductTypeMap1] FOREIGN KEY([PermissionProductTypeMapId])
REFERENCES [dbo].[sPermissionProductTypeMap] ([PermissionProductTypeMapId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sPermissionProductType_sPermissionProductTypeMap1]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPermissionProductType]'))
ALTER TABLE [dbo].[sPermissionProductType] CHECK CONSTRAINT [FK_sPermissionProductType_sPermissionProductTypeMap1]
GO
/****** Object:  ForeignKey [FK_sPermissionWorkflow_sPermissionProductTypeMap]    Script Date: 05/16/2014 17:50:21 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sPermissionWorkflow_sPermissionProductTypeMap]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPermissionWorkflow]'))
ALTER TABLE [dbo].[sPermissionWorkflow]  WITH CHECK ADD  CONSTRAINT [FK_sPermissionWorkflow_sPermissionProductTypeMap] FOREIGN KEY([PermissionProductTypeMapId])
REFERENCES [dbo].[sPermissionProductTypeMap] ([PermissionProductTypeMapId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sPermissionWorkflow_sPermissionProductTypeMap]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPermissionWorkflow]'))
ALTER TABLE [dbo].[sPermissionWorkflow] CHECK CONSTRAINT [FK_sPermissionWorkflow_sPermissionProductTypeMap]
GO
/****** Object:  ForeignKey [FK_sPermissionWorkflow_sPermissionRole]    Script Date: 05/16/2014 17:50:21 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sPermissionWorkflow_sPermissionRole]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPermissionWorkflow]'))
ALTER TABLE [dbo].[sPermissionWorkflow]  WITH CHECK ADD  CONSTRAINT [FK_sPermissionWorkflow_sPermissionRole] FOREIGN KEY([PermissionRoleId])
REFERENCES [dbo].[sPermissionRole] ([PermissionRoleId])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sPermissionWorkflow_sPermissionRole]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPermissionWorkflow]'))
ALTER TABLE [dbo].[sPermissionWorkflow] CHECK CONSTRAINT [FK_sPermissionWorkflow_sPermissionRole]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07638', GetDate())
GO