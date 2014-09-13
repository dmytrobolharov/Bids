/****** Object:  StoredProcedure [dbo].[spx_StyleBOMColorways_Insert]    Script Date: 05/17/2013 13:19:30 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMColorways_Insert]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMColorways_Insert]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBOMColorways_Insert]    Script Date: 05/17/2013 13:19:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
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
	Declare @ColorName nvarchar(100)
	Declare @ColorSort nvarchar(5)
	
	select @ItemDim1TypeId = ItemDim1TypeId, @ItemDim2TypeId = ItemDim2TypeId, @ItemDim3TypeId=ItemDim3TypeId
	from pStyleBOMDimension where StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50))
	
	select @ColorName=ColorName, @ColorSort = COALESCE(cast(sort as int),0) from pColorPalette where ColorPaletteID=@ColorPaletteID
	
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
	
	

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05687', GetDate())
GO
