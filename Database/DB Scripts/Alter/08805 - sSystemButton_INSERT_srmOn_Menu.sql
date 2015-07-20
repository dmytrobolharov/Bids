-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 13 August 2014                                                                             */
-- *                                                                                            */
-- * Copyright (c) 2002-2014 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS:
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_srmOnMenu_Home.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonType, DesignString, en_US, ButtonIcon )
	VALUES ('srmOnMenu', 'btn_srmOnMenu_Home.gif', 'home', 'icon_home.gif')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_srmOnMenu_Profile.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonType, DesignString, en_US, ButtonIcon )
	VALUES ('srmOnMenu', 'btn_srmOnMenu_Profile.gif', 'profile', 'icon_team.gif')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_srmOnMenu_Image.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonType, DesignString, en_US, ButtonIcon )
	VALUES ('srmOnMenu', 'btn_srmOnMenu_Image.gif', 'image', 'icon_image.gif')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_srmOnMenu_Material.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonType, DesignString, en_US, ButtonIcon )
	VALUES ('srmOnMenu', 'btn_srmOnMenu_Material.gif', 'material', 'icon_fileimage.gif')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_srmOnMenu_Style.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonType, DesignString, en_US, ButtonIcon )
	VALUES ('srmOnMenu', 'btn_srmOnMenu_Style.gif', 'style', 'icon_fileA.gif')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_srmOnMenu_Compliance.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonType, DesignString, en_US, ButtonIcon )
	VALUES ('srmOnMenu', 'btn_srmOnMenu_Compliance.gif', 'compliance', 'icon_bookclose.gif')
END

--IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_srmOnMenu_Resources.gif')
--BEGIN
--	INSERT INTO sSystemButtons (ButtonType, DesignString, en_US, ButtonIcon )
--	VALUES ('srmOnMenu', 'btn_srmOnMenu_Resources.gif', 'resources', 'icon_globe.gif')
--END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_srmOnMenu_Download.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonType, DesignString, en_US, ButtonIcon )
	VALUES ('srmOnMenu', 'btn_srmOnMenu_Download.gif', 'download', 'icon_package.gif')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_srmOnMenu_Quote.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonType, DesignString, en_US, ButtonIcon )
	VALUES ('srmOnMenu', 'btn_srmOnMenu_Quote.gif', 'quote', 'icon_quote.gif')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_srmOnMenu_Commits.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonType, DesignString, en_US, ButtonIcon )
	VALUES ('srmOnMenu', 'btn_srmOnMenu_Commits.gif', 'commits', 'icon_quote.gif')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_srmOnMenu_Sample.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonType, DesignString, en_US, ButtonIcon )
	VALUES ('srmOnMenu', 'btn_srmOnMenu_Sample.gif', 'sample', 'icon_filegrid.gif')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_srmOnMenu_Calendar.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonType, DesignString, en_US, ButtonIcon )
	VALUES ('srmOnMenu', 'btn_srmOnMenu_Calendar.gif', 'calendar', 'icon_calendar.gif')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_srmOnMenu_Reports.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonType, DesignString, en_US, ButtonIcon )
	VALUES ('srmOnMenu', 'btn_srmOnMenu_Reports.gif', 'reports', 'icon_bookclose.gif')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_srmOnMenu_BatchQ.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonType, DesignString, en_US, ButtonIcon )
	VALUES ('srmOnMenu', 'btn_srmOnMenu_BatchQ.gif', 'batchQ', 'icon_storeF.gif')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_srmOnMenu_PowerGrid.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonType, DesignString, en_US, ButtonIcon )
	VALUES ('srmOnMenu', 'btn_srmOnMenu_PowerGrid.gif', 'power grid', 'icon_powergrid.gif')
END

IF NOT EXISTS(SELECT * FROM sSystemButtons WHERE DesignString = 'btn_srmOnMenu_LogOff.gif')
BEGIN
	INSERT INTO sSystemButtons (ButtonType, DesignString, en_US, ButtonIcon )
	VALUES ('srmOnMenu', 'btn_srmOnMenu_LogOff.gif', 'log off', 'icon_close_1.gif')
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08805', GetDate())
GO
