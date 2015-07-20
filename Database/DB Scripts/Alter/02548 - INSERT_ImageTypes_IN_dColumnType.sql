-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 9 January 2012                                                                             */
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


DECLARE @BWImageButtonCount int

SELECT @BWImageButtonCount = COUNT(ColumnTypeName)
FROM dColumnType
WHERE UPPER(ColumnTypeName) = UPPER('bwimagebutton')

IF @BWImageButtonCount < 1
BEGIN
	DECLARE @ColumnType_BWImageButton UNIQUEIDENTIFIER
	SET @ColumnType_BWImageButton = CAST('2E7FE61E-D79C-4120-A9E1-A3AC19E69C2E' AS UNIQUEIDENTIFIER)

	INSERT INTO dColumnType (ColumnTypeID, ColumnTypeName, CUser, CDate, MUser, MDate) VALUES (@ColumnType_BWImageButton, 'bwimagebutton', 'administrator', getdate(), 'administrator', getdate())

	-- Get IDs from the dColumnDataType table.
	DECLARE @ColumnDataType_Guid UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Guid = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('guid')

	DECLARE @ColumnDataType_String UNIQUEIDENTIFIER
	SELECT @ColumnDataType_String = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string')

	-- guid
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_BWImageButton, @ColumnDataType_Guid, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_BWImageButton, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())
END
GO


DECLARE @StaticImageCount int

SELECT @StaticImageCount = COUNT(ColumnTypeName)
FROM dColumnType
WHERE UPPER(ColumnTypeName) = UPPER('staticimage')

IF @StaticImageCount < 1
BEGIN
	DECLARE @ColumnType_StaticImage UNIQUEIDENTIFIER
	SET @ColumnType_StaticImage = CAST('0B0747DA-92FC-4e78-96D0-8594A9263285' AS UNIQUEIDENTIFIER)

	INSERT INTO dColumnType (ColumnTypeID, ColumnTypeName, CUser, CDate, MUser, MDate) VALUES (@ColumnType_StaticImage, 'staticimage', 'administrator', getdate(), 'administrator', getdate())

	-- Get IDs from the dColumnDataType table.
	DECLARE @ColumnDataType_Guid UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Guid = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('guid')

	DECLARE @ColumnDataType_String UNIQUEIDENTIFIER
	SELECT @ColumnDataType_String = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string')

	-- guid
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_StaticImage, @ColumnDataType_Guid, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_StaticImage, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.2.0000', '02548', GetDate())
GO

SET NOCOUNT Off
GO
