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

-- Remove the original sAppRouting table.
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sRouting5_RouteOrder]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sAppRouting] DROP CONSTRAINT [DF_sRouting5_RouteOrder]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAppRouting]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[sAppRouting]
END
GO


-- Now remove the new sPackageRouting table.
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sPackageRouting_RouteOrder]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sPackageRouting] DROP CONSTRAINT [DF_sPackageRouting_RouteOrder]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackageRouting]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[sPackageRouting]
END
GO


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
	[RouteOrder] [int] NOT NULL
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sPackageRouting] ADD  CONSTRAINT [DF_sPackageRouting_RouteOrder]  DEFAULT ((2000000000)) FOR [RouteOrder]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03805', GetDate())
GO

SET NOCOUNT Off
GO
