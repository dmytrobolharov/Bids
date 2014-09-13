-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 19 December 20123                                                                          */
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


IF (OBJECT_ID('sSchemaFile', 'U') IS NOT NULL)
BEGIN
	IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS	WHERE UPPER(TABLE_NAME) = 'sSchemaFile'	AND UPPER(COLUMN_NAME) = 'AppType')
	BEGIN
		ALTER TABLE dbo.sSchemaFile ADD AppType int NOT NULL CONSTRAINT DF_sSchemaFile_AppType DEFAULT 0
	END
END
GO


IF (OBJECT_ID('sSchemaFile', 'U') IS NOT NULL)
BEGIN
	IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS	WHERE UPPER(TABLE_NAME) = 'sSchemaFile'	AND UPPER(COLUMN_NAME) = 'IsBackUp')
	BEGIN
		ALTER TABLE dbo.sSchemaFile ADD IsBackUp int NOT NULL CONSTRAINT DF_sSchemaFile_IsBackUp DEFAULT 0
	END
END
GO


IF (OBJECT_ID('sSchemaFile', 'U') IS NOT NULL)
BEGIN
	UPDATE sSchemaFile
	SET AppType = 1
	WHERE Path = 'srmOn'
END
GO


IF (OBJECT_ID('sSchemaFile', 'U') IS NOT NULL)
BEGIN
	UPDATE sSchemaFile
	SET IsBackUp = 1
	WHERE FileName LIKE '%.bak'
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '06865', GetDate())
GO

SET NOCOUNT Off
GO
