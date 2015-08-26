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


IF (OBJECT_ID('tgx_AccumarkPaths_INSERT', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_AccumarkPaths_INSERT]
END
GO

CREATE TRIGGER [dbo].[tgx_AccumarkPaths_INSERT]
ON [dbo].[AccumarkPaths]
AFTER INSERT 
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [Server], [Storage_Area], [Name], [TypeId], [CategoryGuid]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('AccumarkPaths'))
	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('AccumarkPaths', @PKFields, 'C')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT AccumarkPaths.*
							FROM AccumarkPaths, inserted
							WHERE AccumarkPaths.Server = inserted.Server
							AND AccumarkPaths.Storage_Area = inserted.Storage_Area
							AND AccumarkPaths.Name = inserted.Name
							AND AccumarkPaths.TypeId = inserted.TypeId
							AND AccumarkPaths.CategoryGuid = inserted.CategoryGuid
							FOR XML PATH('Record'), ROOT('AccumarkPaths'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('AccumarkPaths', @PKFields , @FieldValues, 'C')
		END
	END
END
GO


IF (OBJECT_ID('tgx_AccumarkPaths_UPDATE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_AccumarkPaths_UPDATE]
END
GO

CREATE TRIGGER [dbo].[tgx_AccumarkPaths_UPDATE]
ON [dbo].[AccumarkPaths]
AFTER UPDATE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [Server], [Storage_Area], [Name], [TypeId], [CategoryGuid]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('AccumarkPaths'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('AccumarkPaths', @PKFields, 'U')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT AccumarkPaths.*
							FROM AccumarkPaths, inserted
							WHERE AccumarkPaths.Server = inserted.Server
							AND AccumarkPaths.Storage_Area = inserted.Storage_Area
							AND AccumarkPaths.Name = inserted.Name
							AND AccumarkPaths.TypeId = inserted.TypeId
							AND AccumarkPaths.CategoryGuid = inserted.CategoryGuid
							FOR XML PATH('Record'), ROOT('AccumarkPaths'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('AccumarkPaths', @PKFields , @FieldValues, 'U')
		END
	END
END
GO


IF (OBJECT_ID('tgx_AccumarkPaths_DELETE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_AccumarkPaths_DELETE]
END
GO

CREATE TRIGGER [dbo].[tgx_AccumarkPaths_DELETE]
ON [dbo].[AccumarkPaths]
AFTER DELETE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [Server], [Storage_Area], [Name], [TypeId], [CategoryGuid]
					FROM DELETED
					FOR XML PATH('Record'), ROOT('AccumarkPaths'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('AccumarkPaths', @PKFields, 'D')

		DECLARE @FieldValues xml
		SET @FieldValues = NULL

		INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
		VALUES ('AccumarkPaths', @PKFields , @FieldValues, 'D')
	END
END
GO

SET NOCOUNT OFF
GO
