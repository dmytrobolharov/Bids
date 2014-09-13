-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 12 August 2011                                                                             */
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

IF EXISTS (select * from sysobjects where id = object_id('spx_ControlPanel_UPDATE') and sysstat & 0xf = 4)
    drop procedure spx_ControlPanel_UPDATE
GO


CREATE PROCEDURE spx_ControlPanel_UPDATE
(@ControlPanelID int,
 @ControlPanelName NVarChar(50),
 @ControlPanelDescription NVarChar(200) = NULL,
 @ControlPanelOrder Int,
 @ControlPanelIdSchema NVarChar(200) = NULL,
 @ControlPanelSchema NVarChar(200) = NULL,
 @ControlPanelSearchSchema NVarChar(200) = NULL,
 @ControlPanelTableName NVarChar(100) = NULL,
 @ControlPanelUrl NVarChar(100) = NULL,
 @ControlPanelEditSchema NVarChar(200) = NULL,
 @ControlPanelSPXLogicInsert NVarChar(200) = NULL,
 @ControlPanelSPXLogicUpdate NVarChar(200) = NULL,
 @ControlPanelIsDataValidation int = NULL,
 @ControlPanelTypeID uniqueidentifier = NULL)
AS 
BEGIN
	UPDATE pControlPanel
	SET ControlPanelName = @ControlPanelName, 
	ControlPanelDescription = @ControlPanelDescription, 
	ControlPanelOrder = @ControlPanelOrder, 
	ControlPanelIdSchema = @ControlPanelIdSchema, 
	ControlPanelSchema = @ControlPanelSchema, 
	ControlPanelSearchSchema = @ControlPanelSearchSchema, 
	ControlPanelTableName = @ControlPanelTableName, 
	ControlPanelUrl = @ControlPanelUrl, 
	ControlPanelEditSchema = @ControlPanelEditSchema,
	SPXLogicInsert = @ControlPanelSPXLogicInsert,
	SPXLogicUpdate = @ControlPanelSPXLogicUpdate,
	IsDataValidation = @ControlPanelIsDataValidation,
	ControlPanelTypeID = @ControlPanelTypeID
	WHERE ControlPanelID = @ControlPanelID
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01674', GetDate())
GO

SET NOCOUNT Off
GO
