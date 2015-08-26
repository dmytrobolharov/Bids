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


IF (OBJECT_ID('tgx_Blocks_INSERT', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_Blocks_INSERT]
END
GO

CREATE TRIGGER [dbo].[tgx_Blocks_INSERT]
ON [dbo].[Blocks]
AFTER INSERT 
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [BlockId]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('Blocks'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('Blocks', @PKFields, 'C')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT Blocks.*
							FROM Blocks, inserted
							WHERE Blocks.BlockId = inserted.BlockId
							FOR XML PATH('Record'), ROOT('Blocks'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('Blocks', @PKFields , @FieldValues, 'C')
		END
	END
END
GO


IF (OBJECT_ID('tgx_Blocks_UPDATE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_Blocks_UPDATE]
END
GO

CREATE TRIGGER [dbo].[tgx_Blocks_UPDATE]
ON [dbo].[Blocks]
AFTER UPDATE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [BlockId]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('Blocks'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('Blocks', @PKFields, 'U')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT Blocks.*
							FROM Blocks, inserted
							WHERE Blocks.BlockId = inserted.BlockId
							FOR XML PATH('Record'), ROOT('Blocks'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('Blocks', @PKFields , @FieldValues, 'U')
		END
	END
END
GO


IF (OBJECT_ID('tgx_Blocks_DELETE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_Blocks_DELETE]
END
GO

CREATE TRIGGER [dbo].[tgx_Blocks_DELETE]
ON [dbo].[Blocks]
AFTER DELETE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [BlockId]
					FROM DELETED
					FOR XML PATH('Record'), ROOT('Blocks'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('Blocks', @PKFields, 'D')

		DECLARE @FieldValues xml
		SET @FieldValues = NULL

		INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
		VALUES ('Blocks', @PKFields , @FieldValues, 'D')
	END
END
GO

SET NOCOUNT OFF
GO
