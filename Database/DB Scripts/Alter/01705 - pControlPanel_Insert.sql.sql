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

IF NOT EXISTS (SELECT * FROM pControlPanelType WHERE UPPER(ControlPanelTypeName) = 'BILL OF LABOR')
BEGIN
	INSERT [dbo].[pControlPanelType] ([ControlPanelTypeID], [ControlPanelTypeName], [ControlPanelTypeDescription], [CUser], [CDate], [MUser], [MDate],[Active], [Sort]) VALUES (N'09773e42-5ab8-e011-9f63-544c92f24f0c', N'Bill Of Labor', N'Bill Of Labor', N'administrator ', CAST(0x00009EDA00C00BAC AS DateTime), N'administrator ', CAST(0x00009EDA00D6DD78 AS DateTime), 1, N'002')
END


IF NOT EXISTS (SELECT * FROM pControlPanel WHERE UPPER(ControlPanelName) = 'BASE RATE TYPE')
BEGIN

    INSERT INTO pControlPanel ([ControlPanelID], [ControlPanelName], [ControlPanelDescription], [ControlPanelOrder], [ControlPanelSchema], [ControlPanelSearchSchema], [ControlPanelTableName], [ControlPanelUrl], [IsDataValidation], [ControlPanelTypeID]) 
    SELECT COALESCE(MAX(ControlPanelID),0) + 1, 
           'Base Rate Type', 
           'Base Rate Type', 
           COALESCE(MAX(ControlPanelOrder),0) + 1, 
           'Control_Custom_BOL_BaseRateType_Default.xml', 
           'Control_Custom_BOL_BaseRateType_Search.xml', 
           'pControlPanel',
           ' Control_BOL_BaseRateType_List.aspx?CPID=' + convert(varchar(12), COALESCE(MAX(ControlPanelID),0) + 1), 
           0,
           N'09773e42-5ab8-e011-9f63-544c92f24f0c'
    FROM pControlPanel

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01705', GetDate())
GO

SET NOCOUNT Off
GO
