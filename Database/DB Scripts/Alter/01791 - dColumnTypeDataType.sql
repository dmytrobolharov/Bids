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

IF  EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'dColumnTypeDataType') 
    DROP TABLE dColumnTypeDataType
GO


-- Create the dColumnTypeDataType table.
CREATE TABLE [dbo].[dColumnTypeDataType](
	[ColumnTypeDataTypeID] [uniqueidentifier] ROWGUIDCOL NOT NULL,
	[ColumnTypeID] [uniqueidentifier] NOT NULL,
	[ColumnDataTypeID] [uniqueidentifier] NOT NULL,
	[CUser] [nvarchar](50) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](50) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_dColumnTypeDataType] PRIMARY KEY CLUSTERED 
(
	[ColumnTypeDataTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[dColumnTypeDataType] ADD CONSTRAINT [DF_dColumnTypeDataType_ColumnTypeDataTypeID] DEFAULT (newid()) FOR [ColumnTypeDataTypeID]
GO


-- Get IDs from the dColumnType table.
DECLARE @ColumnType_AttributeBox UNIQUEIDENTIFIER
SELECT @ColumnType_AttributeBox = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('attributebox')

DECLARE @ColumnType_CalendarBox UNIQUEIDENTIFIER
SELECT @ColumnType_CalendarBox = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('calendarbox')

DECLARE @ColumnType_CalendarEventBox UNIQUEIDENTIFIER
SELECT @ColumnType_CalendarEventBox = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('calendareventbox')

DECLARE @ColumnType_CalendarRangeBox UNIQUEIDENTIFIER
SELECT @ColumnType_CalendarRangeBox = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('calendarrangebox')

DECLARE @ColumnType_CheckBox UNIQUEIDENTIFIER
SELECT @ColumnType_CheckBox = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('checkbox')

DECLARE @ColumnType_ColorBox UNIQUEIDENTIFIER
SELECT @ColumnType_ColorBox = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('colorbox')

DECLARE @ColumnType_ColorImage UNIQUEIDENTIFIER
SELECT @ColumnType_ColorImage = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('colorimage')

DECLARE @ColumnType_ContentBox UNIQUEIDENTIFIER
SELECT @ColumnType_ContentBox = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('contentbox')

DECLARE @ColumnType_CurrencyBox UNIQUEIDENTIFIER
SELECT @ColumnType_CurrencyBox = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('currencybox')

DECLARE @ColumnType_DropdownColor UNIQUEIDENTIFIER
SELECT @ColumnType_DropdownColor = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('dropdowncolor')

DECLARE @ColumnType_DropdownList UNIQUEIDENTIFIER
SELECT @ColumnType_DropdownList = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('dropdownlist')

DECLARE @ColumnType_HiddenBox UNIQUEIDENTIFIER
SELECT @ColumnType_HiddenBox = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('hiddenbox')

DECLARE @ColumnType_IdBox UNIQUEIDENTIFIER
SELECT @ColumnType_IdBox = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('idbox')

DECLARE @ColumnType_Image UNIQUEIDENTIFIER
SELECT @ColumnType_Image = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('image')

DECLARE @ColumnType_Label UNIQUEIDENTIFIER
SELECT @ColumnType_Label = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('label')

DECLARE @ColumnType_MaterialImage UNIQUEIDENTIFIER
SELECT @ColumnType_MaterialImage = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('materialimage')

DECLARE @ColumnType_MemoBox UNIQUEIDENTIFIER
SELECT @ColumnType_MemoBox = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('memobox')

DECLARE @ColumnType_PercentBox UNIQUEIDENTIFIER
SELECT @ColumnType_PercentBox = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('percentbox')

DECLARE @ColumnType_PlaceHolder UNIQUEIDENTIFIER
SELECT @ColumnType_PlaceHolder = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('placeholder')

DECLARE @ColumnType_PomImage UNIQUEIDENTIFIER
SELECT @ColumnType_PomImage = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('pomimage')

DECLARE @ColumnType_RadioBox UNIQUEIDENTIFIER
SELECT @ColumnType_RadioBox = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('radiobox')

DECLARE @ColumnType_RadioButton UNIQUEIDENTIFIER
SELECT @ColumnType_RadioButton = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('radiobutton')

DECLARE @ColumnType_RadioList UNIQUEIDENTIFIER
SELECT @ColumnType_RadioList = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('radiolist')

DECLARE @ColumnType_StyleImage UNIQUEIDENTIFIER
SELECT @ColumnType_StyleImage = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('styleimage')

DECLARE @ColumnType_System UNIQUEIDENTIFIER
SELECT @ColumnType_System = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('system')

DECLARE @ColumnType_TextBox UNIQUEIDENTIFIER
SELECT @ColumnType_TextBox = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('textbox')

DECLARE @ColumnType_UserBox UNIQUEIDENTIFIER
SELECT @ColumnType_UserBox = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('userbox')

DECLARE @ColumnType_WindowBox UNIQUEIDENTIFIER
SELECT @ColumnType_WindowBox = ColumnTypeID FROM dColumnType WHERE UPPER(ColumnTypeName) = UPPER('windowbox')


-- Get IDs from the dColumnDataType table.
DECLARE @ColumnDataType_BigInt UNIQUEIDENTIFIER
SELECT @ColumnDataType_BigInt = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('bigint')

DECLARE @ColumnDataType_Bit UNIQUEIDENTIFIER
SELECT @ColumnDataType_Bit = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('bit')

DECLARE @ColumnDataType_Boolean UNIQUEIDENTIFIER
SELECT @ColumnDataType_Boolean = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('boolean')

DECLARE @ColumnDataType_DateTime UNIQUEIDENTIFIER
SELECT @ColumnDataType_DateTime = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('datetime')

DECLARE @ColumnDataType_Decimal UNIQUEIDENTIFIER
SELECT @ColumnDataType_Decimal = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('decimal')

DECLARE @ColumnDataType_Float UNIQUEIDENTIFIER
SELECT @ColumnDataType_Float = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('float')

DECLARE @ColumnDataType_Fraction UNIQUEIDENTIFIER
SELECT @ColumnDataType_Fraction = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('fraction')

DECLARE @ColumnDataType_Guid UNIQUEIDENTIFIER
SELECT @ColumnDataType_Guid = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('guid')

DECLARE @ColumnDataType_Image UNIQUEIDENTIFIER
SELECT @ColumnDataType_Image = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('image')

DECLARE @ColumnDataType_Integer UNIQUEIDENTIFIER
SELECT @ColumnDataType_Integer = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('integer')

DECLARE @ColumnDataType_Money UNIQUEIDENTIFIER
SELECT @ColumnDataType_Money = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('money')

DECLARE @ColumnDataType_Numeric UNIQUEIDENTIFIER
SELECT @ColumnDataType_Numeric = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('numeric')

DECLARE @ColumnDataType_Percent UNIQUEIDENTIFIER
SELECT @ColumnDataType_Percent = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('percent')

DECLARE @ColumnDataType_Query UNIQUEIDENTIFIER
SELECT @ColumnDataType_Query = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('query')

DECLARE @ColumnDataType_Real UNIQUEIDENTIFIER
SELECT @ColumnDataType_Real = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('real')

DECLARE @ColumnDataType_SmallDateTime UNIQUEIDENTIFIER
SELECT @ColumnDataType_SmallDateTime = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('smalldatetime')

DECLARE @ColumnDataType_SmallInt UNIQUEIDENTIFIER
SELECT @ColumnDataType_SmallInt = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('smallint')

DECLARE @ColumnDataType_String UNIQUEIDENTIFIER
SELECT @ColumnDataType_String = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string')

DECLARE @ColumnDataType_SystemDate UNIQUEIDENTIFIER
SELECT @ColumnDataType_SystemDate = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('systemdate')

DECLARE @ColumnDataType_SystemString UNIQUEIDENTIFIER
SELECT @ColumnDataType_SystemString = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('systemstring')

DECLARE @ColumnDataType_TinyInt UNIQUEIDENTIFIER
SELECT @ColumnDataType_TinyInt = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('tinyint')

DECLARE @ColumnDataType_VarBinary UNIQUEIDENTIFIER
SELECT @ColumnDataType_VarBinary = ColumnDataTypeID FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('varbinary')


-- attributebox
	-- bigint
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_AttributeBox, @ColumnDataType_BigInt, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- decimal
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_AttributeBox, @ColumnDataType_Decimal, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- float
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_AttributeBox, @ColumnDataType_Float, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- fraction
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_AttributeBox, @ColumnDataType_Fraction, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- integer
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_AttributeBox, @ColumnDataType_Integer, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- money
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_AttributeBox, @ColumnDataType_Money, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- numeric
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_AttributeBox, @ColumnDataType_Numeric, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- percent
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_AttributeBox, @ColumnDataType_Percent, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- real
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_AttributeBox, @ColumnDataType_Real, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- smallint
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_AttributeBox, @ColumnDataType_SmallInt, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_AttributeBox, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- systemstring
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_AttributeBox, @ColumnDataType_SystemString, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- tinyint
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_AttributeBox, @ColumnDataType_TinyInt, 'administrator', getutcdate(), 'administrator', getutcdate())


-- calendarbox
	-- datetime
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_CalendarBox, @ColumnDataType_DateTime, 'administrator', getutcdate(), 'administrator', getutcdate())


