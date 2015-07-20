-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 20 August 2010                                                                             */
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

IF EXISTS (select * from sysobjects where id = object_id('spx_ControlPanel_SELECT') and sysstat & 0xf = 4)
    drop procedure spx_ControlPanel_SELECT
GO

CREATE PROCEDURE spx_ControlPanel_SELECT
(@ControlPanelID int = NULL,
@TeamID uniqueidentifier = NULL)
AS 

IF @TeamID IS NULL
BEGIN

    IF @ControlPanelID IS NULL
    BEGIN
	    SELECT * FROM pControlPanel 
	    ORDER BY ControlPanelOrder
    END

    ELSE
    BEGIN
	    SELECT * FROM pControlPanel 
        WHERE ControlPanelId = @ControlPanelID 
	    ORDER BY ControlPanelOrder
    END

END

ELSE
BEGIN

    IF @ControlPanelID IS NULL
    BEGIN
        SELECT * FROM pControlPanel
        WHERE ControlPanelId IN (SELECT ControlPanelId FROM sAccessControlPanel WHERE AccessRoleId <> 0 AND TeamId = @TeamID)
        ORDER BY ControlPanelOrder
    END

    ELSE
    BEGIN
        SELECT * FROM pControlPanel
        WHERE ControlPanelId IN (SELECT ControlPanelId FROM sAccessControlPanel WHERE AccessRoleId <> 0 AND TeamId = @TeamID)
        AND ControlPanelId = @ControlPanelID 
        ORDER BY ControlPanelOrder
    END

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '342', GetDate())
GO
