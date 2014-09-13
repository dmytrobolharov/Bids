-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 5 April 2012                                                                               */
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


--calendarboxrad
DECLARE @CalendarboxRadCount int

SELECT @CalendarboxRadCount = COUNT(ColumnTypeName)
FROM dColumnType
WHERE UPPER(ColumnTypeName) = UPPER('calendarboxrad')

IF @CalendarboxRadCount < 1
BEGIN
	DECLARE @ColumnType_CalendarboxRad UNIQUEIDENTIFIER
	SET @ColumnType_CalendarboxRad = CAST('3A29BAF3-6EB6-40bf-A4F8-D6A218758D27' AS UNIQUEIDENTIFIER)

	INSERT INTO dColumnType (ColumnTypeID, ColumnTypeName, CUser, CDate, MUser, MDate) VALUES (@ColumnType_CalendarboxRad, 'calendarboxrad', 'administrator', getdate(), 'administrator', getdate())

	-- Get IDs from the dColumnDataType table.
	DECLARE @ColumnDataType_DateTime UNIQUEIDENTIFIER
	SELECT @ColumnDataType_DateTime = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('datetime')

	-- datetime
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_CalendarboxRad, @ColumnDataType_DateTime, 'administrator', getutcdate(), 'administrator', getutcdate())
END
GO


--dropdownchecklist
DECLARE @DropdownChecklistCount int

SELECT @DropdownChecklistCount = COUNT(ColumnTypeName)
FROM dColumnType
WHERE UPPER(ColumnTypeName) = UPPER('dropdownchecklist')

IF @DropdownChecklistCount < 1
BEGIN
	DECLARE @ColumnType_DropdownChecklist UNIQUEIDENTIFIER
	SET @ColumnType_DropdownChecklist = CAST('9D91C642-0421-4669-B9FC-85950C6F4A1F' AS UNIQUEIDENTIFIER)

	INSERT INTO dColumnType (ColumnTypeID, ColumnTypeName, CUser, CDate, MUser, MDate) VALUES (@ColumnType_DropdownChecklist, 'dropdownchecklist', 'administrator', getdate(), 'administrator', getdate())

	-- Get IDs from the dColumnDataType table.
	DECLARE @ColumnDataType_Guid UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Guid = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('guid')

	DECLARE @ColumnDataType_String UNIQUEIDENTIFIER
	SELECT @ColumnDataType_String = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string')

	-- guid
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_DropdownChecklist, @ColumnDataType_Guid, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_DropdownChecklist, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())
END
GO


--dropdownlistrad
DECLARE @DropdownListRadCount int

SELECT @DropdownListRadCount = COUNT(ColumnTypeName)
FROM dColumnType
WHERE UPPER(ColumnTypeName) = UPPER('dropdownlistrad')

IF @DropdownListRadCount < 1
BEGIN
	DECLARE @ColumnType_DropdownListRad UNIQUEIDENTIFIER
	SET @ColumnType_DropdownListRad = CAST('EBEF01CB-3EA1-411e-BFDF-66BE03FF367C' AS UNIQUEIDENTIFIER)

	INSERT INTO dColumnType (ColumnTypeID, ColumnTypeName, CUser, CDate, MUser, MDate) VALUES (@ColumnType_DropdownListRad, 'dropdownlistrad', 'administrator', getdate(), 'administrator', getdate())

	-- Get IDs from the dColumnDataType table.
	DECLARE @ColumnDataType_Guid UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Guid = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('guid')

	DECLARE @ColumnDataType_String UNIQUEIDENTIFIER
	SELECT @ColumnDataType_String = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string')

	-- guid
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_DropdownListRad, @ColumnDataType_Guid, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_DropdownListRad, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())
END
GO


--MaskedTextboxRad
DECLARE @MaskedTextboxRadCount int

SELECT @MaskedTextboxRadCount = COUNT(ColumnTypeName)
FROM dColumnType
WHERE UPPER(ColumnTypeName) = UPPER('MaskedTextboxRad')

