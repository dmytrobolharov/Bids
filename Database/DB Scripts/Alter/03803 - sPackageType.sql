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
BEGIN
	DROP TABLE [dbo].[sPackageType]
END
GO


CREATE TABLE [dbo].[sPackageType](
	[PackageTypeID] [uniqueidentifier] ROWGUIDCOL NOT NULL,
	[PackageType] [nvarchar](50) NOT NULL,
	[Active] [int] NULL,
	[CUser] [nvarchar](100) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](100) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_sPackageType] PRIMARY KEY CLUSTERED 
(
	[PackageTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sPackageType] ADD  CONSTRAINT [DF_sPackageType_PackageTypeID]  DEFAULT (newid()) FOR [PackageTypeID]
GO

ALTER TABLE [dbo].[sPackageType] ADD  CONSTRAINT [DF_sPackageType_Active]  DEFAULT ((1)) FOR [Active]
GO

ALTER TABLE [dbo].[sPackageType] ADD  CONSTRAINT [DF_sPackageType_CDate]  DEFAULT (getdate()) FOR [CDate]
GO


INSERT INTO sPackageType (PackageTypeID, PackageType, Active, CUser, CDate, MUser, MDate)
VALUES ('66666666-0000-0000-0000-000000000001', 'App', 1, 'administrator', getutcdate(), 'administrator', getutcdate())
GO

INSERT INTO sPackageType (PackageTypeID, PackageType, Active, CUser, CDate, MUser, MDate)
VALUES ('66666666-0000-0000-0000-000000000002', 'Hotfix', 1, 'administrator', getutcdate(), 'administrator', getutcdate())
GO

INSERT INTO sPackageType (PackageTypeID, PackageType, Active, CUser, CDate, MUser, MDate)
VALUES ('66666666-0000-0000-0000-000000000003', 'Upgrade', 1, 'administrator', getutcdate(), 'administrator', getutcdate())
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03803', GetDate())
GO

SET NOCOUNT Off
GO
