-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 25 February 2011                                                                           */
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

IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = N'vwx_DataValidationTables_SEL')
    DROP VIEW vwx_DataValidationTables_SEL
GO


CREATE VIEW vwx_DataValidationTables_SEL
AS
SELECT ControlPanelID, ControlPanelName, ControlPanelDescription, ControlPanelOrder, ControlPanelIdSchema, ControlPanelSchema, ControlPanelSearchSchema, 
       ControlPanelTableName, ControlPanelUrl, ControlPanelEditSchema, SPXLogicInsert, SPXLogicUpdate, IsDataValidation
FROM   dbo.pControlPanel
WHERE  (IsDataValidation <> 0)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01671', GetDate())
GO

SET NOCOUNT Off
GO
