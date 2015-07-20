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

-----------------------------------
-- TABLE: sSchemaFileTableColumn --
-----------------------------------
IF (OBJECT_ID('sSchemaFileTableColumn', 'U') IS NULL)
BEGIN
	CREATE TABLE [dbo].[sSchemaFileTableColumn]
	(
		[ColumnID] [uniqueidentifier] NOT NULL,
		[FileID] [uniqueidentifier] NOT NULL,
		[TableID] [uniqueidentifier] NOT NULL,
		[Name] [nvarchar](255) NOT NULL,
		[column] [nvarchar](max) NULL,
		[Order] [nvarchar](max) NULL,
		[alias] [nvarchar](max) NULL,
		[DDLinkID] [uniqueidentifier] NOT NULL,
		CONSTRAINT [PK_sSchemaFileTableColumn] PRIMARY KEY CLUSTERED
		(
			[ColumnID] Asc
		) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
ELSE
BEGIN
	ALTER TABLE sSchemaFileTableColumn ALTER COLUMN [Name] NVARCHAR(255) NULL
END
GO



----------------------
-- COLUMN: DDLinkID --
----------------------
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE [name] = (N'DF_sSchemaFileTableColumn_DDLinkID') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sSchemaFileTableColumn] DROP CONSTRAINT [DF_sSchemaFileTableColumn_DDLinkID]
END
GO

IF NOT EXISTS
(
	SELECT * 
	FROM INFORMATION_SCHEMA.COLUMNS	
	WHERE TABLE_NAME = 'sSchemaFileTableColumn'	
	AND COLUMN_NAME = 'DDLinkID'
)
BEGIN
	ALTER TABLE [dbo].[sSchemaFileTableColumn] ADD [DDLinkID] uniqueidentifier NULL
END
ELSE
BEGIN
	IF NOT EXISTS
	(
		SELECT *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = 'sSchemaFileTableColumn'
		AND COLUMN_NAME = 'DDLinkID'
		AND DATA_TYPE = 'uniqueidentifier'
	)
	BEGIN
		ALTER TABLE [dbo].[sSchemaFileTableColumn] DROP COLUMN [DDLinkID]
		ALTER TABLE [dbo].[sSchemaFileTableColumn] ADD [DDLinkID] uniqueidentifier NULL
	END
END
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE [name] = (N'DF_sSchemaFileTableColumn_DDLinkID') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[sSchemaFileTableColumn] ADD CONSTRAINT [DF_sSchemaFileTableColumn_DDLinkID] DEFAULT (CAST(CAST(0 as BINARY) as UNIQUEIDENTIFIER)) FOR [DDLinkID]
END
GO

UPDATE sSchemaFileTableColumn
SET DDLinkID = CAST(CAST(0 as BINARY) as UNIQUEIDENTIFIER)
WHERE LEN(DDLinkID) = 0 OR DDLinkID IS NULL
GO

ALTER TABLE [dbo].[sSchemaFileTableColumn] ALTER COLUMN [DDLinkID] uniqueidentifier NOT NULL
GO


------------------------------------------
-- INDEX: sSchemaFileTableColumn_FileID --
------------------------------------------
IF NOT EXISTS 
( 
	SELECT * 
	FROM sys.indexes 
	WHERE name = 'sSchemaFileTableColumn_FileID' AND object_id = OBJECT_ID('sSchemaFileTableColumn')
) 
BEGIN
	CREATE INDEX sSchemaFileTableColumn_FileID ON sSchemaFileTableColumn (FileID)
END
GO


----------------------------------------
-- INDEX: sSchemaFileTableColumn_Name --
----------------------------------------
IF NOT EXISTS 
( 
	SELECT * 
	FROM sys.indexes 
	WHERE name = 'sSchemaFileTableColumn_Name' AND object_id = OBJECT_ID('sSchemaFileTableColumn')
) 
BEGIN
	CREATE INDEX sSchemaFileTableColumn_Name ON sSchemaFileTableColumn (Name)
END
GO


--------------------------------------------
-- INDEX: sSchemaFileTableColumn_DDLinkID --
--------------------------------------------
IF NOT EXISTS 
( 
	SELECT * 
	FROM sys.indexes 
	WHERE name = 'sSchemaFileTableColumn_DDLinkID' AND object_id = OBJECT_ID('sSchemaFileTableColumn')
) 
BEGIN
	CREATE INDEX sSchemaFileTableColumn_DDLinkID ON sSchemaFileTableColumn (DDLinkID)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07410', GetDate())
GO

SET NOCOUNT Off
GO
