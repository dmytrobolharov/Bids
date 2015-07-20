-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 07 May 2012                                                                                */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
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

IF EXISTS (select * from sysobjects where id = object_id('spx_SchemaFile_DELETE') and sysstat & 0xf = 4)
    drop procedure spx_SchemaFile_DELETE
GO


CREATE PROCEDURE spx_SchemaFile_DELETE
(
	@SchemaFileName nvarchar(256)
)
AS
BEGIN

	DECLARE @FileID uniqueidentifier
	SELECT @FileID = FileID FROM sSchemaFile WHERE FileName = @SchemaFileName

	DELETE FROM sSchemaFileTableColumnValidator WHERE FileID = @FileID
	DELETE FROM sSchemaFileTableColumn WHERE FileID = @FileID
	DELETE FROM sSchemaFileTable WHERE FileID = @FileID
	DELETE FROM sSchemaFile WHERE FileID = @FileID

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03412', GetDate())
GO

SET NOCOUNT Off
GO
