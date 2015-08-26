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


IF (OBJECT_ID('tgx_gtAccumarkTypes_INSERT', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_gtAccumarkTypes_INSERT]
END
GO

CREATE TRIGGER [dbo].[tgx_gtAccumarkTypes_INSERT]
ON [dbo].[gtAccumarkTypes]
AFTER INSERT 
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [TypeId]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('gtAccumarkTypes'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('gtAccumarkTypes', @PKFields, 'C')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT gtAccumarkTypes.*
							FROM gtAccumarkTypes, inserted
							WHERE gtAccumarkTypes.TypeId = inserted.TypeId
							FOR XML PATH('Record'), ROOT('gtAccumarkTypes'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('gtAccumarkTypes', @PKFields , @FieldValues, 'C')
		END
	END
END
GO


IF (OBJECT_ID('tgx_gtAccumarkTypes_UPDATE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_gtAccumarkTypes_UPDATE]
END
GO

CREATE TRIGGER [dbo].[tgx_gtAccumarkTypes_UPDATE]
ON [dbo].[gtAccumarkTypes]
AFTER UPDATE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [TypeId]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('gtAccumarkTypes'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('gtAccumarkTypes', @PKFields, 'U')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT gtAccumarkTypes.*
							FROM gtAccumarkTypes, inserted
							WHERE gtAccumarkTypes.TypeId = inserted.TypeId
							FOR XML PATH('Record'), ROOT('gtAccumarkTypes'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('gtAccumarkTypes', @PKFields , @FieldValues, 'U')
		END
	END
END
GO


IF (OBJECT_ID('tgx_gtAccumarkTypes_DELETE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_gtAccumarkTypes_DELETE]
END
GO

CREATE TRIGGER [dbo].[tgx_gtAccumarkTypes_DELETE]
ON [dbo].[gtAccumarkTypes]
AFTER DELETE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [TypeId]
					FROM DELETED
					FOR XML PATH('Record'), ROOT('gtAccumarkTypes'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('gtAccumarkTypes', @PKFields, 'D')

		DECLARE @FieldValues xml
		SET @FieldValues = NULL

		INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
		VALUES ('gtAccumarkTypes', @PKFields , @FieldValues, 'D')
	END
END
GO

SET NOCOUNT OFF
GO
