-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 25 July 2011                                                                               */
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

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('bit'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('f019b709-9877-40a1-b642-ff2552d8045b', 'bit', 0, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(255)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('c580f3fd-5112-446f-9061-5942d2b6ac08', 'string(255)', 255, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(4)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('54542bdc-33d6-4abf-9dc1-c0497f2fd5e7', 'string(4)', 4, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(3)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('9ddceac6-5ed0-4306-b8ab-51a69135be2a', 'string(3)', 3, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(1)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('a22c2dfd-45fb-46f6-9eb2-698b93040d6d', 'string(1)', 1, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(256)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('8525892b-f26d-41b6-9a3b-43c3ed6418b6', 'string(256)', 256, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(128)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('c4997f96-0c08-4136-a8f4-0f58ff233366', 'string(128)', 128, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(16)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('2c6ed114-6ea4-4ce8-b539-49387f792cec', 'string(16)', 16, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(1073741823)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('0ea1fda1-6310-4dc5-b379-2c65d54c52db', 'string(1073741823)', 1073741823, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('image'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('c151eb13-134b-4309-9e4e-5ae005de1683', 'image', 2147483647, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(450)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('9a927281-bb66-4076-ae5b-6d72c7745374', 'string(450)', 450, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(32)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('4ef57292-d912-4b9f-8205-22c270ea2f1f', 'string(32)', 32, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(1024)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('558cca66-4717-4a2c-b55e-cbbcd9f401c8', 'string(1024)', 1024, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(25)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('a1168da3-8a99-4078-ba5a-aaaa36f6b2c2', 'string(25)', 25, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(500)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('0bdf0f9b-30d5-43ac-ad66-ec8459fefd7e', 'string(500)', 500, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(4000)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('e7753223-0583-4dfb-923f-dc053c0331b6', 'string(4000)', 4000, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(150)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('bb77ded0-a030-4ef2-b657-b2d61e593fd1', 'string(150)', 150, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('float'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('d6818e97-216c-4915-b63b-2e4ec56141b8', 'float', 0, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(35)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('f3f4915f-ed4d-4489-924e-3634bf0e598d', 'string(35)', 35, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(8000)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('3ebdfac3-b673-43eb-8db4-723212a40925', 'string(8000)', 8000, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('bigint'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('2d18e174-477d-4b69-bd66-21b3208cfcaf', 'bigint', 0, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(204)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('000c519f-bd99-4109-9968-604b244cff8b', 'string(204)', 204, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('numeric'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('8e27b3d4-5b57-4a18-9fd0-1e492bce11ac', 'numeric', 0, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(60)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('9ce4d3a4-af9f-443a-ac66-1cea5f85f9f5', 'string(60)', 60, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(2147483647)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('16f69ea7-c2c8-4904-bf2f-460470ffc6a7', 'string(2147483647)', 2147483647, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(24)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('0e347af7-572d-4ce2-b9ec-f787034ddd45', 'string(24)', 24, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(12)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('9b52a479-14d8-40fa-94d1-2aee755d71ee', 'string(12)', 12, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(64)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('febe8c17-f3cc-4b2a-b197-d06c23a1a34b', 'string(64)', 64, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(510)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('ed8cad9b-7122-4dca-a0ab-6dd2bb5ea25d', 'string(510)', 510, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(225)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('df42e569-5b41-42dd-b8de-42909ef8b114', 'string(225)', 225, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(9)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('ce773632-c882-40cf-8fdf-ef3a2ea6cbd9', 'string(9)', 9, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(40)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('a1cfd0fb-0fd4-475a-bb40-1250477bb3c3', 'string(40)', 40, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(400)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('9777c82e-21c3-4444-9693-66d1e8fe29fb', 'string(400)', 400, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(18)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('6944b9ee-f9b9-4c6d-ba95-971b0126dbbd', 'string(18)', 18, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(250)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('14dd6288-2df4-457d-a4ef-83e9cb7f69ce', 'string(250)', 250, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(6)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('b52bff21-c1c8-4d54-a086-02ac21a98158', 'string(6)', 6, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(max)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('b3d7f04c-d66c-4fad-97dc-5edef92e6f5f', 'string(max)', -1, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('smallint'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('a676295d-ae8b-43ab-b28d-4828a773059b', 'smallint', 0, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('smalldatetime'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('caece9b7-f0bc-4f27-9da3-a41aa4e9d547', 'smalldatetime', 0, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(7)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('4607d070-40aa-4edb-a658-d0cee9b11566', 'string(7)', 7, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(15)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('d60237bf-a3e1-48cb-bc6d-4c384798a347', 'string(15)', 15, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(300)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('83117661-a90d-460c-948a-2306ea696338', 'string(300)', 300, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(2500)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('951f33e7-a216-4835-bc7d-895b9bff6e71', 'string(2500)', 2500, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('tinyint'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('b2b4e599-1cf7-498d-a18f-3159462c7dc3', 'tinyint', 0, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(30)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('e428307b-3cec-4d6e-a96e-40ccadfb582e', 'string(30)', 30, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('string(512)'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('2b4a29f1-8415-4070-9115-3864377c94c5', 'string(512)', 512, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('real'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('a7e9eaa3-67c9-4fd7-baf1-75946560736e', 'real', 0, 'administrator', getutcdate(), 'administrator', getutcdate())
END

IF NOT EXISTS (SELECT * FROM dColumnDataType WHERE UPPER(ColumnDataTypeName) = UPPER('varbinary'))
BEGIN
	INSERT INTO dColumnDataType (ColumnDataTypeID, ColumnDataTypeName, ColumnDataTypeLength, CUser, CDate, MUser, MDate)
	 VALUES ('8890b24e-43f3-42ed-9a40-fa7da826911c', 'varbinary', -1, 'administrator', getutcdate(), 'administrator', getutcdate())
END


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '01692', GetDate())
GO

SET NOCOUNT Off
GO
