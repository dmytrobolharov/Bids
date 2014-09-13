-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 14 February 2014                                                                           */
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


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_SchemaFile_BACKUP')
   DROP PROCEDURE spx_SchemaFile_BACKUP
GO


CREATE PROCEDURE spx_SchemaFile_BACKUP
(
	@SchemaOriginalFileName nvarchar(256),
	@SchemaBackUpFileName nvarchar(256),
	@SchemaTempFileName nvarchar(256),
	@AppType int = 0
)
AS 

BEGIN

	-- Backup the original FileName.
	UPDATE sSchemaFile SET [FileName] = @SchemaBackUpFileName, IsBackUp = 1 WHERE [FileName] = @SchemaOriginalFileName AND [AppType] = @AppType

	-- Rename the temp FileName to the original FileName.
	UPDATE sSchemaFile SET [FileName] = @SchemaOriginalFileName WHERE [FileName] = @SchemaTempFileName AND [AppType] = @AppType

END
GO


IF (OBJECT_ID('sSchemaFile', 'U') IS NOT NULL)
BEGIN
	UPDATE sSchemaFile
	SET IsBackUp = 1
	WHERE FileName LIKE '%.bak'
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '0.5.0000', '07161', GetDate())
GO

SET NOCOUNT Off
GO
