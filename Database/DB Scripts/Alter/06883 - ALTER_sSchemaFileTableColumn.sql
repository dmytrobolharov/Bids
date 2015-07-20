-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 09 January 2014                                                                            */
-- *                                                                                            */
-- * Copyright (c) 2002-2013 Gerber Technology, Inc.  All rights reserved.                      */
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

IF (OBJECT_ID('sSchemaFileTableColumn', 'U') IS NOT NULL)
BEGIN
	IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS	WHERE UPPER(TABLE_NAME) = 'sSchemaFileTableColumn'	AND UPPER(COLUMN_NAME) = 'column')
	BEGIN
		ALTER TABLE dbo.sSchemaFileTableColumn ADD [column] nvarchar(max) NULL
	END
END
GO

IF (OBJECT_ID('sSchemaFileTableColumn', 'U') IS NOT NULL)
BEGIN
	IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS	WHERE UPPER(TABLE_NAME) = 'sSchemaFileTableColumn'	AND UPPER(COLUMN_NAME) = 'order')
	BEGIN
		ALTER TABLE dbo.sSchemaFileTableColumn ADD [order] nvarchar(max) NULL
	END
END
GO

IF (OBJECT_ID('sSchemaFileTableColumn', 'U') IS NOT NULL)
BEGIN
	IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS	WHERE UPPER(TABLE_NAME) = 'sSchemaFileTableColumn'	AND UPPER(COLUMN_NAME) = 'alias')
	BEGIN
		ALTER TABLE dbo.sSchemaFileTableColumn ADD [alias] nvarchar(max) NULL
	END
END
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06883', GetDate())
GO

SET NOCOUNT Off
GO
