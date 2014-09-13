-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 07 June 2012                                                                               */
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

IF NOT EXISTS(SELECT DesignString FROM sSystemButtons WHERE UPPER(DesignString) = UPPER('btn_license_demo.gif'))
BEGIN

	INSERT INTO sSystemButtons ([ButtonIcon], [DesignString], [en_US])
	VALUES ('icon_license_demo.gif', 'btn_license_demo.gif', 'demo license')

END
GO


IF NOT EXISTS(SELECT DesignString FROM sSystemButtons WHERE UPPER(DesignString) = UPPER('btn_license_activate.gif'))
BEGIN

	INSERT INTO sSystemButtons ([ButtonIcon], [DesignString], [en_US])
	VALUES ('icon_license.gif', 'btn_license_activate.gif', 'activate license')

END
GO


IF NOT EXISTS(SELECT DesignString FROM sSystemButtons WHERE UPPER(DesignString) = UPPER('btn_license_update.gif'))
BEGIN

	INSERT INTO sSystemButtons ([ButtonIcon], [DesignString], [en_US])
	VALUES ('icon_license_update.gif', 'btn_license_update.gif', 'update license')

END
GO


IF NOT EXISTS(SELECT DesignString FROM sSystemButtons WHERE UPPER(DesignString) = UPPER('btn_ConfigureYuniquePLM.gif'))
BEGIN

	INSERT INTO sSystemButtons ([ButtonIcon], [DesignString], [en_US])
	VALUES ('icon_options.gif', 'btn_ConfigureYuniquePLM.gif', 'configure YuniquePLM')

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03655', GetDate())
GO

SET NOCOUNT Off
GO
