-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 05 May 2012                                                                                */
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


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_SchemaFile_BACKUP')
   DROP PROCEDURE spx_SchemaFile_BACKUP
GO


CREATE PROCEDURE spx_SchemaFile_BACKUP
(
	@SchemaOriginalFileName nvarchar(256),
	@SchemaBackUpFileName nvarchar(256),
	@SchemaTempFileName nvarchar(256)
)
AS 

BEGIN

	-- Backup the original FileName.
	UPDATE sSchemaFile SET [FileName] = @SchemaBackUpFileName WHERE [FileName] = @SchemaOriginalFileName

	-- Rename the temp FileName to the original FileName.
	UPDATE sSchemaFile SET [FileName] = @SchemaOriginalFileName WHERE [FileName] = @SchemaTempFileName

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03408', GetDate())
GO

SET NOCOUNT Off
GO
