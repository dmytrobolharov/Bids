-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 19 April 2012                                                                              */
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

IF NOT EXISTS(SELECT DesignString FROM sSystemButtons WHERE UPPER(DesignString) = UPPER('btn_restore.gif'))
BEGIN

	INSERT INTO sSystemButtons ([ButtonIcon], [DesignString], [en_US])
	VALUES ('icon_refresh1.gif', 'btn_restore.gif', 'restore...')

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03385', GetDate())
GO

SET NOCOUNT Off
GO
