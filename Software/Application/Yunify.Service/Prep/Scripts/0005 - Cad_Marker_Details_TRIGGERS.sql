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


IF (OBJECT_ID('tgx_Cad_Marker_Details_INSERT', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_Cad_Marker_Details_INSERT]
END
GO

CREATE TRIGGER [dbo].[tgx_Cad_Marker_Details_INSERT]
ON [dbo].[Cad_Marker_Details]
AFTER INSERT 
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [Marker_Code]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('Cad_Marker_Details'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('Cad_Marker_Details', @PKFields, 'C')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT Cad_Marker_Details.*
							FROM Cad_Marker_Details, inserted
							WHERE Cad_Marker_Details.Marker_Code = inserted.Marker_Code
							FOR XML PATH('Record'), ROOT('Cad_Marker_Details'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('Cad_Marker_Details', @PKFields , @FieldValues, 'C')
		END
	END
END
GO


IF (OBJECT_ID('tgx_Cad_Marker_Details_UPDATE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_Cad_Marker_Details_UPDATE]
END
GO

CREATE TRIGGER [dbo].[tgx_Cad_Marker_Details_UPDATE]
ON [dbo].[Cad_Marker_Details]
AFTER UPDATE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [Marker_Code]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('Cad_Marker_Details'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('Cad_Marker_Details', @PKFields, 'U')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT Cad_Marker_Details.*
							FROM Cad_Marker_Details, inserted
							WHERE Cad_Marker_Details.Marker_Code = inserted.Marker_Code
							FOR XML PATH('Record'), ROOT('Cad_Marker_Details'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('Cad_Marker_Details', @PKFields , @FieldValues, 'U')
		END
	END
END
GO


IF (OBJECT_ID('tgx_Cad_Marker_Details_DELETE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_Cad_Marker_Details_DELETE]
END
GO

CREATE TRIGGER [dbo].[tgx_Cad_Marker_Details_DELETE]
ON [dbo].[Cad_Marker_Details]
AFTER DELETE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [Marker_Code]
					FROM DELETED
					FOR XML PATH('Record'), ROOT('Cad_Marker_Details'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('Cad_Marker_Details', @PKFields, 'D')

		DECLARE @FieldValues xml
		SET @FieldValues = NULL

		INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
		VALUES ('Cad_Marker_Details', @PKFields , @FieldValues, 'D')
	END
END
GO

SET NOCOUNT OFF
GO
