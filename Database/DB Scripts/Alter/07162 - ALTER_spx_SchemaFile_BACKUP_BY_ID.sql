-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 16 February 2014                                                                           */
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


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_SchemaFile_BACKUP_BY_ID')
   DROP PROCEDURE spx_SchemaFile_BACKUP_BY_ID
GO


CREATE PROCEDURE spx_SchemaFile_BACKUP_BY_ID
(
	@SchemaOriginalFileID uniqueidentifier,
	@SchemaTempFileID uniqueidentifier,
	@SchemaOriginalFileName nvarchar(256),
	@SchemaBackUpFileName nvarchar(256)
)
AS 

BEGIN

	-- Backup the original FileName.
	IF @SchemaOriginalFileID IS NOT NULL
	BEGIN
		IF @SchemaOriginalFileID <> CAST(0x0 AS UNIQUEIDENTIFIER)
		BEGIN
			UPDATE sSchemaFile SET [FileName] = @SchemaBackUpFileName, IsBackUp = 1 WHERE [FileID] = @SchemaOriginalFileID
		END
	END

	-- Rename the temp FileName to the original FileName.
	IF @SchemaTempFileID IS NOT NULL
	BEGIN
		IF @SchemaTempFileID <> CAST(0x0 AS UNIQUEIDENTIFIER)
		BEGIN
			UPDATE sSchemaFile SET [FileName] = @SchemaOriginalFileName WHERE [FileID] = @SchemaTempFileID
		END
	END

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07162', GetDate())
GO

SET NOCOUNT Off
GO
