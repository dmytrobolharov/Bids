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


IF (OBJECT_ID('tgx_Cad_MK_Piece_INSERT', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_Cad_MK_Piece_INSERT]
END
GO

CREATE TRIGGER [dbo].[tgx_Cad_MK_Piece_INSERT]
ON [dbo].[Cad_MK_Piece]
AFTER INSERT 
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [Marker_Code], [Piece_Code]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('Cad_MK_Piece'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('Cad_MK_Piece', @PKFields, 'C')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT Cad_MK_Piece.*
							FROM Cad_MK_Piece, inserted
							WHERE Cad_MK_Piece.Marker_Code = inserted.Marker_Code
							AND Cad_MK_Piece.Piece_Code = inserted.Piece_Code
							FOR XML PATH('Record'), ROOT('Cad_MK_Piece'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('Cad_MK_Piece', @PKFields , @FieldValues, 'C')
		END
	END
END
GO


IF (OBJECT_ID('tgx_Cad_MK_Piece_UPDATE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_Cad_MK_Piece_UPDATE]
END
GO

CREATE TRIGGER [dbo].[tgx_Cad_MK_Piece_UPDATE]
ON [dbo].[Cad_MK_Piece]
AFTER UPDATE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [Marker_Code], [Piece_Code]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('Cad_MK_Piece'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('Cad_MK_Piece', @PKFields, 'U')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT Cad_MK_Piece.*
							FROM Cad_MK_Piece, inserted
							WHERE Cad_MK_Piece.Marker_Code = inserted.Marker_Code
							AND Cad_MK_Piece.Piece_Code = inserted.Piece_Code
							FOR XML PATH('Record'), ROOT('Cad_MK_Piece'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('Cad_MK_Piece', @PKFields , @FieldValues, 'U')
		END
	END
END
GO


IF (OBJECT_ID('tgx_Cad_MK_Piece_DELETE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_Cad_MK_Piece_DELETE]
END
GO

CREATE TRIGGER [dbo].[tgx_Cad_MK_Piece_DELETE]
ON [dbo].[Cad_MK_Piece]
AFTER DELETE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [Marker_Code], [Piece_Code]
					FROM DELETED
					FOR XML PATH('Record'), ROOT('Cad_MK_Piece'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('Cad_MK_Piece', @PKFields, 'D')

		DECLARE @FieldValues xml
		SET @FieldValues = NULL

		INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
		VALUES ('Cad_MK_Piece', @PKFields , @FieldValues, 'D')
	END
END
GO

SET NOCOUNT OFF
GO
