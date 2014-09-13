-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 31 July 2012                                                                               */
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


IF NOT EXISTS(SELECT DeskTopID FROM sYuniFaceDeskTop WHERE DeskTopID = 13)
BEGIN

	INSERT INTO sYuniFaceDeskTop (DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive)
	VALUES (13, 'Hooks', 'Hooks', 'icon_hook.gif', 'Hooks', '', 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=13&TID=##TEAMID##";', '../Hooks/Control_Hooks_Menu.aspx', '../Hooks/Control_Hooks_List.aspx', '13', 1)

END
GO


-- VALUES (1, 'Home', 'Home Page', 'icon_home.gif', 'Home', NULL, 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=1&TID=##TEAMID##";', '../Desktop/Desktop_Body.aspx', NULL, '01', 1)
UPDATE sYuniFaceDeskTop SET DeskSort = '01'
WHERE DeskTopID = 1
GO

-- VALUES (12, 'Configure YuniquePLM', 'Configure YuniquePLM', 'icon_options.gif', 'Configure', 'YuniquePLM', 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=12&TID=##TEAMID##";', '../Configurator/Control_Configurator_Menu.aspx', '../Configurator/Control_Configurator_Main.aspx', '02', 1)
UPDATE sYuniFaceDeskTop SET DeskSort = '02'
WHERE DeskTopID = 12
GO

-- VALUES (2, 'Config Editor', 'Configuration File Editor', 'icon_edit_file.gif', 'Config', 'Editor', 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=2&TID=##TEAMID##";', '../ConfigEditor/Control_ConfigEditor_Menu.aspx', '../ConfigEditor/Control_ConfigEditor_Main.aspx', '02', 1)
UPDATE sYuniFaceDeskTop SET DeskSort = '03'
WHERE DeskTopID = 2
GO

--VALUES (10, 'Table Editor', 'Table Editor', 'Icon_Table.gif', 'Table', 'Editor', 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=10&TID=##TEAMID##";', '../TableEditor/Control_TableEditor_Menu.aspx', '../TableEditor/Control_TableEditor_Main.aspx', '03', 1)
UPDATE sYuniFaceDeskTop SET DeskSort = '04'
WHERE DeskTopID = 10
GO

-- VALUES (9, 'Servers', 'Servers', 'Control_Servers.gif', 'Servers', '', 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=9&TID=##TEAMID##";', '../Servers/Control_Servers_Menu.aspx', '../Servers/Control_Servers_List.aspx', '03', 1)
UPDATE sYuniFaceDeskTop SET DeskSort = '05'
WHERE DeskTopID = 9
GO

-- VALUES (8, 'Data Validation', 'Data Validation', 'Control_DropdownList.gif', 'Data', 'Validation', 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=8&TID=##TEAMID##";', '../DataValidation/Control_DataValidation_Menu.aspx', '../DataValidation/Control_DataValidation_List.aspx', '03', 1)
UPDATE sYuniFaceDeskTop SET DeskSort = '06'
WHERE DeskTopID = 8
GO

-- VALUES (3, 'Data Dictionary', 'Data Dictionary', 'icon_bookopen.gif', 'Data', 'Dictionary', 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=3&TID=##TEAMID##";', '../DataDictionary/Control_DataDictionary_Menu.aspx', '../DataDictionary/Control_DataDictionary_List.aspx', '03', 1)
UPDATE sYuniFaceDeskTop SET DeskSort = '07'
WHERE DeskTopID = 3
GO

-- VALUES (4, 'Schema Editor', 'Schema File Editor', 'icon_edit_file.gif', 'Schema', 'Editor', 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=4&TID=##TEAMID##";', '../SchemaEditor/Control_SchemaEditor_Menu.aspx', '../SchemaEditor/Control_SchemaEditor_Main.aspx', '04', 1)
UPDATE sYuniFaceDeskTop SET DeskSort = '08'
WHERE DeskTopID = 4
GO

--VALUES (11, 'Spreadsheet Editor', 'Spreadsheet Editor', 'Icon_Table.gif', 'Spreadsheet', 'Editor', 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=11&TID=##TEAMID##";', '../SpreadsheetEditor/Control_SpreadsheetEditor_Menu.aspx', '../SpreadsheetEditor/Control_SpreadsheetEditor_Main.aspx', '03', 1)
UPDATE sYuniFaceDeskTop SET DeskSort = '09'
WHERE DeskTopID = 11
GO

-- VALUES (5, 'Language', 'Language Settings', 'icon_flag_un.gif', 'Language', NULL, 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=5&TID=##TEAMID##";', '../Language/Control_Language_Menu.aspx', '../Language/Control_Language_Main.aspx', '05', 1)
UPDATE sYuniFaceDeskTop SET DeskSort = '10'
WHERE DeskTopID = 5
GO

-- VALUES (6, 'Database Extensions', 'Database Extensions', 'icon_locked.gif', 'Database', 'Extensdions', 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=6&TID=##TEAMID##";', '../DatabaseExt/Control_Override_Menu.aspx', '../DatabaseExt/Control_Override_Main.aspx', '06', 1)
UPDATE sYuniFaceDeskTop SET DeskSort = '11'
WHERE DeskTopID = 6
GO

-- VALUES (7, 'Web Service Clients', 'Web Service Clients', 'icon_relation.gif', 'Web Service', 'Clients', 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=7&TID=##TEAMID##";', '../WSClient/Control_WSClient_Menu.aspx', '../WSClient/Control_WSClient_List.aspx', '07', 1)
UPDATE sYuniFaceDeskTop SET DeskSort = '12'
WHERE DeskTopID = 7
GO

-- 	VALUES (12, 'Hooks', 'Hooks', 'icon_hook.gif', 'Hooks', '', 'parent.dbody.location = "../Desktop/Desktop_Folder.aspx?DTID=13&TID=##TEAMID##";', '../Hook/Control_Hook_Menu.aspx', '../Hook/Control_Hook_Main.aspx', '13', 1)
UPDATE sYuniFaceDeskTop SET DeskSort = '13'
WHERE DeskTopID = 13
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03755', GetDate())
GO

SET NOCOUNT Off
GO
