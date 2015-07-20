-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 23 August 2012                                                                             */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

-- Remove the original sApp table.
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sApp]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[sApp]
END
GO


-- Now remove the new sPackage table.
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

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPackage_PackageGUID]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sPackage] DROP CONSTRAINT [DF_sPackage_PackageGUID]
END
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPackage_PackageInstallDate]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sPackage] DROP CONSTRAINT [DF_sPackage_PackageInstallDate]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackage]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[sPackage]
END
GO

CREATE TABLE [dbo].[sPackage](
	[PackageID] [nvarchar](8) NOT NULL,
	[PackageVendorID] [nvarchar](8) NOT NULL,
	[PackageName] [nvarchar](255) NOT NULL,
	[PackageDescription] [nvarchar](max) NULL,
	[PackageTypeID] [uniqueidentifier] NOT NULL,
	[PackageInstallDate] [datetime] NOT NULL,
	[PackageGUID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
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


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03802', GetDate())
GO

SET NOCOUNT Off
GO
