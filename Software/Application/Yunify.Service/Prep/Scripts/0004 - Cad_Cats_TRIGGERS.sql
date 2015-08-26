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


IF (OBJECT_ID('tgx_Cad_Cats_INSERT', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_Cad_Cats_INSERT]
END
GO

CREATE TRIGGER [dbo].[tgx_Cad_Cats_INSERT]
ON [dbo].[Cad_Cats]
AFTER INSERT 
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [CADCatId]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('Cad_Cats'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('Cad_Cats', @PKFields, 'C')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT Cad_Cats.*
							FROM Cad_Cats, inserted
							WHERE Cad_Cats.CADCatId = inserted.CADCatId
							FOR XML PATH('Record'), ROOT('Cad_Cats'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('Cad_Cats', @PKFields , @FieldValues, 'C')
		END
	END
END
GO


IF (OBJECT_ID('tgx_Cad_Cats_UPDATE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_Cad_Cats_UPDATE]
END
GO

CREATE TRIGGER [dbo].[tgx_Cad_Cats_UPDATE]
ON [dbo].[Cad_Cats]
AFTER UPDATE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [CADCatId]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('Cad_Cats'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('Cad_Cats', @PKFields, 'U')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT Cad_Cats.*
							FROM Cad_Cats, inserted
							WHERE Cad_Cats.CADCatId = inserted.CADCatId
							FOR XML PATH('Record'), ROOT('Cad_Cats'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('Cad_Cats', @PKFields , @FieldValues, 'U')
		END
	END
END
GO


IF (OBJECT_ID('tgx_Cad_Cats_DELETE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_Cad_Cats_DELETE]
END
GO

CREATE TRIGGER [dbo].[tgx_Cad_Cats_DELETE]
ON [dbo].[Cad_Cats]
AFTER DELETE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [CADCatId]
					FROM DELETED
					FOR XML PATH('Record'), ROOT('Cad_Cats'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('Cad_Cats', @PKFields, 'D')

		DECLARE @FieldValues xml
		SET @FieldValues = NULL

		INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
		VALUES ('Cad_Cats', @PKFields , @FieldValues, 'D')
	END
END
GO

SET NOCOUNT OFF
GO
