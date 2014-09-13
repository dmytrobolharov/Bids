-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 17 April 2012                                                                              */
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


IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sSpreadsheetFile_SpreadsheetFileID]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sSpreadsheetFile] DROP CONSTRAINT [DF_sSpreadsheetFile_SpreadsheetFileID]
END
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sSpreadsheetFile_LockID]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sSpreadsheetFile] DROP CONSTRAINT [DF_sSpreadsheetFile_LockID]
END
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sSpreadsheetFile_LockUser]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sSpreadsheetFile] DROP CONSTRAINT [DF_sSpreadsheetFile_LockUser]
END
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sSpreadsheetFile]') AND type in (N'U'))
DROP TABLE [dbo].[sSpreadsheetFile]
GO


SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[sSpreadsheetFile](
	[SpreadsheetFileID] [uniqueidentifier] NOT NULL,
	[SpreadsheetFileName] [nvarchar](256) NOT NULL,
	[SpreadsheetFileSize] [nvarchar](20) NULL,
	[SpreadsheetFile] [varbinary](max) NULL,
	[LockID] [int] NULL,
	[LockUser] [int] NULL,
	[LockUserName] [nvarchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL
) ON [PRIMARY]
GO

SET ANSI_PADDING OFF
GO


ALTER TABLE [dbo].[sSpreadsheetFile] ADD  CONSTRAINT [DF_sSpreadsheetFile_SpreadsheetFileID]  DEFAULT (newid()) FOR [SpreadsheetFileID]
GO

ALTER TABLE [dbo].[sSpreadsheetFile] ADD  CONSTRAINT [DF_sSpreadsheetFile_LockID]  DEFAULT ((0)) FOR [LockID]
GO

ALTER TABLE [dbo].[sSpreadsheetFile] ADD  CONSTRAINT [DF_sSpreadsheetFile_LockUser]  DEFAULT ((0)) FOR [LockUser]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03381', GetDate())
GO

SET NOCOUNT Off
GO
