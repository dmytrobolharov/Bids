-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 12 August 2010                                                                             */
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (select * from sysobjects where id = object_id('spx_ControlPanel_INSERT') and sysstat & 0xf = 4)
    drop procedure spx_ControlPanel_INSERT
GO

CREATE PROCEDURE spx_ControlPanel_INSERT
(@ControlPanelID int = NULL,
 @ControlPanelName VarChar(50),
 @ControlPanelDescription VarChar(200) = NULL,
 @ControlPanelOrder Int,
 @ControlPanelIdSchema VarChar(200) = NULL,
 @ControlPanelSchema VarChar(200) = NULL,
 @ControlPanelSearchSchema VarChar(200) = NULL,
 @ControlPanelTableName VarChar(100) = NULL,
 @ControlPanelUrl VarChar(100) = NULL,
 @ControlPanelEditSchema VarChar(200) = NULL)
AS 

INSERT INTO pControlPanel(ControlPanelID, ControlPanelName, ControlPanelDescription, ControlPanelOrder, ControlPanelIdSchema, ControlPanelSchema, ControlPanelSearchSchema, ControlPanelTableName, ControlPanelUrl, ControlPanelEditSchema)
VALUES (@ControlPanelID, @ControlPanelName, @ControlPanelDescription, @ControlPanelOrder, @ControlPanelIdSchema, @ControlPanelSchema, @ControlPanelSearchSchema, @ControlPanelTableName, @ControlPanelUrl, @ControlPanelEditSchema)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '344', GetDate())
GO
