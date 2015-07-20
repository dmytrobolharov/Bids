-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 07 November 2013                                                                           */
-- *                                                                                            */
-- * Copyright (c) 2002-2013 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS:
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

-----------------
-- tlk_Backups --
-----------------
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'tlk_Backups') AND type in (N'U'))
BEGIN
	DROP TABLE tlk_Backups
END
GO

CREATE TABLE [dbo].[tlk_Backups](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BackupSet] [uniqueidentifier] NULL,
	[Description] [nvarchar](max) NULL,
	[CDate] [datetime] NULL,
	[InProgress] [int] NULL,
	[Status] [int] NULL,
	[Error] [nvarchar](max) NULL,
	[Name] [nvarchar](max) NULL
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Final disposition.  0 - Has not run, 1 - Completed success,  -1  - Completed failure' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tlk_Backups', @level2type=N'COLUMN',@level2name=N'Status'
GO



SET NOCOUNT OFF
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07454', GetDate())
GO
