-- **********************************************************************************************/
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 04 April 2013                                                                              */
-- *                                                                                            */
-- * Copyright (c) 2002-2013 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- **********************************************************************************************/
-- **********************************************************************************************/
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SystemButtons_IMPORT_MISSING_TABLE]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[spx_SystemButtons_IMPORT_MISSING_TABLE]
GO


CREATE PROCEDURE [dbo].[spx_SystemButtons_IMPORT_MISSING_TABLE]
(
	@TableType nvarchar(1)
)
AS 
BEGIN
	DECLARE @TableIndex AS INT
	DECLARE @RowIndex AS INT
	DECLARE @Row_Count AS INT
	DECLARE @DeskTopID AS INT
	DECLARE @DeskName AS NVARCHAR(100)
	DECLARE @DeskButtonName AS NVARCHAR(200)
	DECLARE @DeskIcon AS VARCHAR(200)
	DECLARE @ButtonType AS VARCHAR(200)

	IF LEN(@TableType) = 0
	BEGIN
		SET @TableType = 'D'
	END


	IF UPPER(@TableType) = 'D'
	BEGIN
		SET @TableIndex = 1
	END

	IF UPPER(@TableType) = 'T'
	BEGIN
		SET @TableIndex = 2
	END

	IF UPPER(@TableType) = 'A'
	BEGIN
		SET @TableIndex = 3
	END



	CREATE TABLE #TempMenu (
		Id int IDENTITY (1, 1) NOT NULL,
		DeskTopID int NOT NULL,
		DeskName NVARCHAR(100),
		DeskIcon VARCHAR(200)
	)

	IF @TableIndex = 1
	BEGIN
		INSERT INTO #TempMenu (DeskTopID, DeskName, DeskIcon) SELECT DeskTopID, DeskName, DeskIcon FROM sDeskTop ORDER BY DeskTopID
	END

	IF @TableIndex = 2
	BEGIN
		INSERT INTO #TempMenu (DeskTopID, DeskName, DeskIcon) SELECT DeskTopID, DeskName, DeskIcon FROM sYuniFaceDeskTop ORDER BY DeskTopID
	END

	IF @TableIndex = 3
	BEGIN
		INSERT INTO #TempMenu (DeskTopID, DeskName, DeskIcon) SELECT DeskTopID, DeskName, DeskIcon FROM sAppManDeskTop ORDER BY DeskTopID
	END



	SET @Row_Count = (SELECT COUNT(*) FROM #TempMenu)
	SET @RowIndex = 1

	WHILE @RowIndex <= @Row_Count
	BEGIN

		SELECT @DeskTopID = DeskTopID, @DeskName = DeskName, @DeskButtonName = 'btn_Desk_' + REPLACE(@DeskName, ' ', '') + '.gif', @DeskIcon = DeskIcon
		FROM #TempMenu WHERE ID = @RowIndex


		IF @TableIndex = 1
		BEGIN
			UPDATE sDeskTop SET DeskButtonName = @DeskButtonName WHERE DeskTopID = @DeskTopID
		END

		IF @TableIndex = 2
		BEGIN
			UPDATE sYuniFaceDeskTop SET DeskButtonName = @DeskButtonName WHERE DeskTopID = @DeskTopID
		END

		IF @TableIndex = 3
		BEGIN
			UPDATE sAppManDeskTop SET DeskButtonName = @DeskButtonName WHERE DeskTopID = @DeskTopID
		END


		SET @ButtonType = 'TopMenu'

		IF @TableIndex > 1
		BEGIN

			IF UPPER(@DeskName) <> 'HOME'
			BEGIN

				IF UPPER(@DeskName) <> 'LOG OFF'
				BEGIN
					SET @ButtonType = 'Metro'
				END

			END

		END


		IF NOT EXISTS (SELECT DISTINCT SystembuttonID FROM sSystemButtons WHERE DesignString = @DeskButtonName)
		BEGIN
			--PRINT 'Insert into table sSystemButtons'
			INSERT INTO sSystemButtons (DesignString, ButtonType, en_US, ButtonIcon)
			VALUES (@DeskButtonName, @ButtonType, @DeskName, @DeskIcon)
		END
		ELSE
		BEGIN
			--PRINT 'Insert into table sSystemButtons'
			UPDATE sSystemButtons SET ButtonType = @ButtonType, 
									  ButtonIcon = @DeskIcon
			WHERE DesignString = @DeskButtonName
		END

		SET @RowIndex = @RowIndex + 1

	END

	DROP TABLE #TempMenu
END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05497', GetDate())
GO

SET NOCOUNT Off
GO
