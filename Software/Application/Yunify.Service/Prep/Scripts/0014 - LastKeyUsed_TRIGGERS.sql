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


IF (OBJECT_ID('tgx_LastKeyUsed_INSERT', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_LastKeyUsed_INSERT]
END
GO

CREATE TRIGGER [dbo].[tgx_LastKeyUsed_INSERT]
ON [dbo].[LastKeyUsed]
AFTER INSERT 
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [TableName]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('LastKeyUsed'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('LastKeyUsed', @PKFields, 'C')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT LastKeyUsed.*
							FROM LastKeyUsed, inserted
							WHERE LastKeyUsed.TableName = inserted.TableName
							FOR XML PATH('Record'), ROOT('LastKeyUsed'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('LastKeyUsed', @PKFields , @FieldValues, 'C')
		END
	END
END
GO


IF (OBJECT_ID('tgx_LastKeyUsed_UPDATE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_LastKeyUsed_UPDATE]
END
GO

CREATE TRIGGER [dbo].[tgx_LastKeyUsed_UPDATE]
ON [dbo].[LastKeyUsed]
AFTER UPDATE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [TableName]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('LastKeyUsed'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('LastKeyUsed', @PKFields, 'U')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT LastKeyUsed.*
							FROM LastKeyUsed, inserted
							WHERE LastKeyUsed.TableName = inserted.TableName
							FOR XML PATH('Record'), ROOT('LastKeyUsed'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('LastKeyUsed', @PKFields , @FieldValues, 'U')
		END
	END
END
GO


IF (OBJECT_ID('tgx_LastKeyUsed_DELETE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_LastKeyUsed_DELETE]
END
GO

CREATE TRIGGER [dbo].[tgx_LastKeyUsed_DELETE]
ON [dbo].[LastKeyUsed]
AFTER DELETE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [TableName]
					FROM DELETED
					FOR XML PATH('Record'), ROOT('LastKeyUsed'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('LastKeyUsed', @PKFields, 'D')

		DECLARE @FieldValues xml
		SET @FieldValues = NULL

		INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
		VALUES ('LastKeyUsed', @PKFields , @FieldValues, 'D')
	END
END
GO

SET NOCOUNT OFF
GO
