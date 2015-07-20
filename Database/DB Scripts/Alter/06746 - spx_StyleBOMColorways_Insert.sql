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
@DimLevel Int
)
AS 
	
	Declare @ItemDim1TypeId nvarchar(50)	
	Declare @ItemDim2TypeId nvarchar(50)	
	Declare @ItemDim3TypeId nvarchar(50)	
	Declare @ColorCode nvarchar(200)
	Declare @ColorName nvarchar(200)
	Declare @ColorSort nvarchar(5)
	
	select @ItemDim1TypeId = ItemDim1TypeId, @ItemDim2TypeId = ItemDim2TypeId, @ItemDim3TypeId=ItemDim3TypeId
	from pStyleBOMDimension where StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50))
	
	select @ColorName=ColorName, @ColorCode=ColorCode, @ColorSort = COALESCE(cast(sort as int),0) from pColorPalette where ColorPaletteID=@ColorPaletteID
	
	begin											
		if @DimLevel=1
			begin
				IF NOT EXISTS(SELECT * FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionID = @StyleBOMDimensionId AND ItemDim1Id = @ColorPaletteID)
				BEGIN										
					INSERT INTO	pStyleBOMDimensionItem(StyleBOMDimensionId,	WorkflowID, WorkflowItemID,
					StyleID, StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1Id, ItemDim1Name
					,ItemDim1Sort) values (@StyleBOMDimensionId, @WorkflowID, @WorkflowItemID,
					@StyleID, @StyleSet, @ItemDim1TypeId, @ItemDim2TypeId, @ItemDim3TypeId, @ColorPaletteID, @ColorName
					,@ColorSort)
				END								
			end
		if @DimLevel=2
			begin
				IF NOT EXISTS(SELECT * FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionID = @StyleBOMDimensionId AND ItemDim2Id = @ColorPaletteID)
				BEGIN	
					INSERT INTO	pStyleBOMDimensionItem(StyleBOMDimensionId,	WorkflowID, WorkflowItemID,
					StyleID, StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim2Id, ItemDim2Name
					,ItemDim2Sort) values (@StyleBOMDimensionId, @WorkflowID, @WorkflowItemID,
					@StyleID, @StyleSet, @ItemDim1TypeId, @ItemDim2TypeId, @ItemDim3TypeId, @ColorPaletteID, @ColorName
					,@ColorSort)
				END				
			end
			
		if @DimLevel=3
			begin
				IF NOT EXISTS(SELECT * FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionID = @StyleBOMDimensionId AND ItemDim3Id = @ColorPaletteID)
				BEGIN	
					INSERT INTO	pStyleBOMDimensionItem(StyleBOMDimensionId,	WorkflowID, WorkflowItemID,
					StyleID, StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim3Id, ItemDim3Name
					,ItemDim3Sort) values (@StyleBOMDimensionId, @WorkflowID, @WorkflowItemID,
					@StyleID, @StyleSet, @ItemDim1TypeId, @ItemDim2TypeId, @ItemDim3TypeId, @ColorPaletteID, @ColorName
					,@ColorSort)
				END				
			end							
	end
	
	/* ----- add BOM color to Seasonal Colorway ------- */
	DECLARE @StyleSeasonYearID NVARCHAR(50)
	SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pWorkFlowItem WHERE WorkFlowItemID = @WorkflowItemID
	
	IF NOT EXISTS ( SELECT * FROM pStyleColorwaySeasonYear LEFT JOIN
		pStyleColorway ON pStyleColorwaySeasonYear.StyleColorwayID = pStyleColorway.StyleColorID
		WHERE StyleSeasonYearID = @StyleSeasonYearID 
		AND (pStyleColorwaySeasonYear.ColorPaletteID = @ColorPaletteID OR pStyleColorway.ColorPaletteID = @ColorPaletteID) )   
	BEGIN  
		DECLARE @StyleColorwaySeasonYearID UNIQUEIDENTIFIER
		SET @StyleColorwaySeasonYearID  = NEWID()
		
		INSERT INTO pStyleColorwaySeasonYear ( StyleColorwaySeasonYearID, StyleSeasonYearID , StyleColorwayID , StyleID,     
		  StyleColorDelivery1, StyleColorDelivery2, StyleColorDelivery3, StyleColorDelivery4, StyleColorStatus, Units, ColorType, ColorPaletteID )  
		VALUES  ( @StyleColorwaySeasonYearID, @StyleSeasonYearID , NULL , @StyleID,     
		  1, 1, 1, 1, 800, 0, 'F', @ColorPaletteID)  
	END
	/*-------------------------------------------------*/
	
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06746', GetDate())
GO