IF @MaskedTextboxRadCount < 1
BEGIN
	DECLARE @ColumnType_MaskedTextboxRad UNIQUEIDENTIFIER
	SET @ColumnType_MaskedTextboxRad = CAST('D6CEA641-F16E-424e-AB60-DAC1C403AAF2' AS UNIQUEIDENTIFIER)

	INSERT INTO dColumnType (ColumnTypeID, ColumnTypeName, CUser, CDate, MUser, MDate) VALUES (@ColumnType_MaskedTextboxRad, 'maskedtextboxrad', 'administrator', getdate(), 'administrator', getdate())

	-- Get IDs from the dColumnDataType table.
	DECLARE @ColumnDataType_BigInt UNIQUEIDENTIFIER
	SELECT @ColumnDataType_BigInt = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('bigint')

	DECLARE @ColumnDataType_Decimal UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Decimal = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('decimal')

	DECLARE @ColumnDataType_Float UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Float = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('float')

	DECLARE @ColumnDataType_Fraction UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Fraction = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('fraction')

	DECLARE @ColumnDataType_Integer UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Integer = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('integer')

	DECLARE @ColumnDataType_Money UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Money = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('money')

	DECLARE @ColumnDataType_Numeric UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Numeric = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('numeric')

	DECLARE @ColumnDataType_Percent UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Percent = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('percent')

	DECLARE @ColumnDataType_Real UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Real = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('real')

	DECLARE @ColumnDataType_SmallInt UNIQUEIDENTIFIER
	SELECT @ColumnDataType_SmallInt = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('smallint')

	DECLARE @ColumnDataType_String UNIQUEIDENTIFIER
	SELECT @ColumnDataType_String = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string')

	DECLARE @ColumnDataType_SystemString UNIQUEIDENTIFIER
	SELECT @ColumnDataType_SystemString = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('systemstring')

	DECLARE @ColumnDataType_TinyInt UNIQUEIDENTIFIER
	SELECT @ColumnDataType_TinyInt = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('tinyint')

	-- bigint
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_MaskedTextboxRad, @ColumnDataType_BigInt, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- decimal
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_MaskedTextboxRad, @ColumnDataType_Decimal, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- float
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_MaskedTextboxRad, @ColumnDataType_Float, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- fraction
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_MaskedTextboxRad, @ColumnDataType_Fraction, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- integer
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_MaskedTextboxRad, @ColumnDataType_Integer, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- money
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_MaskedTextboxRad, @ColumnDataType_Money, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- numeric
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_MaskedTextboxRad, @ColumnDataType_Numeric, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- percent
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_MaskedTextboxRad, @ColumnDataType_Percent, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- real
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_MaskedTextboxRad, @ColumnDataType_Real, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- smallint
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_MaskedTextboxRad, @ColumnDataType_SmallInt, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_MaskedTextboxRad, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- systemstring
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_MaskedTextboxRad, @ColumnDataType_SystemString, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- tinyint
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_MaskedTextboxRad, @ColumnDataType_TinyInt, 'administrator', getutcdate(), 'administrator', getutcdate())
END
GO


--numerictextboxrad
DECLARE @NumericTextboxRadCount int

SELECT @NumericTextboxRadCount = COUNT(ColumnTypeName)
FROM dColumnType
WHERE UPPER(ColumnTypeName) = UPPER('numerictextboxrad')

IF @NumericTextboxRadCount < 1
BEGIN
	DECLARE @ColumnType_NumericTextboxRad UNIQUEIDENTIFIER
	SET @ColumnType_NumericTextboxRad = CAST('BD4389CB-AF5C-46a3-9298-4CA8FE5112C0' AS UNIQUEIDENTIFIER)

	INSERT INTO dColumnType (ColumnTypeID, ColumnTypeName, CUser, CDate, MUser, MDate) VALUES (@ColumnType_NumericTextboxRad, 'numerictextboxrad', 'administrator', getdate(), 'administrator', getdate())

	-- Get IDs from the dColumnDataType table.
	DECLARE @ColumnDataType_BigInt UNIQUEIDENTIFIER
	SELECT @ColumnDataType_BigInt = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('bigint')

	DECLARE @ColumnDataType_Bit UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Bit = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('bit')

	DECLARE @ColumnDataType_Boolean UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Boolean = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('boolean')

	DECLARE @ColumnDataType_Decimal UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Decimal = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('decimal')

	DECLARE @ColumnDataType_Float UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Float = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('float')

	DECLARE @ColumnDataType_Fraction UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Fraction = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('fraction')

	DECLARE @ColumnDataType_Integer UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Integer = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('integer')

	DECLARE @ColumnDataType_Money UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Money = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('money')

	DECLARE @ColumnDataType_Numeric UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Numeric = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('numeric')

	DECLARE @ColumnDataType_Percent UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Percent = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('percent')

	DECLARE @ColumnDataType_Real UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Real = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('real')

	DECLARE @ColumnDataType_SmallInt UNIQUEIDENTIFIER
	SELECT @ColumnDataType_SmallInt = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('smallint')

	DECLARE @ColumnDataType_TinyInt UNIQUEIDENTIFIER
	SELECT @ColumnDataType_TinyInt = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('tinyint')

	--bigint
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_NumericTextboxRad, @ColumnDataType_BigInt, 'administrator', getutcdate(), 'administrator', getutcdate())

    --bit
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_NumericTextboxRad, @ColumnDataType_Bit, 'administrator', getutcdate(), 'administrator', getutcdate())

    --boolean
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_NumericTextboxRad, @ColumnDataType_Boolean, 'administrator', getutcdate(), 'administrator', getutcdate())

    --decimal
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_NumericTextboxRad, @ColumnDataType_Decimal, 'administrator', getutcdate(), 'administrator', getutcdate())

    --float
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_NumericTextboxRad, @ColumnDataType_Float, 'administrator', getutcdate(), 'administrator', getutcdate())

    --fraction
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_NumericTextboxRad, @ColumnDataType_Fraction, 'administrator', getutcdate(), 'administrator', getutcdate())

    --integer
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_NumericTextboxRad, @ColumnDataType_Integer, 'administrator', getutcdate(), 'administrator', getutcdate())

    --money
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_NumericTextboxRad, @ColumnDataType_Money, 'administrator', getutcdate(), 'administrator', getutcdate())

    --numeric
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_NumericTextboxRad, @ColumnDataType_Numeric, 'administrator', getutcdate(), 'administrator', getutcdate())

    --percent
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_NumericTextboxRad, @ColumnDataType_Percent, 'administrator', getutcdate(), 'administrator', getutcdate())

    --real
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_NumericTextboxRad, @ColumnDataType_Real, 'administrator', getutcdate(), 'administrator', getutcdate())

    --smallint
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_NumericTextboxRad, @ColumnDataType_SmallInt, 'administrator', getutcdate(), 'administrator', getutcdate())

    --tinyint
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_NumericTextboxRad, @ColumnDataType_TinyInt, 'administrator', getutcdate(), 'administrator', getutcdate())
END
GO