-- calendareventbox
	-- datetime
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_CalendarEventBox, @ColumnDataType_DateTime, 'administrator', getutcdate(), 'administrator', getutcdate())


-- calendarrangebox
	-- datetime
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_CalendarRangeBox, @ColumnDataType_DateTime, 'administrator', getutcdate(), 'administrator', getutcdate())


-- checkbox
	-- integer
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_CheckBox, @ColumnDataType_Integer, 'administrator', getutcdate(), 'administrator', getutcdate())


-- colorbox
	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_ColorBox, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())


-- colorimage
	-- guid
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_ColorImage, @ColumnDataType_Guid, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_ColorImage, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())


-- contentbox
	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_ContentBox, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())


-- currencybox
	-- money
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_CurrencyBox, @ColumnDataType_Money, 'administrator', getutcdate(), 'administrator', getutcdate())


-- dropdowncolor
	-- guid
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_DropdownColor, @ColumnDataType_Guid, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_DropdownColor, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())


-- dropdownlist
	-- guid
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_DropdownList, @ColumnDataType_Guid, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_DropdownList, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())


-- hiddenbox
	-- bigint
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_HiddenBox, @ColumnDataType_BigInt, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- datetime
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_HiddenBox, @ColumnDataType_DateTime, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- decimal
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_HiddenBox, @ColumnDataType_Decimal, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- float
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_HiddenBox, @ColumnDataType_Float, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- fraction
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_HiddenBox, @ColumnDataType_Fraction, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- integer
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_HiddenBox, @ColumnDataType_Integer, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- money
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_HiddenBox, @ColumnDataType_Money, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- numeric
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_HiddenBox, @ColumnDataType_Numeric, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- percent
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_HiddenBox, @ColumnDataType_Percent, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- real
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_HiddenBox, @ColumnDataType_Real, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- smalldatetime
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_HiddenBox, @ColumnDataType_SmallDateTime, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- smallint
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_HiddenBox, @ColumnDataType_SmallInt, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_HiddenBox, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- systemdate
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_HiddenBox, @ColumnDataType_SystemDate, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- systemstring
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_HiddenBox, @ColumnDataType_SystemString, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- tinyint
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_HiddenBox, @ColumnDataType_TinyInt, 'administrator', getutcdate(), 'administrator', getutcdate())


