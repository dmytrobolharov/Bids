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

IF EXISTS (select * from sysobjects where id = object_id('spx_ControlPanel_DELETE') and sysstat & 0xf = 4)
    drop procedure spx_ControlPanel_DELETE
GO

CREATE PROCEDURE spx_ControlPanel_DELETE 
(@ControlPanelID int)
AS 

DELETE FROM sAccessControlPanel
WHERE ControlPanelId = @ControlPanelID

DELETE FROM sAccessGroupControlPanel
WHERE ControlPanelId = @ControlPanelID

DELETE FROM pControlPanel
WHERE ControlPanelID = @ControlPanelID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '343', GetDate())
GO
