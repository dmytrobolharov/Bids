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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'spx_AppSetting_SELECT') AND type = N'P' )
	DROP PROCEDURE spx_AppSetting_SELECT
GO

CREATE PROCEDURE spx_AppSetting_SELECT
(
	@ConfigFileName NVARCHAR(255),
	@AppSettingKey NVARCHAR(200),
	@AppSettingGroupID NVARCHAR(72) = '00000000-0000-0000-0000-000000000000'
)
AS 
SELECT AppSettingID, ConfigFileName, AppSettingComment, AppSettingKey, AppSettingValue, AppSettingNote, AppSettingOrder, CUser, CDate, MUser, MDate
FROM   sAppSetting
WHERE  UPPER(ConfigFileName) = UPPER(@ConfigFileName)
AND    UPPER(AppSettingKey) = UPPER(@AppSettingKey)
AND UPPER(AppSettingGroupID) = UPPER(@AppSettingGroupID)
ORDER BY AppSettingOrder
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07751', GetDate())
GO

SET NOCOUNT Off
GO