-- idbox
	-- guid
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_IdBox, @ColumnDataType_Guid, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_IdBox, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())


-- image
	-- guid
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_Image, @ColumnDataType_Guid, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_Image, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())


-- label
	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_Label, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())


-- materialimage
	-- guid
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_MaterialImage, @ColumnDataType_Guid, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_MaterialImage, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())


-- memobox
	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_MemoBox, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())


-- percentbox
	-- percent
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_PercentBox, @ColumnDataType_Percent, 'administrator', getutcdate(), 'administrator', getutcdate())


-- placeholder
	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_PlaceHolder, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())


-- pomimage
	-- guid
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_PomImage, @ColumnDataType_Guid, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_PomImage, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())


-- radiobox
	-- boolean
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_RadioBox, @ColumnDataType_Boolean, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_RadioBox, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())


-- radiobutton
	-- boolean
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_RadioButton, @ColumnDataType_Boolean, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_RadioButton, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())


-- radiolist
	-- boolean
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_RadioList, @ColumnDataType_Boolean, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_RadioList, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())


-- styleimage
	-- guid
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_StyleImage, @ColumnDataType_Guid, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_StyleImage, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())


-- system
	-- bigint
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_System, @ColumnDataType_BigInt, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- datetime
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_System, @ColumnDataType_DateTime, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- decimal
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_System, @ColumnDataType_Decimal, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- float
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_System, @ColumnDataType_Float, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- fraction
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_System, @ColumnDataType_Fraction, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- integer
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_System, @ColumnDataType_Integer, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- money
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_System, @ColumnDataType_Money, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- numeric
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_System, @ColumnDataType_Numeric, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- percent
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_System, @ColumnDataType_Percent, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- real
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_System, @ColumnDataType_Real, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- smalldatetime
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_System, @ColumnDataType_SmallDateTime, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- smallint
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_System, @ColumnDataType_SmallInt, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_System, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- systemdate
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_System, @ColumnDataType_SystemDate, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- systemstring
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_System, @ColumnDataType_SystemString, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- tinyint
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_System, @ColumnDataType_TinyInt, 'administrator', getutcdate(), 'administrator', getutcdate())


