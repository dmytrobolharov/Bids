/****** Object:  StoredProcedure [dbo].[spx_DeskTop_INSERT]    Script Date: 03/29/2012 17:46:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DeskTop_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_DeskTop_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_DeskTop_INSERT]    Script Date: 03/29/2012 17:46:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_DeskTop_INSERT]
	@DeskTopID INT,
	@TeamID UNIQUEIDENTIFIER,
	@BeforeID INT = NULL
AS
BEGIN
	SET NOCOUNT ON;

	IF EXISTS(SELECT * FROM uUserSetting WHERE TeamID = @TeamID AND SettingSection = 'DeskMenuItems' AND CAST(SettingValue AS INT) = @DeskTopID)
	BEGIN
		DECLARE @Sort INT
		SELECT TOP 1 @Sort = CAST(SettingKey AS INT) + 10
		FROM uUserSetting WHERE TeamID = @TeamID AND SettingSection = 'DeskTopItems'
		ORDER BY CAST(SettingKey AS INT) DESC
		
		IF @Sort IS NULL
			SET @Sort = 10
		
		UPDATE uUserSetting SET SettingSection = 'DeskTopItems', SettingKey = @Sort
		WHERE TeamID = @TeamID AND SettingSection = 'DeskMenuItems' AND CAST(SettingValue AS INT) = @DeskTopID
	END
	
	IF @BeforeID IS NOT NULL
	BEGIN
		DECLARE @BeforeItemSort INT,
				@CurrentItemSort INT,
				@LastSortValue VARCHAR(4),
				@ItemID VARBINARY(MAX),
				@ItemSort VARCHAR(4);
				
		SELECT @BeforeItemSort = CAST(SettingKey AS INT) FROM uUserSetting
		WHERE TeamID = @TeamID AND SettingSection = 'DeskTopItems' AND CAST(SettingValue AS INT) = @BeforeID
		
		SELECT @CurrentItemSort = CAST(SettingKey AS INT) FROM uUserSetting
		WHERE TeamID = @TeamID AND SettingSection = 'DeskTopItems' AND CAST(SettingValue AS INT) = @DeskTopID
		
		-- remove current item in order to place it in right position
		DELETE FROM uUserSetting 
		WHERE TeamID = @TeamID AND SettingSection = 'DeskTopItems' AND CAST(SettingValue AS INT) = @DeskTopID
		
		SET @LastSortValue = @CurrentItemSort
		IF @CurrentItemSort > @BeforeItemSort
		BEGIN			
			DECLARE SortCursor CURSOR FOR
				SELECT SettingValue, SettingKey FROM uUserSetting
				WHERE TeamID = @TeamID AND SettingSection = 'DeskTopItems'
				AND CAST(SettingKey AS INT) >= @BeforeItemSort AND CAST(SettingKey AS INT) < @CurrentItemSort
				ORDER BY CAST(SettingKey AS INT) DESC			
		END
		ELSE
		BEGIN					
			DECLARE SortCursor CURSOR FOR
				SELECT SettingValue, SettingKey FROM uUserSetting
				WHERE TeamID = @TeamID AND SettingSection = 'DeskTopItems'
				AND CAST(SettingKey AS INT) < @BeforeItemSort AND CAST(SettingKey AS INT) > @CurrentItemSort
				ORDER BY CAST(SettingKey AS INT) ASC	
		END
		
		OPEN SortCursor
			FETCH NEXT FROM SortCursor INTO @ItemID, @ItemSort
			
			WHILE @@FETCH_STATUS = 0
			BEGIN
				UPDATE uUserSetting SET SettingKey = @LastSortValue
				WHERE TeamID = @TeamID AND SettingSection = 'DeskTopItems' AND SettingValue = @ItemID
				
				SET @LastSortValue = @ItemSort
				
				FETCH NEXT FROM SortCursor INTO @ItemID, @ItemSort
			END
		CLOSE SortCursor
		DEALLOCATE SortCursor
		
		INSERT INTO uUserSetting(TeamID, SettingSection, SettingKey, SettingValue) VALUES
		(@TeamID, 'DeskTopItems', @LastSortValue, @DeskTopID)
	END
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03274'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03274', GetDate())

END
GO 

