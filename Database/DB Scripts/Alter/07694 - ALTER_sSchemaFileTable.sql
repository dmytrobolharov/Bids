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

-----------------------------
-- TABLE: sSchemaFileTable --
-----------------------------
IF (OBJECT_ID('sSchemaFileTable', 'U') IS NOT NULL)
BEGIN
	DROP TABLE [dbo].[sSchemaFileTable]
END
GO

IF (OBJECT_ID('sSchemaFileTable', 'U') IS NULL)
BEGIN
	CREATE TABLE [dbo].[sSchemaFileTable]
	(
		[TableID] [uniqueidentifier] NOT NULL,
		[FileID] [uniqueidentifier] NOT NULL,
		[Name] [nvarchar](256) NOT NULL,
		[formcolumns] [nvarchar](MAX) NULL,
		[FormSQL] [nvarchar](MAX) NULL,
		[GridReadSQL] [nvarchar](MAX) NULL,
		[GridSQL] [nvarchar](MAX) NULL,
		[ApiSQL] [nvarchar](MAX) NULL,
		[muiSections] [nvarchar](MAX) NULL,
		[UseRadGrid] [nvarchar](MAX) NULL,
		[PageSize] [nvarchar](MAX) NULL,
		[GridHeight] [nvarchar](MAX) NULL,
		[ViewMode] [nvarchar](MAX) NULL,
		[SaveMode] [nvarchar](MAX) NULL,
		[AutoSizeInReadMode] [nvarchar](MAX) NULL,
		[AllowColumnReordering] [nvarchar](MAX) NULL,
		[AllowGrouping] [nvarchar](MAX) NULL,
		[ShowGroupFooter] [nvarchar](MAX) NULL,
		[AllowSorting] [nvarchar](MAX) NULL,
		[AllowMultiColumnSorting] [nvarchar](MAX) NULL,
		[FrozenColumnCount] [nvarchar](MAX) NULL,
		[AllowKeyboardSupport] [nvarchar](MAX) NULL,
		[AllowPaging] [nvarchar](MAX) NULL,
		[AllowFiltering] [nvarchar](MAX) NULL,
		[AllowScrolling] [nvarchar](MAX) NULL,
		[AllowRowDraggingReadMode] [nvarchar](MAX) NULL,
		[AllowRowDraggingEditMode] [nvarchar](MAX) NULL,
		[AllowRowSelect] [nvarchar](MAX) NULL,
		[AllowMultiRowSelect] [nvarchar](MAX) NULL,
		[AddCheckboxRowSelectColumnReadMode] [nvarchar](MAX) NULL,
		[AddCheckboxRowSelectColumnEditMode] [nvarchar](MAX) NULL,
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


------------------
-- Default Data --
------------------
IF NOT EXISTS 
( 
	SELECT * 
	FROM sSchemaFileTable
	WHERE TableID = '00000000-0000-0000-0000-000000000000'
) 
BEGIN
	INSERT INTO sSchemaFileTable
	([TableID]
	,[FileID]
	,[Name]
	,[formcolumns]
	,[FormSQL]
	,[GridReadSQL]
	,[GridSQL]
	,[ApiSQL]
	,[muiSections]
	,[UseRadGrid]
	,[PageSize]
	,[GridHeight]
	,[ViewMode]
	,[SaveMode]
	,[AutoSizeInReadMode]
	,[AllowColumnReordering]
	,[AllowGrouping]
	,[ShowGroupFooter]
	,[AllowSorting]
	,[AllowMultiColumnSorting]
	,[FrozenColumnCount]
	,[AllowKeyboardSupport]
	,[AllowPaging]
	,[AllowFiltering]
	,[AllowScrolling]
	,[AllowRowDraggingReadMode]
	,[AllowRowDraggingEditMode]
	,[AllowRowSelect]
	,[AllowMultiRowSelect]
	,[AddCheckboxRowSelectColumnReadMode]
	,[AddCheckboxRowSelectColumnEditMode])
	VALUES
	('00000000-0000-0000-0000-000000000000'
	,'00000000-0000-0000-0000-000000000000'
	,'sys.columns'
	,'3'
	,'SELECT * FROM sys.columns'
	,'SELECT * FROM sys.columns'
	,'SELECT * FROM sys.columns'
	,'SELECT * FROM sys.columns'
	,'Misc Details'
	,'false'
	,'10'
	,'400'
	,'ByRow'
	,'ByPage'
	,'false'
	,'false'
	,'false'
	,'false'
	,'false'
	,'false'
	,'0'
	,'false'
	,'false'
	,'false'
	,'false'
	,'false'
	,'false'
	,'false'
	,'false'
	,'false'
	,'false')
END
GO


IF NOT EXISTS 
( 
	SELECT * 
	FROM sSchemaFileTable
	WHERE TableID = '00000000-0000-0000-0000-000000000001'
) 
BEGIN
	INSERT INTO sSchemaFileTable
	([TableID]
	,[FileID]
	,[Name]
	,[formcolumns]
	,[FormSQL]
	,[GridReadSQL]
	,[GridSQL]
	,[ApiSQL]
	,[muiSections]
	,[UseRadGrid]
	,[PageSize]
	,[GridHeight]
	,[ViewMode]
	,[SaveMode]
	,[AutoSizeInReadMode]
	,[AllowColumnReordering]
	,[AllowGrouping]
	,[ShowGroupFooter]
	,[AllowSorting]
	,[AllowMultiColumnSorting]
	,[FrozenColumnCount]
	,[AllowKeyboardSupport]
	,[AllowPaging]
	,[AllowFiltering]
	,[AllowScrolling]
	,[AllowRowDraggingReadMode]
	,[AllowRowDraggingEditMode]
	,[AllowRowSelect]
	,[AllowMultiRowSelect]
	,[AddCheckboxRowSelectColumnReadMode]
	,[AddCheckboxRowSelectColumnEditMode])
	VALUES
	('00000000-0000-0000-0000-000000000001'
	,'00000000-0000-0000-0000-000000000001'
	,'sys.columns'
	,'3'
	,'SELECT * FROM sys.columns'
	,'SELECT * FROM sys.columns'
	,'SELECT * FROM sys.columns'
	,'SELECT * FROM sys.columns'
	,'Misc Details'
	,'false'
	,'10'
	,'400'
	,'ByRow'
	,'ByPage'
	,'false'
	,'false'
	,'false'
	,'false'
	,'false'
	,'false'
	,'0'
	,'false'
	,'false'
	,'false'
	,'false'
	,'false'
	,'false'
	,'false'
	,'false'
	,'false'
	,'false')
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07694', GetDate())
GO

SET NOCOUNT Off
GO