-- textbox
	-- bigint
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextBox, @ColumnDataType_BigInt, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- decimal
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextBox, @ColumnDataType_Decimal, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- float
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextBox, @ColumnDataType_Float, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- fraction
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextBox, @ColumnDataType_Fraction, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- integer
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextBox, @ColumnDataType_Integer, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- money
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextBox, @ColumnDataType_Money, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- numeric
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextBox, @ColumnDataType_Numeric, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- percent
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextBox, @ColumnDataType_Percent, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- real
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextBox, @ColumnDataType_Real, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- smallint
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextBox, @ColumnDataType_SmallInt, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextBox, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- systemstring
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextBox, @ColumnDataType_SystemString, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- tinyint
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_TextBox, @ColumnDataType_TinyInt, 'administrator', getutcdate(), 'administrator', getutcdate())


-- userbox
	-- bigint
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_UserBox, @ColumnDataType_BigInt, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- decimal
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_UserBox, @ColumnDataType_Decimal, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- float
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_UserBox, @ColumnDataType_Float, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- fraction
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_UserBox, @ColumnDataType_Fraction, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- integer
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_UserBox, @ColumnDataType_Integer, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- money
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_UserBox, @ColumnDataType_Money, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- numeric
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_UserBox, @ColumnDataType_Numeric, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- percent
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_UserBox, @ColumnDataType_Percent, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- real
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_UserBox, @ColumnDataType_Real, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- smallint
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_UserBox, @ColumnDataType_SmallInt, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_UserBox, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- systemstring
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_UserBox, @ColumnDataType_SystemString, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- tinyint
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_UserBox, @ColumnDataType_TinyInt, 'administrator', getutcdate(), 'administrator', getutcdate())


-- windowbox
	-- guid
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_WindowBox, @ColumnDataType_Guid, 'administrator', getutcdate(), 'administrator', getutcdate())

	-- string
	INSERT INTO dColumnTypeDataType (ColumnTypeID, ColumnDataTypeID, CUser, CDate, MUser, MDate)
	VALUES (@ColumnType_WindowBox, @ColumnDataType_String, 'administrator', getutcdate(), 'administrator', getutcdate())
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01791', GetDate())
GO

SET NOCOUNT Off
GO
