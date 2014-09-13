/****** Object:  StoredProcedure [dbo].[spx_DeskMenu_INSERT]    Script Date: 03/29/2012 17:44:38 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_DeskMenu_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_DeskMenu_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_DeskMenu_INSERT]    Script Date: 03/29/2012 17:44:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_DeskMenu_INSERT]
	@DeskTopID INT,
	@TeamID UNIQUEIDENTIFIER,
	@BeforeID INT = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF EXISTS(SELECT * FROM uUserSetting WHERE TeamID = @TeamID AND SettingSection = N'DeskTopItems' AND CAST(SettingValue AS INT) = @DeskTopID)
	BEGIN
		DECLARE @Sort INT
		SELECT TOP 1 @Sort = CAST(SettingKey AS INT) + 10 
		FROM uUserSetting WHERE TeamID = @TeamID AND SettingSection = 'DeskMenuItems' 
		ORDER BY CAST(SettingKey AS INT) DESC
		
		IF @Sort IS NULL
			SET @Sort = 10
		
		UPDATE uUserSetting SET SettingSection = 'DeskMenuItems', SettingKey = @Sort
		WHERE TeamID = @TeamID AND SettingSection = N'DeskTopItems' AND CAST(SettingValue AS INT) = @DeskTopID
	END
	
	IF @BeforeID IS NOT NULL
	BEGIN
		DECLARE @BeforeItemSort INT,
				@CurrentItemSort INT,
				@LastSortValue VARCHAR(4),
				@ItemID VARBINARY(MAX),
				@ItemSort VARCHAR(4);
				
		SELECT @BeforeItemSort = CAST(SettingKey AS INT) FROM uUserSetting
		WHERE TeamID = @TeamID AND SettingSection = 'DeskMenuItems' AND CAST(SettingValue AS INT) = @BeforeID
		
		SELECT @CurrentItemSort = CAST(SettingKey AS INT) FROM uUserSetting
		WHERE TeamID = @TeamID AND SettingSection = 'DeskMenuItems' AND CAST(SettingValue AS INT) = @DeskTopID
		
		-- remove current item in order to place it in right position
		DELETE FROM uUserSetting 
		WHERE TeamID = @TeamID AND SettingSection = 'DeskMenuItems' AND CAST(SettingValue AS INT) = @DeskTopID
		
		SET @LastSortValue = @CurrentItemSort
		IF @CurrentItemSort > @BeforeItemSort
		BEGIN			
			DECLARE SortCursor CURSOR FOR
				SELECT SettingValue, SettingKey FROM uUserSetting
				WHERE TeamID = @TeamID AND SettingSection = 'DeskMenuItems'
				AND CAST(SettingKey AS INT) >= @BeforeItemSort AND CAST(SettingKey AS INT) < @CurrentItemSort
				ORDER BY CAST(SettingKey AS INT) DESC			
		END
		ELSE
		BEGIN					
			DECLARE SortCursor CURSOR FOR
				SELECT SettingValue, SettingKey FROM uUserSetting
				WHERE TeamID = @TeamID AND SettingSection = 'DeskMenuItems'
				AND CAST(SettingKey AS INT) < @BeforeItemSort AND CAST(SettingKey AS INT) > @CurrentItemSort
				ORDER BY CAST(SettingKey AS INT) ASC	
		END
		
		-- reorder items
		OPEN SortCursor
			FETCH NEXT FROM SortCursor INTO @ItemID, @ItemSort
			
			WHILE @@FETCH_STATUS = 0
			BEGIN
				UPDATE uUserSetting SET SettingKey = @LastSortValue
				WHERE TeamID = @TeamID AND SettingSection = 'DeskMenuItems' AND SettingValue = @ItemID
				
				SET @LastSortValue = @ItemSort
				
				FETCH NEXT FROM SortCursor INTO @ItemID, @ItemSort
			END
		CLOSE SortCursor
		DEALLOCATE SortCursor
		
		-- insert sorted item in right place
		INSERT INTO uUserSetting(TeamID, SettingSection, SettingKey, SettingValue) VALUES
		(@TeamID, 'DeskMenuItems', @LastSortValue, @DeskTopID)
	END
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03273'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03273', GetDate())

END
GO 