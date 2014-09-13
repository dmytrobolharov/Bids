IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMColorways_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMColorways_Insert]
GO



CREATE  PROCEDURE [dbo].[spx_StyleBOMColorways_Insert](
@ItemDimTypeId nvarchar(50),
@StyleBOMDimensionId nvarchar(50),
@ColorPaletteID nvarchar(50),
@StyleID nvarchar(50), 
@StyleSet INT ,
@WorkflowID nvarchar(50), 
@WorkflowItemID nvarchar(50),
@DimLevel Int,
@CUser NVARCHAR(200) = 'System',
@CDate DATETIME = NULL,
@SetActiveIfColorExistsAndIsNotActive INT = 0
)
AS 
	
	Declare @ItemDim1TypeId nvarchar(50)	
	Declare @ItemDim2TypeId nvarchar(50)	
	Declare @ItemDim3TypeId nvarchar(50)	
	Declare @ColorName nvarchar(100)
	DECLARE @ColorCode NVARCHAR(200)
	Declare @ColorSort nvarchar(5)
	DECLARE @StyleColorID UNIQUEIDENTIFIER
	DECLARE @SeasonYearID UNIQUEIDENTIFIER
	
	select @ItemDim1TypeId = ItemDim1TypeId, @ItemDim2TypeId = ItemDim2TypeId, @ItemDim3TypeId=ItemDim3TypeId
	from pStyleBOMDimension where StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50))
	
	SELECT @SeasonYearID = ssy.SeasonYearID FROM pStyleBOMDimension bomdim 
	INNER JOIN pWorkflowItem item ON bomdim.WorkFlowItemID = item.WorkFlowItemID AND bomdim.StyleBOMDimensionID = @StyleBOMDimensionId
	INNER JOIN pStyleSeasonYear ssy ON item.StyleSeasonYearID = ssy.StyleSeasonYearID
	
	select @ColorName=ColorName, @ColorCode = ColorCode, @ColorSort = COALESCE(cast(sort as int),0)
	FROM pColorPalette 
	WHERE ColorPaletteID=@ColorPaletteID
	
	IF @CDate IS NULL
		SET @CDate = CURRENT_TIMESTAMP
	
	-- Inserting the Color to the Colorway, if it doesn't already have it
	EXEC spx_StyleColorway_Color_INSERT_SELECT @StyleID, 
											@ColorPaletteID, 
											@ColorCode,
											@ColorName,
											@SeasonYearID, 
											@StyleColorID OUT,
											@CUser, 
											@CDate
	
	begin											
		if @DimLevel=1
			begin
				IF NOT EXISTS(SELECT * FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionID = @StyleBOMDimensionId AND ItemDim1Id = @StyleColorID)
				BEGIN										
					INSERT INTO	pStyleBOMDimensionItem(StyleBOMDimensionId,	WorkflowID, WorkflowItemID,
					StyleID, StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1Id, ItemDim1Name
					,ItemDim1Sort) values (@StyleBOMDimensionId, @WorkflowID, @WorkflowItemID,
					@StyleID, @StyleSet, @ItemDim1TypeId, @ItemDim2TypeId, @ItemDim3TypeId, @StyleColorID, @ColorName
					,@ColorSort)
				END
				ELSE
				BEGIN
					IF @SetActiveIfColorExistsAndIsNotActive = 1
					BEGIN
						UPDATE pStyleBOMDimensionItem SET ItemDim1Active = 1 WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim1Id = @StyleColorID
						UPDATE pStyleBOMDimensionItems SET ItemDim1Active = 1 WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim1Id = @StyleColorID
					END
				END
			end
		if @DimLevel=2
			begin
				IF NOT EXISTS(SELECT * FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionID = @StyleBOMDimensionId AND ItemDim2Id = @StyleColorID)
				BEGIN	
					INSERT INTO	pStyleBOMDimensionItem(StyleBOMDimensionId,	WorkflowID, WorkflowItemID,
					StyleID, StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim2Id, ItemDim2Name
					,ItemDim2Sort) values (@StyleBOMDimensionId, @WorkflowID, @WorkflowItemID,
					@StyleID, @StyleSet, @ItemDim1TypeId, @ItemDim2TypeId, @ItemDim3TypeId, @StyleColorID, @ColorName
					,@ColorSort)
				END
				ELSE
				BEGIN
					IF @SetActiveIfColorExistsAndIsNotActive = 1
					BEGIN
						UPDATE pStyleBOMDimensionItem SET ItemDim2Active = 1 WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim2Id = @StyleColorID
						UPDATE pStyleBOMDimensionItems SET ItemDim2Active = 1 WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim2Id = @StyleColorID
					END
				END
			end
			
		if @DimLevel=3
			begin
				IF NOT EXISTS(SELECT * FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionID = @StyleBOMDimensionId AND ItemDim3Id = @StyleColorID)
				BEGIN	
					INSERT INTO	pStyleBOMDimensionItem(StyleBOMDimensionId,	WorkflowID, WorkflowItemID,
					StyleID, StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim3Id, ItemDim3Name
					,ItemDim3Sort) values (@StyleBOMDimensionId, @WorkflowID, @WorkflowItemID,
					@StyleID, @StyleSet, @ItemDim1TypeId, @ItemDim2TypeId, @ItemDim3TypeId, @StyleColorID, @ColorName
					,@ColorSort)
				END
				ELSE
				BEGIN
					IF @SetActiveIfColorExistsAndIsNotActive = 1
					BEGIN
						UPDATE pStyleBOMDimensionItem SET ItemDim3Active = 1 WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim3Id = @StyleColorID
						UPDATE pStyleBOMDimensionItems SET ItemDim3Active = 1 WHERE StyleBOMDimensionID = @StyleBOMDimensionID AND ItemDim3Id = @StyleColorID
					END
				END
			end							
	end
	
	
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '07497', GetDate())
GO
