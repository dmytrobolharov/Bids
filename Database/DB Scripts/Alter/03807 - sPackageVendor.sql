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

-- Remove the original sAppVendor table.
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAppVendor]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[sAppVendor]
END
GO


-- Now remove the new sPackageVendor table.
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sPackageVendor]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[sPackageVendor]
END
GO

CREATE TABLE [dbo].[sPackageVendor](
	[PackageVendorID] [nvarchar](8) NULL,
	[PackageVendorName] [nvarchar](50) NULL,
	[PackageVendorDescription] [nvarchar](max) NULL
) ON [PRIMARY]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03807', GetDate())
GO

SET NOCOUNT Off
GO