--textboxrad
DECLARE @TextboxRadCount int

SELECT @TextboxRadCount = COUNT(ColumnTypeName)
FROM dColumnType
WHERE UPPER(ColumnTypeName) = UPPER('textboxrad')

IF @TextboxRadCount < 1
BEGIN
	DECLARE @ColumnType_TextboxRad UNIQUEIDENTIFIER
	SET @ColumnType_TextboxRad = CAST('8DA62BA8-897F-4d57-B8FB-0194E217DC92' AS UNIQUEIDENTIFIER)

	INSERT INTO dColumnType (ColumnTypeID, ColumnTypeName, CUser, CDate, MUser, MDate) VALUES (@ColumnType_TextboxRad, 'textboxrad', 'administrator', getdate(), 'administrator', getdate())

	-- Get IDs from the dColumnDataType table.
	DECLARE @ColumnDataType_BigInt UNIQUEIDENTIFIER
	SELECT @ColumnDataType_BigInt = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('bigint')

	DECLARE @ColumnDataType_Decimal UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Decimal = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('decimal')

	DECLARE @ColumnDataType_Float UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Float = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('float')

	DECLARE @ColumnDataType_Fraction UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Fraction = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('fraction')

	DECLARE @ColumnDataType_Integer UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Integer = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('integer')

	DECLARE @ColumnDataType_Money UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Money = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('money')

	DECLARE @ColumnDataType_Numeric UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Numeric = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('numeric')

	DECLARE @ColumnDataType_Percent UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Percent = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('percent')

	DECLARE @ColumnDataType_Real UNIQUEIDENTIFIER
	SELECT @ColumnDataType_Real = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('real')

	DECLARE @ColumnDataType_SmallInt UNIQUEIDENTIFIER
	SELECT @ColumnDataType_SmallInt = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('smallint')

	DECLARE @ColumnDataType_String UNIQUEIDENTIFIER
	SELECT @ColumnDataType_String = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string')

	DECLARE @ColumnDataType_SystemString UNIQUEIDENTIFIER
	SELECT @ColumnDataType_SystemString = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('systemstring')

	DECLARE @ColumnDataType_TinyInt UNIQUEIDENTIFIER
	SELECT @ColumnDataType_TinyInt = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('tinyint')

	-- bigint
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextboxRad, @ColumnDataType_BigInt, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- decimal
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextboxRad, @ColumnDataType_Decimal, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- float
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextboxRad, @ColumnDataType_Float, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- fraction
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextboxRad, @ColumnDataType_Fraction, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- integer
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextboxRad, @ColumnDataType_Integer, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- money
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextboxRad, @ColumnDataType_Money, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- numeric
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextboxRad, @ColumnDataType_Numeric, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- percent
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextboxRad, @ColumnDataType_Percent, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- real
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextboxRad, @ColumnDataType_Real, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- smallint
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextboxRad, @ColumnDataType_SmallInt, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextboxRad, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- systemstring
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextboxRad, @ColumnDataType_SystemString, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- tinyint
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextboxRad, @ColumnDataType_TinyInt, 'administrator', getutcdate(), 'administrator', getutcdate())
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '5.0.0000', '03322', GetDate())
GO

SET NOCOUNT Off
GO
