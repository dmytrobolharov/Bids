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
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'spx_UserSetting_DELETE') AND type = N'P' )
	DROP PROCEDURE spx_UserSetting_DELETE
GO


CREATE PROCEDURE spx_UserSetting_DELETE
(
    @TeamID UNIQUEIDENTIFIER,
    @SettingSection nvarchar(200),
    @SettingKey nvarchar(200)
)
AS

BEGIN 

    DELETE FROM uUserSetting
    WHERE TeamID = @TeamID 
    AND SettingSection = @SettingSection 
    AND SettingKey = @SettingKey

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '861', GetDate())
GO
