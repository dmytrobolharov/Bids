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

/****** Object:  Table [dbo].[sPackage]    Script Date: 02/03/2014 15:04:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackage]') AND type in (N'U'))
DROP TABLE [dbo].[sPackage]
GO

/****** Object:  Table [dbo].[sPackage]    Script Date: 02/03/2014 15:04:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[sPackage](
	[PackageID] [nvarchar](8) NOT NULL,
	[PackageVendorID] [nvarchar](8) NOT NULL,
	[PackageName] [nvarchar](255) NOT NULL,
	[PackageDescription] [nvarchar](max) NULL,
	[PackageTypeID] [uniqueidentifier] NOT NULL,
	[PackageInstallDate] [datetime] NOT NULL,
	[PackageGUID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[PackageVersion] [nvarchar](10) NOT NULL,
	[PackagePLMVersion] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_sPackage] PRIMARY KEY CLUSTERED 
(
	[PackageID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sPackage] ADD  CONSTRAINT [DF_sPackage_PackageVendorID]  DEFAULT (N'00000000') FOR [PackageVendorID]
GO

ALTER TABLE [dbo].[sPackage] ADD  CONSTRAINT [DF_sPackage_PackageTypeID]  DEFAULT (N'66666666-0000-0000-0000-000000000001') FOR [PackageTypeID]
GO

ALTER TABLE [dbo].[sPackage] ADD  CONSTRAINT [DF_sPackage_PackageInstallDate]  DEFAULT (getdate()) FOR [PackageInstallDate]
GO

ALTER TABLE [dbo].[sPackage] ADD  CONSTRAINT [DF_sPackage_PackageGUID]  DEFAULT (newid()) FOR [PackageGUID]
GO

ALTER TABLE [dbo].[sPackage] ADD  CONSTRAINT [DF_sPackage_PackageVersion]  DEFAULT (N'0.1.0') FOR [PackageVersion]
GO

ALTER TABLE [dbo].[sPackage] ADD  CONSTRAINT [DF_sPackage_PackagePLMVersion]  DEFAULT (N'5.0.x') FOR [PackagePLMVersion]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07075', GetDate())
GO
