-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 17 June 2015                                                                               */
-- *                                                                                            */
-- * Copyright (c) 2002-2015 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS:
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO


IF (OBJECT_ID('tgx_PPFTable2Image_INSERT', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_PPFTable2Image_INSERT]
END
GO

CREATE TRIGGER [dbo].[tgx_PPFTable2Image_INSERT]
ON [dbo].[PPFTable2Image]
AFTER INSERT 
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [DataTableId], [DTRecordId], [ImagePosInRec], [TableName]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('PPFTable2Image'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('PPFTable2Image', @PKFields, 'C')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT PPFTable2Image.*
							FROM PPFTable2Image, inserted
							WHERE PPFTable2Image.DataTableId = inserted.DataTableId
							AND PPFTable2Image.DTRecordId = inserted.DTRecordId
							AND PPFTable2Image.ImagePosInRec = inserted.ImagePosInRec
							AND PPFTable2Image.TableName = inserted.TableName
							FOR XML PATH('Record'), ROOT('PPFTable2Image'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('PPFTable2Image', @PKFields , @FieldValues, 'C')
		END
	END
END
GO


IF (OBJECT_ID('tgx_PPFTable2Image_UPDATE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_PPFTable2Image_UPDATE]
END
GO

CREATE TRIGGER [dbo].[tgx_PPFTable2Image_UPDATE]
ON [dbo].[PPFTable2Image]
AFTER UPDATE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [DataTableId], [DTRecordId], [ImagePosInRec], [TableName]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('PPFTable2Image'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('PPFTable2Image', @PKFields, 'U')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT PPFTable2Image.*
							FROM PPFTable2Image, inserted
							WHERE PPFTable2Image.DataTableId = inserted.DataTableId
							AND PPFTable2Image.DTRecordId = inserted.DTRecordId
							AND PPFTable2Image.ImagePosInRec = inserted.ImagePosInRec
							AND PPFTable2Image.TableName = inserted.TableName
							FOR XML PATH('Record'), ROOT('PPFTable2Image'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('PPFTable2Image', @PKFields , @FieldValues, 'U')
		END
	END
END
GO


IF (OBJECT_ID('tgx_PPFTable2Image_DELETE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_PPFTable2Image_DELETE]
END
GO

CREATE TRIGGER [dbo].[tgx_PPFTable2Image_DELETE]
ON [dbo].[PPFTable2Image]
AFTER DELETE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [DataTableId], [DTRecordId], [ImagePosInRec], [TableName]
					FROM DELETED
					FOR XML PATH('Record'), ROOT('PPFTable2Image'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('PPFTable2Image', @PKFields, 'D')

		DECLARE @FieldValues xml
		SET @FieldValues = NULL

		INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
		VALUES ('PPFTable2Image', @PKFields , @FieldValues, 'D')
	END
END
GO

SET NOCOUNT OFF
GO
