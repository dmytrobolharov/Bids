-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 8 October 2014                                                                             */
-- *                                                                                            */
-- * Copyright (c) 2002-2014 Gerber Technology, Inc.  All rights reserved.                      */
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

UPDATE dColumnType
SET Active = 0
WHERE ColumnTypeName IN ( 'calendareventbox', 'calendarrangebox', 'colorbox', 'dropdownchecklist', 'image', 'maskedtextboxrad', 'numerictextboxrad', 'radiobox', 'radiobutton', 'radiolist' )
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '6.0.0000', '09135', GetUTCDate())
GO

SET NOCOUNT Off
GO
