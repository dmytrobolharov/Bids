-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 1 September 2014                                                                           */
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

--dropdownchecklist (9D91C642-0421-4669-B9FC-85950C6F4A1F)
DECLARE @ColumnType_DropdownChecklist UNIQUEIDENTIFIER
--SET @ColumnType_DropdownChecklist = CAST('9D91C642-0421-4669-B9FC-85950C6F4A1F' AS UNIQUEIDENTIFIER)
SELECT @ColumnType_DropdownChecklist = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('dropdownchecklist')

-- Get IDs from the dColumnDataType table.
DECLARE @ColumnDataType_Query UNIQUEIDENTIFIER
SELECT @ColumnDataType_Query = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('query')

-- query
IF (SELECT COUNT(*) FROM dColumnTypeDataType WHERE ColumnTypeID = @ColumnType_DropdownChecklist AND ColumnDataTypeID = @ColumnDataType_Query) = 0
BEGIN
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_DropdownChecklist, @ColumnDataType_Query, 'administrator', getutcdate(), 'administrator', getutcdate())
END
GO


--dropdowncolor (C580171F-4C6B-4ECD-B35D-59EE4E053DA6)
DECLARE @ColumnType_DropdownColor UNIQUEIDENTIFIER
--SET @ColumnType_DropdownColor = CAST('C580171F-4C6B-4ECD-B35D-59EE4E053DA6' AS UNIQUEIDENTIFIER)
SELECT @ColumnType_DropdownColor = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('dropdowncolor')

-- Get IDs from the dColumnDataType table.
DECLARE @ColumnDataType_Query UNIQUEIDENTIFIER
SELECT @ColumnDataType_Query = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('query')

-- query
IF (SELECT COUNT(*) FROM dColumnTypeDataType WHERE ColumnTypeID = @ColumnType_DropdownColor AND ColumnDataTypeID = @ColumnDataType_Query) = 0
BEGIN
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_DropdownColor, @ColumnDataType_Query, 'administrator', getutcdate(), 'administrator', getutcdate())
END
GO


--dropdownlist (9B7E12AE-90AD-47F6-8EDA-45AC9A3AB26B)
DECLARE @ColumnType_DropdownList UNIQUEIDENTIFIER
--SET @ColumnType_DropdownList = CAST('9B7E12AE-90AD-47F6-8EDA-45AC9A3AB26B' AS UNIQUEIDENTIFIER)
SELECT @ColumnType_DropdownList = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('dropdownlist')

-- Get IDs from the dColumnDataType table.
DECLARE @ColumnDataType_Query UNIQUEIDENTIFIER
SELECT @ColumnDataType_Query = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('query')

-- query
IF (SELECT COUNT(*) FROM dColumnTypeDataType WHERE ColumnTypeID = @ColumnType_DropdownList AND ColumnDataTypeID = @ColumnDataType_Query) = 0
BEGIN
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_DropdownList, @ColumnDataType_Query, 'administrator', getutcdate(), 'administrator', getutcdate())
END
GO


--dropdownlistrad (EBEF01CB-3EA1-411E-BFDF-66BE03FF367C)
DECLARE @ColumnType_DropdownListRad UNIQUEIDENTIFIER
--SET @ColumnType_DropdownListRad = CAST('EBEF01CB-3EA1-411E-BFDF-66BE03FF367C' AS UNIQUEIDENTIFIER)
SELECT @ColumnType_DropdownListRad = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('dropdownlistrad')

-- Get IDs from the dColumnDataType table.
DECLARE @ColumnDataType_Query UNIQUEIDENTIFIER
SELECT @ColumnDataType_Query = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('query')

-- query
IF (SELECT COUNT(*) FROM dColumnTypeDataType WHERE ColumnTypeID = @ColumnType_DropdownListRad AND ColumnDataTypeID = @ColumnDataType_Query) = 0
BEGIN
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_DropdownListRad, @ColumnDataType_Query, 'administrator', getutcdate(), 'administrator', getutcdate())
END
GO


