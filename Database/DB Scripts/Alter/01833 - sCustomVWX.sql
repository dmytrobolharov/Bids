-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 2 September 2011                                                                           */
-- *                                                                                            */
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
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


IF NOT EXISTS (SELECT DISTINCT * FROM INFORMATION_SCHEMA.TABLES WHERE UPPER(TABLE_NAME) = UPPER('sCustomVWX'))
BEGIN

	CREATE TABLE sCustomVWX(
		[CustomVWXID] [uniqueidentifier] ROWGUIDCOL NOT NULL,
		[CustomVWXName] [nvarchar](256) NOT NULL,
		[CUser] [nvarchar](50) NULL,
		[CDate] [datetime] NULL,
		[MUser] [nvarchar](50) NULL,
		[MDate] [datetime] NULL
		CONSTRAINT [PK_sCustomVWX] PRIMARY KEY CLUSTERED 
		(
			[CustomVWXID] ASC
		)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]

END
GO


IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_sCustomVWX_CustomVWXID]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sCustomVWX] DROP CONSTRAINT [DF_sCustomVWX_CustomVWXID]
END
GO


ALTER TABLE [dbo].[sCustomVWX] ADD CONSTRAINT [DF_sCustomVWX_CustomVWXID] DEFAULT (newid()) FOR [CustomVWXID]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01833', GetDate())
GO

SET NOCOUNT Off
GO
