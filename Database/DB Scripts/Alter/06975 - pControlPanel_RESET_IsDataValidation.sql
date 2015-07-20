-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 21 January 2014                                                                            */
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

UPDATE pControlPanel
SET IsDataValidation = 2
WHERE IsDataValidation <> 0
AND ControlPanelTableName IN ('dvtHorizontalandVertical', 'dvtRadGridViewMode', 'dvtRadGridSaveMode', 'dvtValidatorClass', 'dvtValidatorType', 'dvtFormColumns', 'dvtTrueFalse', 'dvtCRUD')
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
             VALUES ('DB_Version', '0.5.0000', '06975', GetDate())
GO

SET NOCOUNT Off
GO
