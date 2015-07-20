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

IF NOT EXISTS (SELECT * FROM pControlPanel WHERE UPPER(ControlPanelName) = 'DATA VALIDATION')
BEGIN

    INSERT INTO pControlPanel ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [IsDataValidation], [ControlPanelTypeID]) 
    SELECT COALESCE(MAX(ControlPanelID),0) + 1, 
           'Data Validation', 
           'Data Validation', 
           COALESCE(MAX(ControlPanelOrder),0) + 1, 
           'Control_DataValidation_Default.xml', 
           'Control_DataValidation_Search.xml', 
           'pControlPanel', 
           'Control_DataValidation_List.aspx?CPID=' + convert(varchar(12), COALESCE(MAX(ControlPanelID),0) + 1), 
           0,
           N'ecc16935-3677-e011-8802-000c29807141'
    FROM pControlPanel

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03774', GetDate())
GO

SET NOCOUNT Off
GO
