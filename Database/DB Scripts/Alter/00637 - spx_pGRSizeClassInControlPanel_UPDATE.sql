-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 26 October 2010                                                                               */
-- *                                                                                            */
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
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


CREATE PROCEDURE spx_pGRSizeClassInControlPanel_UPDATE

AS 

UPDATE pControlPanel
SET   ControlPanelSchema ='Control_GRSizeClass_Library.xml', 
	  ControlPanelSearchSchema= 'Control_GRSizeClass_SearchLibrary.xml', 
	  ControlPanelUrl = 'Control_SizeClass_GR.aspx?CPID=17' 
WHERE     (ControlPanelId = 17)


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '637', GetDate())
GO
