IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMColorwayFromColor_LineFolderFlash_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMColorwayFromColor_LineFolderFlash_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_StyleBOMColorwayFromColor_LineFolderFlash_INSERT]
	@LineFolderItemID UNIQUEIDENTIFIER,
	@ColorPaletteID UNIQUEIDENTIFIER, 
	@CUser  NVARCHAR (200), 
	@CDate DATETIME
AS
BEGIN

	DECLARE @StyleBOMDimensionID UNIQUEIDENTIFIER
	SELECT @StyleBOMDimensionID = StyleBOMDimensionID FROM pLineFolderItem WHERE LineFolderItemID = @LineFolderItemID
	
	DECLARE @StyleID NVARCHAR(50)
	DECLARE @StyleSet INT
	DECLARE @WorkflowID NVARCHAR(50)
	DECLARE @WorkflowItemID NVARCHAR(50)
	DECLARE @DimLevel INT
	
	DECLARE @AllSizeClasses INT
	DECLARE @SeasonYearID UNIQUEIDENTIFIER
	
	IF @StyleBOMDimensionID IS NOT NULL AND @StyleBOMDimensionID <> '00000000-0000-0000-0000-000000000000'
	BEGIN

		SELECT @StyleID = StyleID, @StyleSet = StyleSet, @WorkFlowID = WorkFlowID, @WorkflowItemID = WorkFlowItemID 
		FROM pStyleBOMDimension 
		WHERE StyleBOMDimensionID = @StyleBOMDimensionID

		IF (SELECT ItemDim1TypeName FROM pStyleBOMDimension WHERE StyleBOMDimensionID = @StyleBOMDimensionID) = 'color'
		BEGIN
			SET @DimLevel = 1
		END
		ELSE IF (SELECT ItemDim2TypeName FROM pStyleBOMDimension WHERE StyleBOMDimensionID = @StyleBOMDimensionID) = 'color'
		BEGIN
			SET @DimLevel = 2
		END
		ELSE IF (SELECT ItemDim3TypeName FROM pStyleBOMDimension WHERE StyleBOMDimensionID = @StyleBOMDimensionID) = 'color'
		BEGIN
			SET @DimLevel = 3
		END
		ELSE
		BEGIN
			SET @DimLevel = 0
		END
		
		IF @DimLevel <> 0
		BEGIN

			EXEC spx_StyleBOMColorways_Insert
					@ItemDimTypeId = NULL,
					@StyleBOMDimensionId = @StyleBOMDimensionID,
					@ColorPaletteID = @ColorPaletteID,
					@StyleID = @StyleID, 
					@StyleSet = @StyleSet ,
					@WorkflowID = @WorkflowID, 
					@WorkflowItemID = @WorkflowItemID,
					@DimLevel = @DimLevel
					
			
			SET @AllSizeClasses = 0
			IF (SELECT UPPER(AppSettingValue) FROM sAppSetting WHERE AppSettingKey = 'AllowSizeClassColorways') = 'TRUE'
				SET @AllSizeClasses = 1
				
			SELECT @SeasonYearID = pLineFolder.SeasonYearID FROM pLineFolder
				INNER JOIN pLineFolderItem ON pLineFolder.LineFolderID = pLineFolderItem.LineFolderID
			WHERE LineFolderItemID = @LineFolderItemID

			EXEC spx_StyleColorway_SeasonColor_INSERT
					@ColorPaletteID = @ColorPaletteID,
					@StyleID = @StyleID,
					@StyleSet = @StyleSet,
					@SeasonYearID = @SeasonYearID,
					@AllSizeClasses = @AllSizeClasses,
					@CUser = @CUser,
					@CDate = @CDate,
					@ChangeTransID = NULL,
					@ChangeTransUserID = NULL,
					@ChangeTransPageName = NULL
					
			
		END
		ELSE
		BEGIN
		
			IF (SELECT ItemDim1TypeId FROM pStyleBOMDimension WHERE StyleBOMDimensionID = @StyleBOMDimensionID) = '00000000-0000-0000-0000-000000000000'
			BEGIN
				UPDATE pStyleBOMDimension SET 
					ItemDim1TypeId = (SELECT DimTypeID FROM pStyleBOMDimType WHERE DimTypeName = 'Color'),
					ItemDim1TypeName = 'Color'
				WHERE StyleBOMDimensionID = @StyleBOMDimensionID
				
				SET @DimLevel = 1
			END
			ELSE IF (SELECT ItemDim2TypeId FROM pStyleBOMDimension WHERE StyleBOMDimensionID = @StyleBOMDimensionID) = '00000000-0000-0000-0000-000000000000'
			BEGIN
				UPDATE pStyleBOMDimension SET 
					ItemDim2TypeId = (SELECT DimTypeID FROM pStyleBOMDimType WHERE DimTypeName = 'Color'),
					ItemDim2TypeName = 'Color'
				WHERE StyleBOMDimensionID = @StyleBOMDimensionID
				
				SET @DimLevel = 2
			END
			ELSE IF (SELECT ItemDim3TypeId FROM pStyleBOMDimension WHERE StyleBOMDimensionID = @StyleBOMDimensionID) = '00000000-0000-0000-0000-000000000000'
			BEGIN
				UPDATE pStyleBOMDimension SET 
					ItemDim3TypeId = (SELECT DimTypeID FROM pStyleBOMDimType WHERE DimTypeName = 'Color'),
					ItemDim3TypeName = 'Color'
				WHERE StyleBOMDimensionID = @StyleBOMDimensionID
				
				SET @DimLevel = 3
			END
			ELSE
			BEGIN
				SET @DimLevel = 0
			END
			
			IF @DimLevel <> 0
			BEGIN
				EXEC spx_StyleBOMColorways_Insert
						@ItemDimTypeId = NULL,
						@StyleBOMDimensionId = @StyleBOMDimensionID,
						@ColorPaletteID = @ColorPaletteID,
						@StyleID = @StyleID, 
						@StyleSet = @StyleSet ,
						@WorkflowID = @WorkflowID, 
						@WorkflowItemID = @WorkflowItemID,
						@DimLevel = @DimLevel
						
				SET @AllSizeClasses = 0
				IF (SELECT UPPER(AppSettingValue) FROM sAppSetting WHERE AppSettingKey = 'AllowSizeClassColorways') = 'TRUE'
					SET @AllSizeClasses = 1
					
				SELECT @SeasonYearID = pLineFolder.SeasonYearID FROM pLineFolder
					INNER JOIN pLineFolderItem ON pLineFolder.LineFolderID = pLineFolderItem.LineFolderID
				WHERE LineFolderItemID = @LineFolderItemID

				EXEC spx_StyleColorway_SeasonColor_INSERT
						@ColorPaletteID = @ColorPaletteID,
						@StyleID = @StyleID,
						@StyleSet = @StyleSet,
						@SeasonYearID = @SeasonYearID,
						@AllSizeClasses = @AllSizeClasses,
						@CUser = @CUser,
						@CDate = @CDate,
						@ChangeTransID = NULL,
						@ChangeTransUserID = NULL,
						@ChangeTransPageName = NULL

			END
			
		END
	
	
	END

END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06304', GetDate())
GO
