-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 25 August 2011                                                                             */
-- *                                                                                            */
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
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


IF EXISTS (select * from Information_Schema.COLUMNS where TABLE_NAME = N'dColumnDataType' and COLUMN_NAME = N'ColumnDataTypeLength')
BEGIN
	-- Remove the ColumnDataTypeLength.
	ALTER TABLE dColumnDataType DROP CONSTRAINT [DF_dColumnDataType_ColumnDataTypeLength]
    ALTER TABLE dColumnDataType DROP COLUMN ColumnDataTypeLength


	-- Add a new record for 'string'.
	DECLARE @NewStringGUID UNIQUEIDENTIFIER
	SET @NewStringGUID = '35E942E6-51B9-4a79-8D6C-55574DA71614'

	IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string'))
	BEGIN
		INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, CUser, CDate, MUser, MDate)
		VALUES (@NewStringGUID, 'string', 'administrator', getutcdate(), 'administrator', getutcdate())
	END


	-- Point any records in the dDataDictionary to the new GUID 
	-- that were pointing to data types that started with 'string('.
	CREATE TABLE [#tempColumnDataType] ( 
		[RecID]	int IDENTITY(1,1) NOT NULL,
		[ColumnDataTypeID] [uniqueidentifier] ROWGUIDCOL NOT NULL,
		[ColumnDataTypeName] [nvarchar](50) NOT NULL
	)

	DECLARE @RowIndex int
	DECLARE @RowCount int
	DECLARE @tmpColumnDataTypeID uniqueidentifier

	BEGIN
		INSERT INTO #tempColumnDataType (ColumnDataTypeID, ColumnDataTypeName)
		SELECT ColumnDataTypeID, ColumnDataTypeName
		FROM dColumnDataType WITH (NOLOCK) 
		WHERE ColumnDataTypeName LIKE 'string(%'
	END

	SET @RowIndex = 1
	SET @RowCount = (SELECT COUNT(*) FROM #tempColumnDataType)

	WHILE @RowIndex <= @RowCount 
	BEGIN

		SELECT @tmpColumnDataTypeID = ColumnDataTypeID FROM #tempColumnDataType WHERE RecID = @RowIndex

		UPDATE dDataDictionary SET ColumnDataTypeID = @NewStringGUID WHERE ColumnDataTypeID = @tmpColumnDataTypeID

		DELETE FROM dColumnDataType WHERE ColumnDataTypeID = @tmpColumnDataTypeID

		SET @RowIndex = @RowIndex + 1
	
	END

END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01790', GetDate())
GO

SET NOCOUNT Off
GO
