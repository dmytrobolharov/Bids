-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- *  9 December 2010                                                                           */
-- *                                                                                            */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'spx_UserSetting_INSERT') AND type = N'P' )
	DROP PROCEDURE spx_UserSetting_INSERT
GO


CREATE PROCEDURE spx_UserSetting_INSERT
(
    @TeamID UNIQUEIDENTIFIER,
    @SettingSection nvarchar(200),
    @SettingKey nvarchar(200),
    @SettingValue varbinary(MAX)
)
AS

BEGIN 

    INSERT INTO uUserSetting (TeamID, SettingSection, SettingKey, SettingValue)
    VALUES (@TeamID, @SettingSection, @SettingKey, @SettingValue)

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '860', GetDate())
GO
