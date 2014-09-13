-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 31 August 2012                                                                             */
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


IF EXISTS(SELECT DeskTopID FROM sYuniFaceDeskTop WHERE DeskTopID = 13)
BEGIN

	UPDATE sYuniFaceDeskTop 
	SET DeskName = 'API Plugins', 
		DeskDescription = 'API Plugins', 
		DeskLabel1 = 'API Plugins'
	WHERE DeskTopID = 13

END
GO


EXEC spx_SystemButtons_IMPORT_MISSING
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03847', GetDate())
GO

SET NOCOUNT Off
GO
