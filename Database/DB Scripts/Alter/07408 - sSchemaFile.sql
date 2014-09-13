-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 03 April 2014                                                                              */
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


------------------------
-- TABLE: sSchemaFile --
------------------------
IF (OBJECT_ID('sSchemaFile', 'U') IS NULL)
BEGIN
	CREATE TABLE [dbo].[sSchemaFile]
	(
		[FileID] [uniqueidentifier] NOT NULL,
		[Path] [nvarchar](512) NOT NULL,
		[FileName] [nvarchar](256) NOT NULL,
		[Report] [xml] NULL,
		[LastModified] [datetime] NOT NULL,
		[AppType] [int] NOT NULL,
		[IsBackUp] [int] NOT NULL,
		CONSTRAINT [PK_sSchemaFile] PRIMARY KEY CLUSTERED
		(
			[FileID] Asc
		) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO


---------------------
-- COLUMN: AppType --
---------------------
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE [name] = (N'DF_sSchemaFile_AppType') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sSchemaFile] DROP CONSTRAINT [DF_sSchemaFile_AppType]
END
GO

IF NOT EXISTS
(
	SELECT * 
	FROM INFORMATION_SCHEMA.COLUMNS	
	WHERE TABLE_NAME = 'sSchemaFile'	
	AND COLUMN_NAME = 'AppType'
)
BEGIN
	ALTER TABLE [dbo].[sSchemaFile] ADD [AppType] int NULL
END
ELSE
BEGIN
	IF NOT EXISTS
	(
		SELECT *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = 'sSchemaFile'
		AND COLUMN_NAME = 'AppType'
		AND DATA_TYPE = 'int'
	)
	BEGIN
		ALTER TABLE [dbo].[sSchemaFile] DROP COLUMN [AppType]
		ALTER TABLE [dbo].[sSchemaFile] ADD [AppType] int NULL
	END
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE [name] = (N'DF_sSchemaFile_AppType') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sSchemaFile] ADD CONSTRAINT [DF_sSchemaFile_AppType] DEFAULT ((0)) FOR [AppType]
END
GO

UPDATE sSchemaFile
SET AppType = 0
WHERE LEN(AppType) = 0 OR AppType IS NULL
GO

ALTER TABLE [dbo].[sSchemaFile] ALTER COLUMN [AppType] int NOT NULL
GO


----------------------
-- COLUMN: IsBackUp --
----------------------
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE [name] = (N'DF_sSchemaFile_IsBackUp') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sSchemaFile] DROP CONSTRAINT [DF_sSchemaFile_IsBackUp]
END
GO

IF NOT EXISTS
(
	SELECT * 
	FROM INFORMATION_SCHEMA.COLUMNS	
	WHERE TABLE_NAME = 'sSchemaFile'	
	AND COLUMN_NAME = 'IsBackUp'
)
BEGIN
	ALTER TABLE [dbo].[sSchemaFile] ADD [IsBackUp] int NULL
END
ELSE
BEGIN
	IF NOT EXISTS
	(
		SELECT *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = 'sSchemaFile'
		AND COLUMN_NAME = 'IsBackUp'
		AND DATA_TYPE = 'int'
	)
	BEGIN
		ALTER TABLE [dbo].[sSchemaFile] DROP COLUMN [IsBackUp]
		ALTER TABLE [dbo].[sSchemaFile] ADD [IsBackUp] int NULL
	END
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE [name] = (N'DF_sSchemaFile_IsBackUp') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sSchemaFile] ADD CONSTRAINT [DF_sSchemaFile_IsBackUp] DEFAULT ((0)) FOR [IsBackUp]
END
GO

UPDATE sSchemaFile
SET IsBackUp = 0
WHERE LEN(IsBackUp) = 0 OR IsBackUp IS NULL
GO

ALTER TABLE [dbo].[sSchemaFile] ALTER COLUMN [IsBackUp] int NOT NULL
GO


---------------------------------
-- INDEX: sSchemaFile_FileName --
---------------------------------
IF NOT EXISTS 
( 
	SELECT * 
	FROM sys.indexes 
	WHERE name = 'sSchemaFile_FileName' AND object_id = OBJECT_ID('sSchemaFile')
) 
BEGIN
	CREATE INDEX sSchemaFile_FileName ON sSchemaFile (FileName ASC)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07408', GetDate())
GO

SET NOCOUNT Off
GO
