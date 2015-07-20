-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 09 September 2012                                                                          */
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


UPDATE sSystemButtons SET ButtonIcon = 'Metro_Plugin.gif' WHERE DesignString = 'btn_Desk_APIPlugins.gif'
UPDATE sSystemButtons SET ButtonIcon = 'Metro_Download.gif' WHERE DesignString = 'btn_Desk_AppManager.gif'
UPDATE sSystemButtons SET ButtonIcon = 'Metro_Config.gif' WHERE DesignString = 'btn_Desk_ConfigEditor.gif'
UPDATE sSystemButtons SET ButtonIcon = 'Metro_Options.gif' WHERE DesignString = 'btn_Desk_ConfigureYuniquePLM.gif'
UPDATE sSystemButtons SET ButtonIcon = 'Metro_Book.gif' WHERE DesignString = 'btn_Desk_DataDictionary.gif'
UPDATE sSystemButtons SET ButtonIcon = 'Metro_DropDownList.gif' WHERE DesignString = 'btn_Desk_DataValidation.gif'
UPDATE sSystemButtons SET ButtonIcon = 'Metro_Locked.gif' WHERE DesignString = 'btn_Desk_DatabaseExtensions.gif'
UPDATE sSystemButtons SET ButtonIcon = 'Metro_Help.gif' WHERE DesignString = 'btn_Desk_Help.gif'
UPDATE sSystemButtons SET ButtonIcon = 'Metro_Map.gif' WHERE DesignString = 'btn_Desk_Language.gif'
UPDATE sSystemButtons SET ButtonIcon = 'Metro_WebPage.gif' WHERE DesignString = 'btn_Desk_SchemaEditor.gif'
UPDATE sSystemButtons SET ButtonIcon = 'Metro_Servers.gif' WHERE DesignString = 'btn_Desk_Servers.gif'
UPDATE sSystemButtons SET ButtonIcon = 'Metro_Spreadsheet.gif' WHERE DesignString = 'btn_Desk_SpreadsheetEditor.gif'
UPDATE sSystemButtons SET ButtonIcon = 'Metro_Table.gif' WHERE DesignString = 'btn_Desk_TableEditor.gif'
UPDATE sSystemButtons SET ButtonIcon = 'Metro_Relation.gif' WHERE DesignString = 'btn_Desk_WebServiceClients.gif'
GO


EXEC spx_SystemButtons_IMPORT_MISSING
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03862', GetDate())
GO

SET NOCOUNT Off
GO
