-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 26 May 2014                                                                                */
-- *                                                                                            */
-- * Copyright (c) 2002-2014 Gerber Technology, Inc.  All rights reserved.                      */
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


-----------------------------
-- TABLE: sAppSettingGroup --
-----------------------------
IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'sAppSettingGroup') 
    DROP TABLE sAppSettingGroup
GO

CREATE TABLE [dbo].[sAppSettingGroup]
(
	[AppSettingGroupID] [nvarchar](72) NOT NULL,
	[AppSettingGroupName] [nvarchar](200) NOT NULL,
	[AppSettingGroupDescription] [nvarchar](500) NULL,
	[CUser] [nvarchar](50) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](50) NULL,
	[MDate] [datetime] NULL,
	CONSTRAINT [PK_sAppSettingGroup] PRIMARY KEY CLUSTERED 
	(
		[AppSettingGroupID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
GO


------------------
-- Default Data --
------------------
IF NOT EXISTS 
( 
	SELECT * 
	FROM sAppSettingGroup
	WHERE AppSettingGroupID = '00000000-0000-0000-0000-000000000000'
) 
BEGIN
	INSERT INTO sAppSettingGroup
	([AppSettingGroupID]
     ,[AppSettingGroupName]
     ,[AppSettingGroupDescription]
     ,[CUser]
     ,[CDate]
     ,[MUser]
     ,[MDate])
	VALUES 
	('00000000-0000-0000-0000-000000000000'
	 ,'(default)'
	 ,'Default app setting group'
	 ,'YuniquePLM'
	 ,GETUTCDATE()
	 ,'YuniquePLM'
	 ,GETUTCDATE())
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07745', GetDate())
GO

SET NOCOUNT Off
GO
