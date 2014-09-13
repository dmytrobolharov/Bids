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


-----------------------------
-- TABLE: sSchemaFileTable --
-----------------------------
IF (OBJECT_ID('sSchemaFileTable', 'U') IS NULL)
BEGIN
	CREATE TABLE [dbo].[sSchemaFileTable]
	(
		[TableID] [uniqueidentifier] NOT NULL,
		[FileID] [uniqueidentifier] NOT NULL,
		[Name] [nvarchar](256) NOT NULL,
		CONSTRAINT [PK_sSchemaFileTable] PRIMARY KEY CLUSTERED
		(
			[TableID] Asc
		) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO


------------------------------------
-- INDEX: sSchemaFileTable_FileID --
------------------------------------
IF NOT EXISTS 
( 
	SELECT * 
	FROM sys.indexes 
	WHERE name = 'sSchemaFileTable_FileID' AND object_id = OBJECT_ID('sSchemaFileTable')
) 
BEGIN
	CREATE INDEX sSchemaFileTable_FileID ON sSchemaFileTable (FileID)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07409', GetDate())
GO

SET NOCOUNT Off
GO
