-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 31 March 2011                                                                              */
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

IF EXISTS (select * from sysobjects where id = object_id('spx_ControlPanel_ByControlPanelName_SELECT') and sysstat & 0xf = 4)
    drop procedure spx_ControlPanel_ByControlPanelName_SELECT
GO

CREATE PROCEDURE spx_ControlPanel_ByControlPanelName_SELECT
(@ControlPanelName NVarChar(50),
 @TeamID uniqueidentifier = NULL)
AS 

IF @TeamID IS NULL
BEGIN

    SELECT * FROM pControlPanel 
    WHERE UPPER(ControlPanelName) = UPPER(@ControlPanelName) 
    ORDER BY ControlPanelOrder

END

ELSE
BEGIN

    SELECT * FROM pControlPanel
    WHERE ControlPanelId IN (SELECT ControlPanelId FROM sAccessControlPanel WHERE AccessRoleId <> 0 AND TeamId = @TeamID)
    AND UPPER(ControlPanelName) = UPPER(@ControlPanelName) 
    ORDER BY ControlPanelOrder

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01682', GetDate())
GO

SET NOCOUNT Off
GO
