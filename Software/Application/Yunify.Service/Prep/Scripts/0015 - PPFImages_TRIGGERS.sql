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


IF (OBJECT_ID('tgx_PPFImages_INSERT', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_PPFImages_INSERT]
END
GO

CREATE TRIGGER [dbo].[tgx_PPFImages_INSERT]
ON [dbo].[PPFImages]
AFTER INSERT 
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [ImageSerialNumber]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('PPFImages'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('PPFImages', @PKFields, 'C')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT PPFImages.*
							FROM PPFImages, inserted
							WHERE PPFImages.ImageSerialNumber = inserted.ImageSerialNumber
							FOR XML PATH('Record'), ROOT('PPFImages'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('PPFImages', @PKFields , @FieldValues, 'C')
		END
	END
END
GO


IF (OBJECT_ID('tgx_PPFImages_UPDATE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_PPFImages_UPDATE]
END
GO

CREATE TRIGGER [dbo].[tgx_PPFImages_UPDATE]
ON [dbo].[PPFImages]
AFTER UPDATE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [ImageSerialNumber]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('PPFImages'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('PPFImages', @PKFields, 'U')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT PPFImages.*
							FROM PPFImages, inserted
							WHERE PPFImages.ImageSerialNumber = inserted.ImageSerialNumber
							FOR XML PATH('Record'), ROOT('PPFImages'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('PPFImages', @PKFields , @FieldValues, 'U')
		END
	END
END
GO


IF (OBJECT_ID('tgx_PPFImages_DELETE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_PPFImages_DELETE]
END
GO

CREATE TRIGGER [dbo].[tgx_PPFImages_DELETE]
ON [dbo].[PPFImages]
AFTER DELETE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [ImageSerialNumber]
					FROM DELETED
					FOR XML PATH('Record'), ROOT('PPFImages'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('PPFImages', @PKFields, 'D')

		DECLARE @FieldValues xml
		SET @FieldValues = NULL

		INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
		VALUES ('PPFImages', @PKFields , @FieldValues, 'D')
	END
END
GO

SET NOCOUNT OFF
GO
