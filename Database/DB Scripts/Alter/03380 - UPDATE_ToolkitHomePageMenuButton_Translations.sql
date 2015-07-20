-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 17 April 2012                                                                              */
-- *                                                                                            */
-- * Copyright (c) 2002-2012 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
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


DECLARE @RowIndex AS INT
DECLARE @Row_Count AS INT
DECLARE @DeskTopID AS INT
DECLARE @DeskName AS NVARCHAR(100)
DECLARE @DeskButtonName AS NVARCHAR(200)
DECLARE @DeskIcon AS VARCHAR(200)

CREATE TABLE #TempMenu (
	Id int IDENTITY (1, 1) NOT NULL,
	DeskTopID int NOT NULL,
	DeskName NVARCHAR(100),
	DeskIcon VARCHAR(200)
)

INSERT INTO #TempMenu (DeskTopID, DeskName, DeskIcon) SELECT DeskTopID, DeskName, DeskIcon FROM sYuniFaceDeskTop ORDER BY DeskTopID

SET @Row_Count = (SELECT COUNT(*) FROM #TempMenu)

SET @RowIndex = 1

WHILE @RowIndex <= @Row_Count
BEGIN
	SELECT @DeskTopID = DeskTopID, @DeskName = DeskName, @DeskButtonName = 'btn_Desk_' + REPLACE(@DeskName, ' ', '') + '.gif', @DeskIcon = DeskIcon
	FROM #TempMenu WHERE ID = @RowIndex

	UPDATE sYuniFaceDeskTop SET DeskButtonName = @DeskButtonName WHERE DeskName = @DeskName

	IF NOT EXISTS (SELECT SystembuttonID FROM sSystemButtons WHERE DesignString = @DeskButtonName AND ButtonType = 'TopMenu')
	BEGIN

		--PRINT 'Insert into table sSystemButtons'
		INSERT INTO sSystemButtons (DesignString, ButtonType, en_US, ButtonIcon)
		VALUES (@DeskButtonName, 'TopMenu', @DeskName, @DeskIcon)
		
	END

	SET @RowIndex = @RowIndex + 1
END

DROP TABLE #TempMenu
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03380', GetDate())
GO

SET NOCOUNT Off
GO
