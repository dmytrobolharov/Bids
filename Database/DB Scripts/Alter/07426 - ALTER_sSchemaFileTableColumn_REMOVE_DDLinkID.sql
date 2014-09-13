-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 08 April 2014                                                                              */
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
-- INDEX: sSchemaFileTableColumn_DDLinkID --
--------------------------------------------
IF EXISTS 
( 
	SELECT * 
	FROM sys.indexes 
	WHERE name = 'sSchemaFileTableColumn_DDLinkID' AND object_id = OBJECT_ID('sSchemaFileTableColumn')
) 
BEGIN
	DROP INDEX sSchemaFileTableColumn.sSchemaFileTableColumn_DDLinkID
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

IF EXISTS
(
	SELECT * 
	FROM INFORMATION_SCHEMA.COLUMNS	
	WHERE TABLE_NAME = 'sSchemaFileTableColumn'	
	AND COLUMN_NAME = 'DDLinkID'
)
BEGIN
	ALTER TABLE [dbo].[sSchemaFileTableColumn] DROP COLUMN [DDLinkID]
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07426', GetDate())
GO

SET NOCOUNT Off
GO
