-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 19 September 2011                                                                          */
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

DECLARE @DataDictionaryID int
SELECT @DataDictionaryID = ControlPanelID FROM pControlPanel WHERE ControlPanelName = 'Data Dictionary'

DELETE FROM sAccessControlPanel WHERE ControlPanelId = @DataDictionaryID
DELETE FROM sAccessGroupControlPanel WHERE ControlPanelId = @DataDictionaryID
DELETE FROM pControlPanel WHERE ControlPanelId = @DataDictionaryID
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01953', GetDate())
GO

SET NOCOUNT Off
GO
