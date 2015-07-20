-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 20 May 2014                                                                                */
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

----------------------------------------------
-- TABLE: sSchemaFileTableColumnLookupTable --
----------------------------------------------
IF (OBJECT_ID('sSchemaFileTableColumnLookupTable', 'U') IS NOT NULL)
BEGIN
	DROP TABLE [dbo].[sSchemaFileTableColumnLookupTable]
END
GO

IF (OBJECT_ID('sSchemaFileTableColumnLookupTable', 'U') IS NULL)
BEGIN
	CREATE TABLE [dbo].[sSchemaFileTableColumnLookupTable]
	(
		[LookupTableID] [uniqueidentifier] NOT NULL,
		[FileID] [uniqueidentifier] NOT NULL,
		[TableID] [uniqueidentifier] NOT NULL,
		[ColumnID] [uniqueidentifier] NOT NULL,
		[XMLFileName] [nvarchar](256) NOT NULL,
		[ParentIDField] [nvarchar](256) NOT NULL,
		[ChildIDField] [nvarchar](256) NOT NULL,
		CONSTRAINT [PK_sSchemaFileTableColumnLookupTable] PRIMARY KEY CLUSTERED
		(
			[LookupTableID] Asc
		) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO


-----------------------------------------------------
-- INDEX: sSchemaFileTableColumnLookupTable_FileID --
-----------------------------------------------------
IF NOT EXISTS 
( 
	SELECT * 
	FROM sys.indexes 
	WHERE name = 'sSchemaFileTableColumnLookupTable_FileID' AND object_id = OBJECT_ID('sSchemaFileTableColumnLookupTable')
) 
BEGIN
	CREATE INDEX sSchemaFileTableColumnLookupTable_FileID ON sSchemaFileTableColumnLookupTable (FileID)
END
GO


-------------------------------------------------------
-- INDEX: sSchemaFileTableColumnLookupTable_ColumnID --
-------------------------------------------------------
IF NOT EXISTS 
( 
	SELECT * 
	FROM sys.indexes 
	WHERE name = 'sSchemaFileTableColumnLookupTable_ColumnID' AND object_id = OBJECT_ID('sSchemaFileTableColumnLookupTable')
) 
BEGIN
	CREATE INDEX sSchemaFileTableColumnLookupTable_ColumnID ON sSchemaFileTableColumnLookupTable (ColumnID)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07696', GetDate())
GO

SET NOCOUNT Off
GO
