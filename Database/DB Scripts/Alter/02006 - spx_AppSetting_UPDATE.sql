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

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'spx_AppSetting_UPDATE') AND type = N'P' )
	DROP PROCEDURE spx_AppSetting_UPDATE
GO


CREATE PROCEDURE spx_AppSetting_UPDATE
(
	@AppSettingID UNIQUEIDENTIFIER,
	@AppSettingComment NVARCHAR(200) = NULL,
	@AppSettingKey NVARCHAR(200) = NULL,
	@AppSettingValue NVARCHAR(4000) = NULL,
	@AppSettingNote NVARCHAR(400) = NULL,
	@AppSettingOrder INTEGER,
	@MUser NVARCHAR(50),
	@MDate DATETIME
)
AS 

UPDATE sAppSetting 
	SET AppSettingComment = @AppSettingComment,
	AppSettingKey = @AppSettingKey,
	AppSettingValue = @AppSettingValue,
	AppSettingNote = @AppSettingNote,
	AppSettingOrder = @AppSettingOrder,
	MUser = @MUser,
	MDate = @MDate
WHERE AppSettingID = @AppSettingID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '02006', GetDate())
GO

SET NOCOUNT Off
GO
