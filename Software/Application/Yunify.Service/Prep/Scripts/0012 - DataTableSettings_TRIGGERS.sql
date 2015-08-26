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


IF (OBJECT_ID('tgx_DataTableSettings_INSERT', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_DataTableSettings_INSERT]
END
GO

CREATE TRIGGER [dbo].[tgx_DataTableSettings_INSERT]
ON [dbo].[DataTableSettings]
AFTER INSERT 
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT OLEName, UserName, Set_Key
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('DataTableSettings'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('DataTableSettings', @PKFields, 'C')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT DataTableSettings.*
							FROM DataTableSettings, inserted
							WHERE DataTableSettings.OLEName = inserted.OLEName
							AND DataTableSettings.UserName = inserted.UserName
							AND DataTableSettings.Set_Key = inserted.Set_Key
							FOR XML PATH('Record'), ROOT('DataTableSettings'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('DataTableSettings', @PKFields , @FieldValues, 'C')
		END
	END
END
GO


IF (OBJECT_ID('tgx_DataTableSettings_UPDATE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_DataTableSettings_UPDATE]
END
GO

CREATE TRIGGER [dbo].[tgx_DataTableSettings_UPDATE]
ON [dbo].[DataTableSettings]
AFTER UPDATE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT OLEName, UserName, Set_Key
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('DataTableSettings'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('DataTableSettings', @PKFields, 'U')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT DataTableSettings.*
							FROM DataTableSettings, inserted
							WHERE DataTableSettings.OLEName = inserted.OLEName
							AND DataTableSettings.UserName = inserted.UserName
							AND DataTableSettings.Set_Key = inserted.Set_Key
							FOR XML PATH('Record'), ROOT('DataTableSettings'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('DataTableSettings', @PKFields , @FieldValues, 'U')
		END
	END
END
GO


IF (OBJECT_ID('tgx_DataTableSettings_DELETE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_DataTableSettings_DELETE]
END
GO

CREATE TRIGGER [dbo].[tgx_DataTableSettings_DELETE]
ON [dbo].[DataTableSettings]
AFTER DELETE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT OLEName, UserName, Set_Key
					FROM DELETED
					FOR XML PATH('Record'), ROOT('DataTableSettings'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('DataTableSettings', @PKFields, 'D')

		DECLARE @FieldValues xml
		SET @FieldValues = NULL

		INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
		VALUES ('DataTableSettings', @PKFields , @FieldValues, 'D')
	END
END
GO

SET NOCOUNT OFF
GO
