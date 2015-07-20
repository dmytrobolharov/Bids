-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 9 March 2011                                                                               */
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

IF NOT EXISTS (SELECT * FROM pControlPanel WHERE UPPER(ControlPanelName) = 'MACHINES')
BEGIN

    INSERT INTO pControlPanel ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [IsDataValidation], [ControlPanelTypeID]) 
    SELECT COALESCE(MAX(ControlPanelID),0) + 1, 
           'Machines', 
           'Machines', 
           COALESCE(MAX(ControlPanelOrder),0) + 1, 
           'Control_Custom_BOL_Machines_Default.xml', 
           'Control_Custom_BOL_Machines_Search.xml', 
           'pBOLMachines',
           'Control_BOL_Machine_Category.aspx?CPID=' + convert(varchar(12), COALESCE(MAX(ControlPanelID),0) + 1),
		   'Control_Custom_BOL_Machines_Edit.xml',
           0,
           N'09773e42-5ab8-e011-9f63-544c92f24f0c'
    FROM pControlPanel

END

IF NOT EXISTS (SELECT * FROM pControlPanel WHERE UPPER(ControlPanelName) = 'OPERATIONS')
BEGIN

    INSERT INTO pControlPanel ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [IsDataValidation], [ControlPanelTypeID]) 
    SELECT COALESCE(MAX(ControlPanelID),0) + 1, 
           'Operations', 
           'Operations', 
           COALESCE(MAX(ControlPanelOrder),0) + 1, 
           'Control_Custom_BOL_Operations_Default.xml', 
           'Control_Custom_BOL_Operations_Search.xml', 
           'pBOLOperationCategory',
           'Control_BOL_Operation_Category.aspx?CPID=' + convert(varchar(12), COALESCE(MAX(ControlPanelID),0) + 1),
		   'Control_Custom_BOL_Operations_Edit.xml',
           0,
           N'09773e42-5ab8-e011-9f63-544c92f24f0c'
    FROM pControlPanel

END

IF NOT EXISTS (SELECT * FROM pControlPanel WHERE UPPER(ControlPanelName) = 'MACRO-OPERATIONS')
BEGIN

    INSERT INTO pControlPanel ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [IsDataValidation], [ControlPanelTypeID]) 
    SELECT COALESCE(MAX(ControlPanelID),0) + 1, 
           'Macro-Operations', 
           'Macro-Operations', 
           COALESCE(MAX(ControlPanelOrder),0) + 1, 
           'Control_Custom_BOL_Macro_Default.xml', 
           'Control_Custom_BOL_Macro_Search.xml', 
           'pBOLMacro',
           'Control_BOL_Macro_Category.aspx?CPID=' + convert(varchar(12), COALESCE(MAX(ControlPanelID),0) + 1),
		   'Control_Custom_BOL_Macro_Edit.xml',
           0,
           N'09773e42-5ab8-e011-9f63-544c92f24f0c'
    FROM pControlPanel

END

IF NOT EXISTS (SELECT * FROM pControlPanel WHERE UPPER(ControlPanelName) = 'FACTORY RATES')
BEGIN

    INSERT INTO pControlPanel ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [IsDataValidation], [ControlPanelTypeID]) 
    SELECT COALESCE(MAX(ControlPanelID),0) + 1, 
           'Factory Rates', 
           'Factory Rates', 
           COALESCE(MAX(ControlPanelOrder),0) + 1, 
           'Control_Custom_BOL_Factories_Default.xml', 
           'Control_Custom_BOL_Factories_Search.xml', 
           'pBOLFactories',
           'Control_BOL_Factory_List.aspx?CPID=' + convert(varchar(12), COALESCE(MAX(ControlPanelID),0) + 1),
		   'Control_Custom_BOL_Factories_Edit.xml',
           0,
           N'09773e42-5ab8-e011-9f63-544c92f24f0c'
    FROM pControlPanel

END

IF NOT EXISTS (SELECT * FROM pControlPanel WHERE UPPER(ControlPanelName) = 'TEMPLATES')
BEGIN

    INSERT INTO pControlPanel ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [ControlPanelEditSchema], [IsDataValidation], [ControlPanelTypeID]) 
    SELECT COALESCE(MAX(ControlPanelID),0) + 1, 
           'Templates', 
           'Templates', 
           COALESCE(MAX(ControlPanelOrder),0) + 1, 
           'Control_Custom_BOL_Templates_Default.xml', 
           'Control_Custom_BOL_Templates_Search.xml', 
           'pBOLTemplates',
           'Control_BOL_Template_Category.aspx?CPID=' + convert(varchar(12), COALESCE(MAX(ControlPanelID),0) + 1),
		   'Control_Custom_BOL_Template_Edit.xml',
           0,
           N'09773e42-5ab8-e011-9f63-544c92f24f0c'
    FROM pControlPanel

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01751', GetDate())
GO

SET NOCOUNT Off
GO
