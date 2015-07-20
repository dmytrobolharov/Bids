-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 9 May 2012                                                                              */
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
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

IF NOT EXISTS(SELECT * FROM sYuniFaceDeskTop WHERE DeskTopID = 99)
BEGIN
INSERT INTO sYuniFaceDeskTop (DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive, DeskButtonName)
VALUES (99, 'Help', 'Help', 'icon_help.gif', 'Help', '', 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=99&TID=##TEAMID##";', '../Help/Help_Menu.aspx', '../Help/Help_Main.aspx', '98', 1, 'btn_Desk_Help.gif')
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03449', GetDate())
GO

SET NOCOUNT Off
GO
