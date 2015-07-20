-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 20 August 2012                                                                             */
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

-- DeskRow column
IF NOT EXISTS (SELECT * FROM Information_Schema.COLUMNS WHERE TABLE_NAME = N'sYuniFaceDesktop' and COLUMN_NAME = N'DeskRow')
BEGIN
    ALTER TABLE sYuniFaceDesktop ADD DeskRow int NULL
END
GO  

IF EXISTS (SELECT 1 FROM sys.objects WHERE name = 'DF_sYuniFaceDesktop_DeskRow')
BEGIN
	ALTER TABLE sYuniFaceDesktop DROP CONSTRAINT DF_sYuniFaceDesktop_DeskRow
END
GO

ALTER TABLE sYuniFaceDesktop ADD CONSTRAINT DF_sYuniFaceDesktop_DeskRow DEFAULT 1 FOR DeskRow
GO

UPDATE sYuniFaceDesktop SET DeskRow = 1 WHERE DeskRow IS NULL
GO

ALTER TABLE sYuniFaceDesktop ALTER COLUMN DeskRow int NOT NULL
GO


-- DeskCol column
IF NOT EXISTS (SELECT * FROM Information_Schema.COLUMNS WHERE TABLE_NAME = N'sYuniFaceDesktop' and COLUMN_NAME = N'DeskCol')
BEGIN
    ALTER TABLE sYuniFaceDesktop ADD DeskCol int NULL
END
GO

IF EXISTS (SELECT 1 FROM sys.objects WHERE name = 'DF_sYuniFaceDesktop_DeskCol')
BEGIN
	ALTER TABLE sYuniFaceDesktop DROP CONSTRAINT DF_sYuniFaceDesktop_DeskCol
END
GO

ALTER TABLE sYuniFaceDesktop ADD CONSTRAINT DF_sYuniFaceDesktop_DeskCol DEFAULT 1 FOR DeskCol
GO

UPDATE sYuniFaceDesktop SET DeskCol = 1 WHERE DeskCol IS NULL
GO

ALTER TABLE sYuniFaceDesktop ALTER COLUMN DeskCol int NOT NULL
GO


-- Set the Rows and Cols.

--  1 - 'Home Page'
UPDATE sYuniFaceDeskTop SET DeskRow = 0, DeskCol = 0
WHERE DeskTopID = 1
GO

--100 - 'Log Off'
UPDATE sYuniFaceDeskTop SET DeskRow = 0, DeskCol = 0
WHERE DeskTopID = 100
GO


-- 12 - 'Configure YuniquePLM'
UPDATE sYuniFaceDeskTop SET DeskRow = 1, DeskCol = 1
WHERE DeskTopID = 12
GO

--  2 - 'Config Editor'
UPDATE sYuniFaceDeskTop SET DeskRow = 1, DeskCol = 2
WHERE DeskTopID = 2
GO

--  9 - 'Servers'
UPDATE sYuniFaceDeskTop SET DeskRow = 1, DeskCol = 3
WHERE DeskTopID = 9
GO


-- 10 - 'Table Editor'
UPDATE sYuniFaceDeskTop SET DeskRow = 2, DeskCol = 1
WHERE DeskTopID = 10
GO

--  6 - 'Database Extensions'
UPDATE sYuniFaceDeskTop SET DeskRow = 2, DeskCol = 2
WHERE DeskTopID = 6
GO

--  8 - 'Data Validation'
UPDATE sYuniFaceDeskTop SET DeskRow = 2, DeskCol = 3
WHERE DeskTopID = 8
GO

--  3 - 'Data Dictionary'
UPDATE sYuniFaceDeskTop SET DeskRow = 2, DeskCol = 4
WHERE DeskTopID = 3
GO


--  4 - 'Schema Editor'
UPDATE sYuniFaceDeskTop SET DeskRow = 3, DeskCol = 1
WHERE DeskTopID = 4
GO

-- 11 - 'Spreadsheet Editor'
UPDATE sYuniFaceDeskTop SET DeskRow = 3, DeskCol = 2
WHERE DeskTopID = 11
GO

--  7 - 'Web Service Clients'
UPDATE sYuniFaceDeskTop SET DeskRow = 3, DeskCol = 3
WHERE DeskTopID = 7
GO

-- 13 - 'Hooks'
UPDATE sYuniFaceDeskTop SET DeskRow = 3, DeskCol = 4
WHERE DeskTopID = 13
GO


--  5 - 'Language'
UPDATE sYuniFaceDeskTop SET DeskRow = 4, DeskCol = 1
WHERE DeskTopID = 5
GO

-- 99 - 'Help'
UPDATE sYuniFaceDeskTop SET DeskRow = 4, DeskCol = 2
WHERE DeskTopID = 99
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03786', GetDate())
GO

SET NOCOUNT Off
GO
