	-- ******************************************************************************************** */
	-- * GERBER TECHNOLOGY                                                                          */
	-- *                                                                                            */
	-- * YuniquePLM                                                                                 */
	-- * Alter Script                                                                               */
	-- * Database:                                                                                  */
	-- * 7 March 2012                                                                           */
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
	
	IF NOT EXISTS(SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='DESKBUTTONNAME' AND TABLE_NAME='sDeskTop')
	BEGIN
		ALTER TABLE sDeskTop ADD DESKBUTTONNAME VARCHAR(50) 
	END		
	ELSE
	BEGIN 
		PRINT 'COLUMN ALREADY EXISTS FOR TABLE sDeskTop'
	END
	
	GO
	
	DECLARE @I AS INT
	DECLARE @Row_Count AS INT
	DECLARE @DeskTopID AS INT
	DECLARE @DeskName AS VARCHAR(50)	
	DECLARE @DeskButtonName AS VARCHAR(50)
	DECLARE @DeskIcon AS VARCHAR(50)
	
	CREATE TABLE #TempMenu (
		Id int IDENTITY (1, 1) NOT NULL,
		DeskTopID int NOT NULL,
		DeskName VARCHAR(50),
		DeskIcon VARCHAR(50)
	)

	INSERT INTO #TempMenu(DeskTopID,DeskName,DeskIcon) SELECT DeskTopID,DeskName,DeskIcon FROM sDeskTop ORDER BY DeskTopID  

	SET @Row_Count = (SELECT COUNT(*) FROM #TempMenu)

	SET @I = 1

	WHILE @I <= @Row_Count
	BEGIN
		SELECT @DeskTopID = DeskTopID,@DeskName=DeskName,@DeskButtonName='btn_Desk_'+@DeskName+'.gif',@DeskIcon=DeskIcon  FROM #TempMenu WHERE ID = @I
		SET @DeskButtonName='btn_Desk_'+REPLACE(@DeskName,' ','')+'.gif'
		
		IF EXISTS(SELECT DesktopID FROM sDeskTop Where DeskName=@DeskName)
		BEGIN
			--PRINT 'Updation in table sDeskTop'			
			SELECT @DeskButtonName=@DeskButtonName FROM sDeskTop Where DeskName=@DeskName
			UPDATE sDeskTop SET DeskButtonName=@DeskButtonName WHERE DeskName=@DeskName			
		END	
		
		IF NOT EXISTS (SELECT SystembuttonID FROM sSystemButtons WHERE DesignString=@DeskButtonName AND ButtonType='TopMenu') 
		BEGIN	
		
			--PRINT 'Insersion in table sSystemButtons' 	
			INSERT INTO sSystemButtons 
			(DesignString,ButtonType,en_US, ButtonIcon ) 
			VALUES 
			(@DeskButtonName,'TopMenu',@DeskName, @DeskIcon)
		END

		SET @I = @I + 1
	END	

	DROP TABLE #TempMenu

    GO
    
	IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03208'))
	BEGIN

		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES     ('DB_Version', '5.0.0000', '03208', GetDate())

	END
	GO