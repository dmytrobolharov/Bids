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

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'spx_AppSetting_INSERT') AND type = N'P' )
	DROP PROCEDURE spx_AppSetting_INSERT
GO

CREATE PROCEDURE spx_AppSetting_INSERT
(
	@ConfigFileName NVARCHAR(255),
	@AppSettingComment NVARCHAR(200) = NULL,
	@AppSettingKey NVARCHAR(200) = NULL,
	@AppSettingValue NVARCHAR(4000) = NULL,
	@AppSettingNote NVARCHAR(400) = NULL,
	@AppSettingOrder INTEGER,
	@CUser NVARCHAR(50),
	@CDate DATETIME,
	@AppSettingGroupID NVARCHAR(72) = '00000000-0000-0000-0000-000000000000'
)
AS 
INSERT INTO sAppSetting (ConfigFileName, AppSettingComment, AppSettingKey, AppSettingValue, AppSettingNote, AppSettingOrder, CUser, CDate, MUser, MDate, AppSettingGroupID)
VALUES (@ConfigFileName, @AppSettingComment, @AppSettingKey, @AppSettingValue, @AppSettingNote, @AppSettingOrder, @CUser, @CDate, @CUser, @CDate, @AppSettingGroupID)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07750', GetDate())
GO

SET NOCOUNT Off
GO
