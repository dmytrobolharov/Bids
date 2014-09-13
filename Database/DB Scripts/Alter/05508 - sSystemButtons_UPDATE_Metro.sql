-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 08 April 2013                                                                              */
-- *                                                                                            */
-- * Copyright (c) 2002-2013 Gerber Technology, Inc.  All rights reserved.                      */
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


UPDATE sYuniFaceDeskTop SET DeskActive = 0 WHERE DeskButtonName = 'btn_Desk_AppManager.gif'
GO


UPDATE sYuniFaceDeskTop SET DeskIcon = 'Metro_Plugin.gif' WHERE DeskButtonName = 'btn_Desk_APIPlugins.gif'
UPDATE sYuniFaceDeskTop SET DeskIcon = 'Metro_Download.gif' WHERE DeskButtonName = 'btn_Desk_AppManager.gif'
UPDATE sYuniFaceDeskTop SET DeskIcon = 'Metro_Config.gif' WHERE DeskButtonName = 'btn_Desk_ConfigEditor.gif'
UPDATE sYuniFaceDeskTop SET DeskIcon = 'Metro_Options.gif' WHERE DeskButtonName = 'btn_Desk_ConfigureYuniquePLM.gif'
UPDATE sYuniFaceDeskTop SET DeskIcon = 'Metro_Book.gif' WHERE DeskButtonName = 'btn_Desk_DataDictionary.gif'
UPDATE sYuniFaceDeskTop SET DeskIcon = 'Metro_DropDownList.gif' WHERE DeskButtonName = 'btn_Desk_DataValidation.gif'
UPDATE sYuniFaceDeskTop SET DeskIcon = 'Metro_Locked.gif' WHERE DeskButtonName = 'btn_Desk_DatabaseExtensions.gif'
UPDATE sYuniFaceDeskTop SET DeskIcon = 'Metro_Help.gif' WHERE DeskButtonName = 'btn_Desk_Help.gif'
UPDATE sYuniFaceDeskTop SET DeskIcon = 'Metro_Map.gif' WHERE DeskButtonName = 'btn_Desk_Language.gif'
UPDATE sYuniFaceDeskTop SET DeskIcon = 'Metro_WebPage.gif' WHERE DeskButtonName = 'btn_Desk_SchemaEditor.gif'
UPDATE sYuniFaceDeskTop SET DeskIcon = 'Metro_Servers.gif' WHERE DeskButtonName = 'btn_Desk_Servers.gif'
UPDATE sYuniFaceDeskTop SET DeskIcon = 'Metro_Spreadsheet.gif' WHERE DeskButtonName = 'btn_Desk_SpreadsheetEditor.gif'
UPDATE sYuniFaceDeskTop SET DeskIcon = 'Metro_Table.gif' WHERE DeskButtonName = 'btn_Desk_TableEditor.gif'
UPDATE sYuniFaceDeskTop SET DeskIcon = 'Metro_Relation.gif' WHERE DeskButtonName = 'btn_Desk_WebServiceClients.gif'
GO


EXEC spx_SystemButtons_IMPORT_MISSING
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '05508', GetDate())
GO

SET NOCOUNT Off
GO