--label (997A9067-D740-43AB-875A-363740A8E08D)
DECLARE @ColumnType_Label UNIQUEIDENTIFIER
--SET @ColumnType_Label = CAST('997A9067-D740-43AB-875A-363740A8E08D' AS UNIQUEIDENTIFIER)
SELECT @ColumnType_Label = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('label')

-- Get IDs from the dColumnDataType table.
DECLARE @ColumnDataType_Query UNIQUEIDENTIFIER
SELECT @ColumnDataType_Query = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('query')

-- query
IF (SELECT COUNT(*) FROM dColumnTypeDataType WHERE ColumnTypeID = @ColumnType_Label AND ColumnDataTypeID = @ColumnDataType_Query) = 0
BEGIN
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_Label, @ColumnDataType_Query, 'administrator', getutcdate(), 'administrator', getutcdate())
END
GO


--radiobox (300C4315-BFE3-4123-B292-FF2844D1CEDD) - change boolean to integer
DECLARE @ColumnType_Radiobox UNIQUEIDENTIFIER
--SET @ColumnType_Radiobox = CAST('300C4315-BFE3-4123-B292-FF2844D1CEDD' AS UNIQUEIDENTIFIER)
SELECT @ColumnType_Radiobox = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('radiobox')

-- Get IDs from the dColumnDataType table.
DECLARE @ColumnDataType_Boolean UNIQUEIDENTIFIER
SELECT @ColumnDataType_Boolean = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('boolean')

DECLARE @ColumnDataType_Integer UNIQUEIDENTIFIER
SELECT @ColumnDataType_Integer = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('integer')

-- Update record.
UPDATE dColumnTypeDataType SET ColumnDataTypeID = @ColumnDataType_Integer WHERE ColumnTypeID = @ColumnType_Radiobox AND ColumnDataTypeID = @ColumnDataType_Boolean
GO


--radiobutton (0F712AA1-D9A0-4A83-86BC-EF5908973BA4) - change boolean to integer
DECLARE @ColumnType_Radiobutton UNIQUEIDENTIFIER
--SET @ColumnType_Radiobutton = CAST('0F712AA1-D9A0-4A83-86BC-EF5908973BA4' AS UNIQUEIDENTIFIER)
SELECT @ColumnType_Radiobutton = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('radiobutton')

-- Get IDs from the dColumnDataType table.
DECLARE @ColumnDataType_Boolean UNIQUEIDENTIFIER
SELECT @ColumnDataType_Boolean = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('boolean')

DECLARE @ColumnDataType_Integer UNIQUEIDENTIFIER
SELECT @ColumnDataType_Integer = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('integer')

-- Update record.
UPDATE dColumnTypeDataType SET ColumnDataTypeID = @ColumnDataType_Integer WHERE ColumnTypeID = @ColumnType_Radiobutton AND ColumnDataTypeID = @ColumnDataType_Boolean
GO


--radiolist (B4F98D82-55D0-48C6-9348-C7A8F4DC623C) - change boolean to integer
DECLARE @ColumnType_Radiolist UNIQUEIDENTIFIER
--SET @ColumnType_Radiolist = CAST('B4F98D82-55D0-48C6-9348-C7A8F4DC623C' AS UNIQUEIDENTIFIER)
SELECT @ColumnType_Radiolist = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('radiolist')

-- Get IDs from the dColumnDataType table.
DECLARE @ColumnDataType_Boolean UNIQUEIDENTIFIER
SELECT @ColumnDataType_Boolean = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('boolean')

DECLARE @ColumnDataType_Integer UNIQUEIDENTIFIER
SELECT @ColumnDataType_Integer = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('integer')

-- Update record.
UPDATE dColumnTypeDataType SET ColumnDataTypeID = @ColumnDataType_Integer WHERE ColumnTypeID = @ColumnType_Radiolist AND ColumnDataTypeID = @ColumnDataType_Boolean
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '6.1.0000', '09135', GetUTCDate())
GO

SET NOCOUNT Off
GO
