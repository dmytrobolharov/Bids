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


-------------------------------
-- COLUMN: AppSettingGroupID --
-------------------------------
IF NOT EXISTS
(
	SELECT * 
	FROM INFORMATION_SCHEMA.COLUMNS	
	WHERE TABLE_NAME = 'sAppSetting'	
	AND COLUMN_NAME = 'AppSettingGroupID'
)
BEGIN
	ALTER TABLE [dbo].[sAppsetting] ADD [AppSettingGroupID] [nvarchar](72) NULL
END
GO

UPDATE sAppSetting
SET AppSettingGroupID = '00000000-0000-0000-0000-000000000000'
WHERE LEN(AppSettingGroupID) = 0 OR AppSettingGroupID IS NULL
GO

ALTER TABLE [dbo].[sAppSetting] ALTER COLUMN [AppSettingGroupID] [nvarchar](72) NOT NULL
GO


------------------------------------------
-- INDEX: sAppSetting_AppSettingGroupID --
------------------------------------------
IF NOT EXISTS 
( 
	SELECT * 
	FROM sys.indexes 
	WHERE name = 'sAppSetting_AppSettingGroupID' AND object_id = OBJECT_ID('sAppSetting')
) 
BEGIN
	CREATE INDEX sAppSetting_AppSettingGroupID ON sAppSetting (AppSettingGroupID ASC)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07746', GetDate())
GO

SET NOCOUNT Off
GO
