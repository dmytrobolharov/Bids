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

IF EXISTS (select * from sysobjects where id = object_id('spx_Schema_FileTableColumns_RESET') and sysstat & 0xf = 4)
    drop procedure spx_Schema_FileTableColumns_RESET
GO


CREATE PROCEDURE spx_Schema_FileTableColumns_RESET
(
    @SchemaFileName NVarChar(256),
    @SchemaFileType nvarchar(1)
)
AS
BEGIN

	DECLARE @FileID uniqueidentifier
	SELECT @FileID = FileID FROM sSchemaFile WHERE FileName = @SchemaFileName


	IF @SchemaFileType = 'g'
	BEGIN

		UPDATE sSchemaFileTableColumn
		SET [COLUMN] = '1'
		WHERE FileID = @FileID
		AND ([COLUMN] IS NULL OR [COLUMN] = '')

		UPDATE sSchemaFileTableColumn
		SET [order] = '000'
		WHERE FileID = @FileID
		AND ([order] IS NULL OR [order] = '')

		UPDATE sSchemaFileTableColumn
		SET Visible = 'false'
		WHERE FileID = @FileID
		AND (Visible IS NULL OR Visible = '')

		UPDATE sSchemaFileTableColumn
		SET [GridOrder] = '000'
		WHERE FileID = @FileID

		UPDATE sSchemaFileTableColumn
		SET GridVisible = 'false'
		WHERE FileID = @FileID

	END

	ELSE
	BEGIN

		UPDATE sSchemaFileTableColumn
		SET [COLUMN] = '1'
		WHERE FileID = @FileID

		UPDATE sSchemaFileTableColumn
		SET [order] = '000'
		WHERE FileID = @FileID

		UPDATE sSchemaFileTableColumn
		SET Visible = 'false'
		WHERE FileID = @FileID

		UPDATE sSchemaFileTableColumn
		SET [GridOrder] = '000'
		WHERE FileID = @FileID
		AND ([GridOrder] IS NULL OR [GridOrder] = '')

		UPDATE sSchemaFileTableColumn
		SET GridVisible = 'false'
		WHERE FileID = @FileID
		AND (GridVisible IS NULL OR GridVisible = '')

	END


	UPDATE sSchemaFileTableColumn
	SET source = 't'
	WHERE FileID = @FileID
	AND (source IS NULL OR source = '')

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03411', GetDate())
GO

SET NOCOUNT Off
GO
