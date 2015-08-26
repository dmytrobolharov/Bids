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


IF (OBJECT_ID('tgx_SystemSettings_INSERT', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_SystemSettings_INSERT]
END
GO

CREATE TRIGGER [dbo].[tgx_SystemSettings_INSERT]
ON [dbo].[SystemSettings]
AFTER INSERT 
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [Section], [Setting]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('SystemSettings'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('SystemSettings', @PKFields, 'C')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT SystemSettings.*
							FROM SystemSettings, inserted
							WHERE SystemSettings.Section = inserted.Section
							AND SystemSettings.Setting = inserted.Setting
							FOR XML PATH('Record'), ROOT('SystemSettings'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('SystemSettings', @PKFields , @FieldValues, 'C')
		END
	END
END
GO


IF (OBJECT_ID('tgx_SystemSettings_UPDATE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_SystemSettings_UPDATE]
END
GO

CREATE TRIGGER [dbo].[tgx_SystemSettings_UPDATE]
ON [dbo].[SystemSettings]
AFTER UPDATE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [Section], [Setting]
					FROM INSERTED
					FOR XML PATH('Record'), ROOT('SystemSettings'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('SystemSettings', @PKFields, 'U')

		DECLARE @FieldValues xml
		SET @FieldValues = (SELECT SystemSettings.*
							FROM SystemSettings, inserted
							WHERE SystemSettings.Section = inserted.Section
							AND SystemSettings.Setting = inserted.Setting
							FOR XML PATH('Record'), ROOT('SystemSettings'))

		IF @FieldValues IS NOT NULL
		BEGIN
			INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
			VALUES ('SystemSettings', @PKFields , @FieldValues, 'U')
		END
	END
END
GO


IF (OBJECT_ID('tgx_SystemSettings_DELETE', 'TR') IS NOT NULL)
BEGIN
	DROP TRIGGER [dbo].[tgx_SystemSettings_DELETE]
END
GO

CREATE TRIGGER [dbo].[tgx_SystemSettings_DELETE]
ON [dbo].[SystemSettings]
AFTER DELETE
AS
BEGIN
	DECLARE @PKFields xml
	SET @PKFields = (SELECT [Section], [Setting]
					FROM DELETED
					FOR XML PATH('Record'), ROOT('SystemSettings'))

	IF @PKFields IS NOT NULL
	BEGIN
		--INSERT INTO Yunify(TableName, PKFields, CRUDType)
		--VALUES ('SystemSettings', @PKFields, 'D')

		DECLARE @FieldValues xml
		SET @FieldValues = NULL

		INSERT INTO Yunify(TableName, PKFields, FieldValues, CRUDType)
		VALUES ('SystemSettings', @PKFields , @FieldValues, 'D')
	END
END
GO

SET NOCOUNT OFF
GO
