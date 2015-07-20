-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 24 May 2012                                                                              */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
IF EXISTS (SELECT ControlPanelID FROM pControlPanel WHERE ControlPanelName='Category')
BEGIN
	UPDATE pControlPanel SET ControlPanelName='Style Category',ControlPanelDescription='Style Category'  WHERE ControlPanelName='Category'
END


IF EXISTS (SELECT ControlPanelID FROM pControlPanel WHERE ControlPanelName='Product Type')
BEGIN
	UPDATE pControlPanel SET ControlPanelName='Item Category',ControlPanelDescription='Item Category' WHERE ControlPanelName='Product Type'
END

GO


	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES ('DB_Version', '5.0.0000', '03504', GetDate())
	
GO
