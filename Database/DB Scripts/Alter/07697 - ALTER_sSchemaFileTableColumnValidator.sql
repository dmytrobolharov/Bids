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

--------------------------------------------
-- TABLE: sSchemaFileTableColumnValidator --
--------------------------------------------
IF (OBJECT_ID('sSchemaFileTableColumnValidator', 'U') IS NOT NULL)
BEGIN
	DROP TABLE [dbo].[sSchemaFileTableColumnValidator]
END
GO

IF (OBJECT_ID('sSchemaFileTableColumnValidator', 'U') IS NULL)
BEGIN
	CREATE TABLE [dbo].[sSchemaFileTableColumnValidator]
	(
		[ValidatorID] [uniqueidentifier] NOT NULL,
		[FileID] [uniqueidentifier] NOT NULL,
		[TableID] [uniqueidentifier] NOT NULL,
		[ColumnID] [uniqueidentifier] NOT NULL,
		[Class] [nvarchar](max) NULL,
		[Type] [nvarchar](max) NULL,
		[Minimum] [nvarchar](max) NULL,
		[Maximum] [nvarchar](max) NULL,
		[Text] [nvarchar](max) NULL,
		[Dataformat] [nvarchar](max) NULL,
		[ValidationExpression] [nvarchar](max) NULL,
		CONSTRAINT [PK_sSchemaFileTableColumnValidator] PRIMARY KEY CLUSTERED
		(
			[ValidatorID] Asc
		) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO


---------------------------------------------------
-- INDEX: sSchemaFileTableColumnValidator_FileID --
---------------------------------------------------
IF NOT EXISTS 
( 
	SELECT * 
	FROM sys.indexes 
	WHERE name = 'sSchemaFileTableColumnValidator_FileID' AND object_id = OBJECT_ID('sSchemaFileTableColumnValidator')
) 
BEGIN
	CREATE INDEX sSchemaFileTableColumnValidator_FileID ON sSchemaFileTableColumnValidator (FileID)
END
GO


---------------------------------------------------
-- INDEX: sSchemaFileTableColumnValidator_ColumnID --
---------------------------------------------------
IF NOT EXISTS 
( 
	SELECT * 
	FROM sys.indexes 
	WHERE name = 'sSchemaFileTableColumnValidator_ColumnID' AND object_id = OBJECT_ID('sSchemaFileTableColumnValidator')
) 
BEGIN
	CREATE INDEX sSchemaFileTableColumnValidator_ColumnID ON sSchemaFileTableColumnValidator (ColumnID)
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07697', GetDate())
GO

SET NOCOUNT Off
GO
