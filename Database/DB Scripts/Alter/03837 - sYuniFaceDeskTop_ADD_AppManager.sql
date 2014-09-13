-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 24 August 2012                                                                             */
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


IF NOT EXISTS(SELECT DeskTopID FROM sYuniFaceDeskTop WHERE DeskTopID = 14)
BEGIN

	INSERT INTO sYuniFaceDeskTop (DeskTopID, DeskName, DeskDescription, DeskIcon, DeskLabel1, DeskLabel2, DeskUrl, DeskMenu, DeskMain, DeskSort, DeskActive, DeskRow, DeskCol)
	VALUES (14, 'App Manager', 'App Manager', 'icon_paneldown.gif', 'App Manager', '', NULL, NULL, NULL, '14', 1, 1, 4)

END
GO


EXEC spx_SystemButtons_IMPORT_MISSING
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03837', GetDate())
GO

SET NOCOUNT Off
GO
