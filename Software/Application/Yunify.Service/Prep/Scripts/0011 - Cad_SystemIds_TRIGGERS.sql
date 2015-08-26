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


IF (OBJECT_ID('tgx_Cad_SystemIds_INSERT', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_Cad_SystemIds_INSERT]
END
GO

CREATE TRIGGER [dbo].[tgx_Cad_SystemIds_INSERT]
ON [dbo].[Cad_SystemIds]
AFTER INSERT 
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [SystemId]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('Cad_SystemIds'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('Cad_SystemIds', @PKFields, 'C')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT Cad_SystemIds.*
							FROM Cad_SystemIds, inserted
							WHERE Cad_SystemIds.SystemId = inserted.SystemId
							FOR XML PATH('Record'), ROOT('Cad_SystemIds'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('Cad_SystemIds', @PKFields , @FieldValues, 'C')
		END
	END
END
GO


IF (OBJECT_ID('tgx_Cad_SystemIds_UPDATE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_Cad_SystemIds_UPDATE]
END
GO

CREATE TRIGGER [dbo].[tgx_Cad_SystemIds_UPDATE]
ON [dbo].[Cad_SystemIds]
AFTER UPDATE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [SystemId]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('Cad_SystemIds'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('Cad_SystemIds', @PKFields, 'U')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT Cad_SystemIds.*
							FROM Cad_SystemIds, inserted
							WHERE Cad_SystemIds.SystemId = inserted.SystemId
							FOR XML PATH('Record'), ROOT('Cad_SystemIds'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('Cad_SystemIds', @PKFields , @FieldValues, 'U')
		END
	END
END
GO


IF (OBJECT_ID('tgx_Cad_SystemIds_DELETE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_Cad_SystemIds_DELETE]
END
GO

CREATE TRIGGER [dbo].[tgx_Cad_SystemIds_DELETE]
ON [dbo].[Cad_SystemIds]
AFTER DELETE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [SystemId]
					FROM DELETED
					FOR XML PATH('Record'), ROOT('Cad_SystemIds'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('Cad_SystemIds', @PKFields, 'D')

		DECLARE @FieldValues xml
		SET @FieldValues = NULL

		INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
		VALUES ('Cad_SystemIds', @PKFields , @FieldValues, 'D')
	END
END
GO

SET NOCOUNT OFF
GO
