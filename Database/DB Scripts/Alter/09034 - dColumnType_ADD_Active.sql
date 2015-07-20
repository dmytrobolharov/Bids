-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 1 September 2014                                                                           */
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

IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'dColumnType' AND COLUMN_NAME = 'Active')
BEGIN
	ALTER TABLE dbo.dColumnType ADD Active int NULL
	ALTER TABLE dColumnType ADD CONSTRAINT DF_dColumnType_Active DEFAULT 1 FOR Active
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE name = 'DF_dColumnType_Active')
BEGIN
	ALTER TABLE dColumnType ADD CONSTRAINT DF_dColumnType_Active DEFAULT 1 FOR Active
END
GO

UPDATE dColumnType SET Active = 0
GO

UPDATE dColumnType SET Active = 1
WHERE ColumnTypeName IN ( 'calendarbox', 'calendareventbox', 'calendarrangebox', 'checkbox', 'colorbox', 'currencybox', 'dropdownlist', 'dropdownchecklist', 'image', 'label', 'maskedtextboxrad', 'memobox', 'numerictextboxrad', 'percentbox', 'radiobox', 'radiobutton', 'radiolist', 'textbox' )
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '6.0.0000', '09034', GetUTCDate())
GO

SET NOCOUNT Off
GO
