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

-- Remove the original sAppRoutingIgnores table.
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAppRoutingIgnores]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[sAppRoutingIgnores]
END
GO


-- Now remove the new sPackageRoutingIgnores table.
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackageRoutingIgnores]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[sPackageRoutingIgnores]
END
GO

CREATE TABLE [dbo].[sPackageRoutingIgnores](
	[AppDomain] [nvarchar](50) NULL,
	[PackageVendorID] [nvarchar](8) NULL,
	[PackageID] [nvarchar](8) NULL,
	[RouteName] [nvarchar](256) NULL,
	[RoutePattern] [nvarchar](1024) NULL,
	[Constraints] [nvarchar](2048) NULL
) ON [PRIMARY]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03806', GetDate())
GO

SET NOCOUNT Off
GO
