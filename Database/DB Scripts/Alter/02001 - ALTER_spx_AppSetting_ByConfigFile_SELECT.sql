-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 12 October 2011                                                                            */
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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'spx_AppSetting_ByConfigFile_SELECT') AND type = N'P' )
	DROP PROCEDURE spx_AppSetting_ByConfigFile_SELECT
GO


CREATE PROCEDURE spx_AppSetting_ByConfigFile_SELECT
(
	@ConfigFileName NVARCHAR(255)
)
AS 

SELECT AppSettingID, ConfigFileName, AppSettingComment, AppSettingKey, AppSettingValue, AppSettingNote, AppSettingOrder, CUser, CDate, MUser, MDate
FROM   sAppSetting
WHERE  UPPER(ConfigFileName) = UPPER(@ConfigFileName)
ORDER BY AppSettingOrder
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '02001', GetDate())
GO

SET NOCOUNT Off
GO
