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


IF (OBJECT_ID('tgx_Cad_MK_Model_INSERT', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_Cad_MK_Model_INSERT]
END
GO

CREATE TRIGGER [dbo].[tgx_Cad_MK_Model_INSERT]
ON [dbo].[Cad_MK_Model]
AFTER INSERT 
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [Marker_Code], [Model_Code]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('Cad_MK_Model'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('Cad_MK_Model', @PKFields, 'C')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT Cad_MK_Model.*
							FROM Cad_MK_Model, inserted
							WHERE Cad_MK_Model.Marker_Code = inserted.Marker_Code
							AND Cad_MK_Model.Model_Code = inserted.Model_Code
							FOR XML PATH('Record'), ROOT('Cad_MK_Model'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('Cad_MK_Model', @PKFields , @FieldValues, 'C')
		END
	END
END
GO


IF (OBJECT_ID('tgx_Cad_MK_Model_UPDATE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_Cad_MK_Model_UPDATE]
END
GO

CREATE TRIGGER [dbo].[tgx_Cad_MK_Model_UPDATE]
ON [dbo].[Cad_MK_Model]
AFTER UPDATE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [Marker_Code], [Model_Code]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('Cad_MK_Model'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('Cad_MK_Model', @PKFields, 'U')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT Cad_MK_Model.*
							FROM Cad_MK_Model, inserted
							WHERE Cad_MK_Model.Marker_Code = inserted.Marker_Code
							AND Cad_MK_Model.Model_Code = inserted.Model_Code
							FOR XML PATH('Record'), ROOT('Cad_MK_Model'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('Cad_MK_Model', @PKFields , @FieldValues, 'U')
		END
	END
END
GO


IF (OBJECT_ID('tgx_Cad_MK_Model_DELETE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_Cad_MK_Model_DELETE]
END
GO

CREATE TRIGGER [dbo].[tgx_Cad_MK_Model_DELETE]
ON [dbo].[Cad_MK_Model]
AFTER DELETE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [Marker_Code], [Model_Code]
					FROM DELETED
					FOR XML PATH('Record'), ROOT('Cad_MK_Model'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('Cad_MK_Model', @PKFields, 'D')

		DECLARE @FieldValues xml
		SET @FieldValues = NULL

		INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
		VALUES ('Cad_MK_Model', @PKFields , @FieldValues, 'D')
	END
END
GO

SET NOCOUNT OFF
GO
