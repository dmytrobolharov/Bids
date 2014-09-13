-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 21 September 2011                                                                          */
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


INSERT INTO sYuniFaceDeskTop (DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive)
VALUES (9, 'Servers', 'Servers', 'Icon_Sites.gif', 'Servers', '', 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=9&TID=##TEAMID##";', '../Servers/Control_Servers_Menu.aspx', '../Servers/Control_Servers_Main.aspx', '03', 1)
GO

-- VALUES (1, 'Home', 'Home Page', 'icon_home.gif', 'Home', NULL, 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=1&TID=##TEAMID##";', '../Desktop/Desktop_Body.aspx', NULL, '01', 1)
UPDATE sYuniFaceDeskTop SET DeskSort = '01'
WHERE DeskTopID = 1
GO

-- VALUES (2, 'Config Editor', 'Configuration File Editor', 'icon_edit_file.gif', 'Config', 'Editor', 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=2&TID=##TEAMID##";', '../ConfigEditor/Control_ConfigEditor_Menu.aspx', '../ConfigEditor/Control_ConfigEditor_Main.aspx', '02', 1)
UPDATE sYuniFaceDeskTop SET DeskSort = '02'
WHERE DeskTopID = 2
GO

-- VALUES (3, 'Data Dictionary', 'Data Dictionary', 'icon_bookopen.gif', 'Data', 'Dictionary', 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=3&TID=##TEAMID##";', '../DataDictionary/Control_DataDictionary_Menu.aspx', '../DataDictionary/Control_DataDictionary_List.aspx', '03', 1)
UPDATE sYuniFaceDeskTop SET DeskSort = '05'
WHERE DeskTopID = 3
GO

-- VALUES (4, 'Schema Editor', 'Schema File Editor', 'icon_edit_file.gif', 'Schema', 'Editor', 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=4&TID=##TEAMID##";', '../SchemaEditor/Control_SchemaEditor_Menu.aspx', '../SchemaEditor/Control_SchemaEditor_Main.aspx', '04', 1)
UPDATE sYuniFaceDeskTop SET DeskSort = '06'
WHERE DeskTopID = 4
GO

-- VALUES (5, 'Language', 'Language Settings', 'icon_flag_un.gif', 'Language', NULL, 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=5&TID=##TEAMID##";', '../Language/Control_Language_Menu.aspx', '../Language/Control_Language_Main.aspx', '05', 1)
UPDATE sYuniFaceDeskTop SET DeskSort = '07'
WHERE DeskTopID = 5
GO

-- VALUES (6, 'Database Extensions', 'Database Extensions', 'icon_locked.gif', 'Database', 'Extensdions', 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=6&TID=##TEAMID##";', '../DatabaseExt/Control_Override_Menu.aspx', '../DatabaseExt/Control_Override_Main.aspx', '06', 1)
UPDATE sYuniFaceDeskTop SET DeskSort = '08'
WHERE DeskTopID = 6
GO

-- VALUES (7, 'Web Service Clients', 'Web Service Clients', 'icon_relation.gif', 'Web Service', 'Clients', 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=7&TID=##TEAMID##";', '../WSClient/Control_WSClient_Menu.aspx', '../WSClient/Control_WSClient_List.aspx', '07', 1)
UPDATE sYuniFaceDeskTop SET DeskSort = '09'
WHERE DeskTopID = 7
GO

-- VALUES (8, 'Data Validation', 'Data Validation', 'Control_DropdownList.gif', 'Data', 'Validation', 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=8&TID=##TEAMID##";', '../DataValidation/Control_DataValidation_Menu.aspx', '../DataValidation/Control_DataValidation_List.aspx', '03', 1)
UPDATE sYuniFaceDeskTop SET DeskSort = '04'
WHERE DeskTopID = 8
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01959', GetDate())
GO

SET NOCOUNT Off
GO
