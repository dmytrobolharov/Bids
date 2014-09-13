-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 19 July 2011                                                                               */
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

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(253)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('d2c7fca5-9505-400b-88b9-1f9748251638', 'string(253)', 253, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(254)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('e7751f71-5fe0-4bce-b3ec-6d9ca7ce56ea', 'string(254)', 254, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(156)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('8b34e171-fad4-4cc4-84ef-8eb6dc2f8495', 'string(156)', 156, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(166)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('207334c8-d42a-4468-ba7d-4fca3ae11be2', 'string(166)', 166, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(121)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('0f4b77bb-de16-4c91-8b5b-8bf1148f7cf2', 'string(121)', 121, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(107)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('93c5583a-6ccb-4d61-82d7-d45584a88ff8', 'string(107)', 107, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(26)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('85b4ed81-4fd6-47f8-a74f-a8e041432d42', 'string(26)', 26, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(176)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('268823d9-2bb6-476f-9b6b-07d70fb26429', 'string(176)', 176, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(116)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('7f509215-dbb7-4d55-8565-7e6a40ed377d', 'string(116)', 116, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(162)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('e4a03324-5530-4256-8142-5613530c574d', 'string(162)', 162, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(112)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('d97503b5-ab86-42f9-bb23-82fda862ca7b', 'string(112)', 112, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(78)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('ca74a4ca-3c18-448e-93d3-2f67a80177dc', 'string(78)', 78, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(67)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('2afaee65-373b-4419-a9b6-74530537947a', 'string(67)', 67, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(268)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('2b11dc49-6e7b-4d86-a153-9e086fad0d3b', 'string(268)', 268, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(114)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('df0f5051-df12-4d1b-88b3-b40f59c1a7ea', 'string(114)', 114, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(284)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('37a6f4d6-46ea-4161-a111-5eabe7a2bcb9', 'string(284)', 284, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(101)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('487b826e-42b7-4f45-b5a6-c83aafe10724', 'string(101)', 101, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(22)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('9f2c3d08-e480-4fea-82d2-3a452318a3a2', 'string(22)', 22, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(103)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('e8d001ad-f323-4dd4-b177-8cbccf787bde', 'string(103)', 103, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(403)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('de37c684-f147-4e71-ab65-3c6d13cfab8b', 'string(403)', 403, 'administrator', getutcdate(), 'administrator', getutcdate())
END


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01694', GetDate())
GO

SET NOCOUNT Off
GO
