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


IF (OBJECT_ID('tgx_PPFRepresentatives_INSERT', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_PPFRepresentatives_INSERT]
END
GO

CREATE TRIGGER [dbo].[tgx_PPFRepresentatives_INSERT]
ON [dbo].[PPFRepresentatives]
AFTER INSERT 
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [ImageSerialNumber]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('PPFRepresentatives'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('PPFRepresentatives', @PKFields, 'C')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT PPFRepresentatives.*
							FROM PPFRepresentatives, inserted
							WHERE PPFRepresentatives.ImageSerialNumber = inserted.ImageSerialNumber
							FOR XML PATH('Record'), ROOT('PPFRepresentatives'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('PPFRepresentatives', @PKFields , @FieldValues, 'C')
		END
	END
END
GO


IF (OBJECT_ID('tgx_PPFRepresentatives_UPDATE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_PPFRepresentatives_UPDATE]
END
GO

CREATE TRIGGER [dbo].[tgx_PPFRepresentatives_UPDATE]
ON [dbo].[PPFRepresentatives]
AFTER UPDATE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [ImageSerialNumber]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('PPFRepresentatives'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('PPFRepresentatives', @PKFields, 'U')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT PPFRepresentatives.*
							FROM PPFRepresentatives, inserted
							WHERE PPFRepresentatives.ImageSerialNumber = inserted.ImageSerialNumber
							FOR XML PATH('Record'), ROOT('PPFRepresentatives'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('PPFRepresentatives', @PKFields , @FieldValues, 'U')
		END
	END
END
GO


IF (OBJECT_ID('tgx_PPFRepresentatives_DELETE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_PPFRepresentatives_DELETE]
END
GO

CREATE TRIGGER [dbo].[tgx_PPFRepresentatives_DELETE]
ON [dbo].[PPFRepresentatives]
AFTER DELETE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [ImageSerialNumber]
					FROM DELETED
					FOR XML PATH('Record'), ROOT('PPFRepresentatives'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('PPFRepresentatives', @PKFields, 'D')

		DECLARE @FieldValues xml
		SET @FieldValues = NULL

		INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
		VALUES ('PPFRepresentatives', @PKFields , @FieldValues, 'D')
	END
END
GO

SET NOCOUNT OFF
GO
