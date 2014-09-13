-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 17 May 2012                                                                                */
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

UPDATE sSystemButtons
SET ButtonIcon = 'icon_autoFormat2.gif'
WHERE DesignString = 'btn_autofit.gif'
GO


UPDATE sSystemButtons
SET ButtonIcon = 'icon_autoFormat2.gif'
WHERE DesignString = 'btn_comments.gif'
GO


UPDATE sSystemButtons
SET ButtonIcon = 'icon_save_close.gif'
WHERE DesignString = 'btn_save_close.gif'
GO


UPDATE sSystemButtons
SET ButtonIcon = 'icon_save_new.gif'
WHERE DesignString = 'btn_save_new.gif'
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03499', GetDate())
GO

SET NOCOUNT Off
GO
