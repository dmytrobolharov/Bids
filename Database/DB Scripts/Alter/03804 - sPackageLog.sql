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

-- Remove the original sApplicationLog table.
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sApplicationLog_ApplicationLogI]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sApplicationLog] DROP CONSTRAINT [DF_sApplicationLog_ApplicationLogId]
END
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sApplicationLog_ApplicationLogDate]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sApplicationLog] DROP CONSTRAINT [DF_sApplicationLog_ApplicationLogDate]
END
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sApplicationLog]') AND type in (N'U'))
BEGIN
	DROP TABLE [dbo].[sApplicationLog]
END
GO


-- Now remove the new sPackageLog table.
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
BEGIN
	DROP TABLE [dbo].[sPackageLog]
END
GO


CREATE TABLE [dbo].[sPackageLog](
	[PackageLogID] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[PackageMapID] [uniqueidentifier] NULL,
	[PackageKeyName] [varchar](50) NULL,
	[PackageKeyValue] [varchar](50) NULL,
	[PackageUserID] [uniqueidentifier] NULL,
	[PackageUserType] [int] NULL,
	[PackageLogDate] [datetime] NULL,
 CONSTRAINT [PK_sPackageLog] PRIMARY KEY CLUSTERED 
(
	[PackageLogID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[sPackageLog] ADD  CONSTRAINT [DF_sPackageLog_PackageLogID]  DEFAULT (newid()) FOR [PackageLogID]
GO

ALTER TABLE [dbo].[sPackageLog] ADD  CONSTRAINT [DF_sPackageLog_PackageLogDate]  DEFAULT (getdate()) FOR [PackageLogDate]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03804', GetDate())
GO

SET NOCOUNT Off
GO
