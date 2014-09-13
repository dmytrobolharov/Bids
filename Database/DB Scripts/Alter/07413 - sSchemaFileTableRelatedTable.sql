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


-----------------------------------------
-- TABLE: sSchemaFileTableRelatedTable --
-----------------------------------------
IF (OBJECT_ID('sSchemaFileTableRelatedTable', 'U') IS NULL)
BEGIN
	CREATE TABLE [dbo].[sSchemaFileTableRelatedTable]
	(
		[RelatedTableID] [uniqueidentifier] NOT NULL,
		[FileID] [uniqueidentifier] NOT NULL,
		[TableID] [uniqueidentifier] NOT NULL,
		[XMLFileName] [nvarchar](256) NOT NULL,
		[ParentIDField] [nvarchar](256) NOT NULL,
		[ChildIDField] [nvarchar](256) NOT NULL,
		CONSTRAINT [PK_sSchemaFileTableRelatedTable] PRIMARY KEY CLUSTERED
		(
			[RelatedTableID] Asc
		) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO


------------------------------------------------
-- INDEX: sSchemaFileTableRelatedTable_FileID --
------------------------------------------------
IF NOT EXISTS 
( 
	SELECT * 
	FROM sys.indexes 
	WHERE name = 'sSchemaFileTableRelatedTable_FileID' AND object_id = OBJECT_ID('sSchemaFileTableRelatedTable')
) 
BEGIN
	CREATE INDEX sSchemaFileTableRelatedTable_FileID ON sSchemaFileTableRelatedTable (FileID)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07413', GetDate())
GO

SET NOCOUNT Off
GO
