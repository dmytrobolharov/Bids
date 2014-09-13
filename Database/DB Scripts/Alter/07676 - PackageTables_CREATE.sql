/****** Object:  ForeignKey [FK_sPackageDatabaseObject_sPackageDatabaseObjectType]    Script Date: 05/19/2014 14:12:40 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sPackageDatabaseObject_sPackageDatabaseObjectType]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPackageDatabaseObject]'))
ALTER TABLE [dbo].[sPackageDatabaseObject] DROP CONSTRAINT [FK_sPackageDatabaseObject_sPackageDatabaseObjectType]
GO
/****** Object:  Check [CK_sPackageRelationships_RelationshipType]    Script Date: 05/19/2014 14:12:41 ******/
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_sPackageRelationships_RelationshipType]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPackageRelationship]'))
BEGIN
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_sPackageRelationships_RelationshipType]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPackageRelationship]'))
ALTER TABLE [dbo].[sPackageRelationship] DROP CONSTRAINT [CK_sPackageRelationships_RelationshipType]

END
GO
/****** Object:  Table [dbo].[sPackageDatabaseObject]    Script Date: 05/19/2014 14:12:40 ******/
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sPackageDatabaseObject_sPackageDatabaseObjectType]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPackageDatabaseObject]'))
ALTER TABLE [dbo].[sPackageDatabaseObject] DROP CONSTRAINT [FK_sPackageDatabaseObject_sPackageDatabaseObjectType]
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPackageDatabaseObject_DatabaseObjectID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPackageDatabaseObject] DROP CONSTRAINT [DF_sPackageDatabaseObject_DatabaseObjectID]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackageDatabaseObject]') AND type in (N'U'))
DROP TABLE [dbo].[sPackageDatabaseObject]
GO
/****** Object:  Table [dbo].[sPackageDatabaseObjectType]    Script Date: 05/19/2014 14:12:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackageDatabaseObjectType]') AND type in (N'U'))
DROP TABLE [dbo].[sPackageDatabaseObjectType]
GO
/****** Object:  Table [dbo].[sPackageLog]    Script Date: 05/19/2014 14:12:41 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPackageLog_PackageLogID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPackageLog] DROP CONSTRAINT [DF_sPackageLog_PackageLogID]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPackageLog_PackageLogDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPackageLog] DROP CONSTRAINT [DF_sPackageLog_PackageLogDate]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackageLog]') AND type in (N'U'))
DROP TABLE [dbo].[sPackageLog]
GO
/****** Object:  Table [dbo].[sPackageRelationship]    Script Date: 05/19/2014 14:12:41 ******/
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_sPackageRelationships_RelationshipType]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPackageRelationship]'))
ALTER TABLE [dbo].[sPackageRelationship] DROP CONSTRAINT [CK_sPackageRelationships_RelationshipType]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackageRelationship]') AND type in (N'U'))
DROP TABLE [dbo].[sPackageRelationship]
GO
/****** Object:  Table [dbo].[sPackageRouting]    Script Date: 05/19/2014 14:12:41 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPackageRouting_RouteOrder]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPackageRouting] DROP CONSTRAINT [DF_sPackageRouting_RouteOrder]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackageRouting]') AND type in (N'U'))
DROP TABLE [dbo].[sPackageRouting]
GO
/****** Object:  Table [dbo].[sPackageRoutingIgnores]    Script Date: 05/19/2014 14:12:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackageRoutingIgnores]') AND type in (N'U'))
DROP TABLE [dbo].[sPackageRoutingIgnores]
GO
/****** Object:  Table [dbo].[sPackageSchema]    Script Date: 05/19/2014 14:12:41 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPackageSchema_PackageSchemaID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPackageSchema] DROP CONSTRAINT [DF_sPackageSchema_PackageSchemaID]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__sPackageS__Schem__66F85F9E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPackageSchema] DROP CONSTRAINT [DF__sPackageS__Schem__66F85F9E]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackageSchema]') AND type in (N'U'))
DROP TABLE [dbo].[sPackageSchema]
GO
/****** Object:  Table [dbo].[sPackageType]    Script Date: 05/19/2014 14:12:42 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPackageType_PackageTypeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPackageType] DROP CONSTRAINT [DF_sPackageType_PackageTypeID]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPackageType_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPackageType] DROP CONSTRAINT [DF_sPackageType_Active]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPackageType_CDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPackageType] DROP CONSTRAINT [DF_sPackageType_CDate]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackageType]') AND type in (N'U'))
DROP TABLE [dbo].[sPackageType]
GO
/****** Object:  Table [dbo].[sPackageVendor]    Script Date: 05/19/2014 14:12:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackageVendor]') AND type in (N'U'))
DROP TABLE [dbo].[sPackageVendor]
GO
/****** Object:  Table [dbo].[sPackage]    Script Date: 05/19/2014 14:12:40 ******/
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPackage_PackageVendorID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPackage] DROP CONSTRAINT [DF_sPackage_PackageVendorID]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPackage_PackageTypeID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPackage] DROP CONSTRAINT [DF_sPackage_PackageTypeID]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPackage_PackageInstallDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPackage] DROP CONSTRAINT [DF_sPackage_PackageInstallDate]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPackage_PackageGUID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPackage] DROP CONSTRAINT [DF_sPackage_PackageGUID]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPackage_PackageVersion]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPackage] DROP CONSTRAINT [DF_sPackage_PackageVersion]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPackage_PackagePLMVersion]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPackage] DROP CONSTRAINT [DF_sPackage_PackagePLMVersion]
END
GO
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__sPackage__Packag__0D5312B0]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[sPackage] DROP CONSTRAINT [DF__sPackage__Packag__0D5312B0]
END
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackage]') AND type in (N'U'))
DROP TABLE [dbo].[sPackage]
GO
/****** Object:  Table [dbo].[sPackage]    Script Date: 05/19/2014 14:12:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackage]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sPackage](
	[PackageID] [nvarchar](8) NOT NULL,
	[PackageVendorID] [nvarchar](8) NOT NULL CONSTRAINT [DF_sPackage_PackageVendorID]  DEFAULT (N'00000000'),
	[PackageName] [nvarchar](255) NOT NULL,
	[PackageDescription] [nvarchar](max) NULL,
	[PackageTypeID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_sPackage_PackageTypeID]  DEFAULT (N'66666666-0000-0000-0000-000000000001'),
	[PackageInstallDate] [datetime] NOT NULL CONSTRAINT [DF_sPackage_PackageInstallDate]  DEFAULT (getdate()),
	[PackageGUID] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_sPackage_PackageGUID]  DEFAULT (newid()),
	[PackageVersion] [nvarchar](10) NOT NULL CONSTRAINT [DF_sPackage_PackageVersion]  DEFAULT (N'0.1.0'),
	[PackagePLMVersion] [nvarchar](20) NOT NULL CONSTRAINT [DF_sPackage_PackagePLMVersion]  DEFAULT (N'5.0.x'),
	[PackageAppDomain] [nvarchar](50) NULL DEFAULT ('plmon'),
 CONSTRAINT [PK_sPackage] PRIMARY KEY CLUSTERED 
(
	[PackageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[sPackageVendor]    Script Date: 05/19/2014 14:12:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackageVendor]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sPackageVendor](
	[PackageVendorID] [nvarchar](8) NULL,
	[PackageVendorName] [nvarchar](50) NULL,
	[PackageVendorDescription] [nvarchar](max) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[sPackageType]    Script Date: 05/19/2014 14:12:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackageType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sPackageType](
	[PackageTypeID] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_sPackageType_PackageTypeID]  DEFAULT (newid()),
	[PackageType] [nvarchar](50) NOT NULL,
	[Active] [int] NULL CONSTRAINT [DF_sPackageType_Active]  DEFAULT ((1)),
	[CUser] [nvarchar](100) NULL,
	[CDate] [datetime] NULL CONSTRAINT [DF_sPackageType_CDate]  DEFAULT (getdate()),
	[MUser] [nvarchar](100) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_sPackageType] PRIMARY KEY CLUSTERED 
(
	[PackageTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[sPackageSchema]    Script Date: 05/19/2014 14:12:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackageSchema]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sPackageSchema](
	[PackageSchemaID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_sPackageSchema_PackageSchemaID]  DEFAULT (newid()),
	[PackageID] [nvarchar](8) NOT NULL,
	[SchemaFileName] [nvarchar](500) NOT NULL,
	[SchemaType] [nvarchar](200) NOT NULL,
	[SchemaDescription] [nvarchar](2000) NULL,
	[SchemaShortDescription] [nvarchar](500) NOT NULL DEFAULT (''),
 CONSTRAINT [PK_sPackageSchema] PRIMARY KEY CLUSTERED 
(
	[PackageSchemaID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[sPackageRoutingIgnores]    Script Date: 05/19/2014 14:12:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackageRoutingIgnores]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sPackageRoutingIgnores](
	[AppDomain] [nvarchar](50) NULL,
	[PackageVendorID] [nvarchar](8) NULL,
	[PackageID] [nvarchar](8) NULL,
	[RouteName] [nvarchar](256) NULL,
	[RoutePattern] [nvarchar](1024) NULL,
	[Constraints] [nvarchar](2048) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[sPackageRouting]    Script Date: 05/19/2014 14:12:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackageRouting]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sPackageRouting](
	[AppDomain] [nvarchar](50) NOT NULL,
	[PackageVendorID] [nvarchar](8) NOT NULL,
	[PackageID] [nvarchar](8) NOT NULL,
	[RouteName] [nvarchar](256) NOT NULL,
	[RoutePattern] [nvarchar](1024) NOT NULL,
	[PhysicalFile] [nvarchar](1024) NOT NULL,
	[DefaultValues] [nvarchar](2048) NULL,
	[Constraints] [nvarchar](2048) NULL,
	[DataTokens] [nvarchar](2048) NULL,
	[CheckPhysicalAccess] [int] NOT NULL,
	[RouteOrder] [int] NOT NULL CONSTRAINT [DF_sPackageRouting_RouteOrder]  DEFAULT ((2000000000)),
 CONSTRAINT [PK_sPackageRouting] PRIMARY KEY CLUSTERED 
(
	[PackageVendorID] ASC,
	[PackageID] ASC,
	[RouteName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[sPackageRelationship]    Script Date: 05/19/2014 14:12:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackageRelationship]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sPackageRelationship](
	[PackageID] [nvarchar](8) NOT NULL,
	[RelatedPackageID] [nvarchar](8) NOT NULL,
	[RelationshipType] [int] NOT NULL,
 CONSTRAINT [PK_sPackageRelationship] PRIMARY KEY CLUSTERED 
(
	[PackageID] ASC,
	[RelatedPackageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[sPackageLog]    Script Date: 05/19/2014 14:12:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackageLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sPackageLog](
	[PackageLogID] [uniqueidentifier] ROWGUIDCOL  NOT NULL CONSTRAINT [DF_sPackageLog_PackageLogID]  DEFAULT (newid()),
	[PackageMapID] [uniqueidentifier] NULL,
	[PackageKeyName] [varchar](50) NULL,
	[PackageKeyValue] [varchar](50) NULL,
	[PackageUserID] [uniqueidentifier] NULL,
	[PackageUserType] [int] NULL,
	[PackageLogDate] [datetime] NULL CONSTRAINT [DF_sPackageLog_PackageLogDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_sPackageLog] PRIMARY KEY CLUSTERED 
(
	[PackageLogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sPackageDatabaseObjectType]    Script Date: 05/19/2014 14:12:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackageDatabaseObjectType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sPackageDatabaseObjectType](
	[DatabaseObjectTypeID] [int] NOT NULL,
	[DatabaseObjectType] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_sPackageDatabaseObjectType] PRIMARY KEY CLUSTERED 
(
	[DatabaseObjectTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[sPackageDatabaseObject]    Script Date: 05/19/2014 14:12:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackageDatabaseObject]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[sPackageDatabaseObject](
	[DatabaseObjectID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_sPackageDatabaseObject_DatabaseObjectID]  DEFAULT (newid()),
	[PackageID] [nvarchar](8) NOT NULL,
	[DatabaseObjectName] [nvarchar](500) NOT NULL,
	[DatabaseObjectTypeID] [int] NOT NULL,
 CONSTRAINT [PK_sPackageDatabaseObject] PRIMARY KEY CLUSTERED 
(
	[DatabaseObjectID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Check [CK_sPackageRelationships_RelationshipType]    Script Date: 05/19/2014 14:12:41 ******/
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_sPackageRelationships_RelationshipType]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPackageRelationship]'))
ALTER TABLE [dbo].[sPackageRelationship]  WITH CHECK ADD  CONSTRAINT [CK_sPackageRelationships_RelationshipType] CHECK  (([RelationshipType]=(1) OR [RelationshipType]=(0) OR [RelationshipType]=(-1)))
GO
IF  EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK_sPackageRelationships_RelationshipType]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPackageRelationship]'))
ALTER TABLE [dbo].[sPackageRelationship] CHECK CONSTRAINT [CK_sPackageRelationships_RelationshipType]
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'sPackageRelationship', N'CONSTRAINT',N'CK_sPackageRelationships_RelationshipType'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'-1 is for conflict, 1 is for requirement' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sPackageRelationship', @level2type=N'CONSTRAINT',@level2name=N'CK_sPackageRelationships_RelationshipType'
GO
/****** Object:  ForeignKey [FK_sPackageDatabaseObject_sPackageDatabaseObjectType]    Script Date: 05/19/2014 14:12:40 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sPackageDatabaseObject_sPackageDatabaseObjectType]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPackageDatabaseObject]'))
ALTER TABLE [dbo].[sPackageDatabaseObject]  WITH CHECK ADD  CONSTRAINT [FK_sPackageDatabaseObject_sPackageDatabaseObjectType] FOREIGN KEY([DatabaseObjectTypeID])
REFERENCES [dbo].[sPackageDatabaseObjectType] ([DatabaseObjectTypeID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_sPackageDatabaseObject_sPackageDatabaseObjectType]') AND parent_object_id = OBJECT_ID(N'[dbo].[sPackageDatabaseObject]'))
ALTER TABLE [dbo].[sPackageDatabaseObject] CHECK CONSTRAINT [FK_sPackageDatabaseObject_sPackageDatabaseObjectType]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07676', GetDate())
GO
