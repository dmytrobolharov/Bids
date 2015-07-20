IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMItemQuantityTSG_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMItemQuantityTSG_Update]
GO

Create  PROCEDURE [dbo].[spx_StyleBOMItemQuantityTSG_Update](
@StyleMaterialID nvarchar(50),
@StyleBOMDimensionId nvarchar(50),
@StyleID nvarchar(50), 
@StyleSet INT ,
@WorkflowID nvarchar(50), 
@WorkflowItemID nvarchar(50),
@DimRow nvarchar(5),
@DimColumn nvarchar(5),
@DimTab nvarchar(5),
@DimRowId nvarchar(50),
@DimColumnId nvarchar(50),
@DimTabId nvarchar(50)
)
AS 
If @DimTab <> '' 
	begin
		SELECT top 1 MaterialQuantity, MaterialDimension FROM pstylebomitem  
		INNER JOIN pStyleBOMDimensionItems ON pStyleBOMItem.StyleBOMDimensionID = pStyleBOMDimensionItems.StyleBOMDimensionID 
		AND (pStyleBOMItem.ItemDim1Id = pStyleBOMDimensionItems.ItemDim1Id OR pStyleBOMItem.ItemDim1Id IS NULL AND pStyleBOMDimensionItems.ItemDim1Id IS NULL)
		AND (pStyleBOMItem.ItemDim2Id = pStyleBOMDimensionItems.ItemDim2Id OR pStyleBOMItem.ItemDim2Id IS NULL AND pStyleBOMDimensionItems.ItemDim2Id IS NULL)
		AND (pStyleBOMItem.ItemDim3Id = pStyleBOMDimensionItems.ItemDim3Id OR pStyleBOMItem.ItemDim3Id IS NULL AND pStyleBOMDimensionItems.ItemDim3Id IS NULL)
		where StyleMaterialID = @StyleMaterialID and pStyleBOMItem.StyleBOMDimensionId = @StyleBOMDimensionId
		AND pStyleBOMDimensionItems.ItemDim1Active = 1 AND pStyleBOMDimensionItems.ItemDim2Active = 1 AND pStyleBOMDimensionItems.ItemDim3Active = 1
		and  pstylebomitem.ItemDim1Id =@DimRowId and pstylebomitem.ItemDim2Id = @DimColumnId and pstylebomitem.ItemDim3Id = @DimTabId
	end
else
	begin
		If @DimRow <> '' 
			begin
				If @DimRow = '1' 
					begin
						If @DimColumn = '2' 
							begin
								SELECT top 1 MaterialQuantity, MaterialDimension FROM pstylebomitem  
								INNER JOIN pStyleBOMDimensionItems ON pStyleBOMItem.StyleBOMDimensionID = pStyleBOMDimensionItems.StyleBOMDimensionID 
								AND (pStyleBOMItem.ItemDim1Id = pStyleBOMDimensionItems.ItemDim1Id OR pStyleBOMItem.ItemDim1Id IS NULL AND pStyleBOMDimensionItems.ItemDim1Id IS NULL)
								AND (pStyleBOMItem.ItemDim2Id = pStyleBOMDimensionItems.ItemDim2Id OR pStyleBOMItem.ItemDim2Id IS NULL AND pStyleBOMDimensionItems.ItemDim2Id IS NULL)
								AND (pStyleBOMItem.ItemDim3Id = pStyleBOMDimensionItems.ItemDim3Id OR pStyleBOMItem.ItemDim3Id IS NULL AND pStyleBOMDimensionItems.ItemDim3Id IS NULL)
								where StyleMaterialID = @StyleMaterialID and pStyleBOMItem.StyleBOMDimensionId = @StyleBOMDimensionId
								AND pStyleBOMDimensionItems.ItemDim1Active = 1 AND pStyleBOMDimensionItems.ItemDim2Active = 1 AND pStyleBOMDimensionItems.ItemDim3Active = 1
								and pStyleBOMItem.ItemDim1Id =@DimRowId and pStyleBOMItem.ItemDim2Id = @DimColumnId
							end
						Else If @DimColumn = '3'
							begin
								SELECT top 1 MaterialQuantity, MaterialDimension FROM pstylebomitem  
								INNER JOIN pStyleBOMDimensionItems ON pStyleBOMItem.StyleBOMDimensionID = pStyleBOMDimensionItems.StyleBOMDimensionID 
								AND (pStyleBOMItem.ItemDim1Id = pStyleBOMDimensionItems.ItemDim1Id OR pStyleBOMItem.ItemDim1Id IS NULL AND pStyleBOMDimensionItems.ItemDim1Id IS NULL)
								AND (pStyleBOMItem.ItemDim2Id = pStyleBOMDimensionItems.ItemDim2Id OR pStyleBOMItem.ItemDim2Id IS NULL AND pStyleBOMDimensionItems.ItemDim2Id IS NULL)
								AND (pStyleBOMItem.ItemDim3Id = pStyleBOMDimensionItems.ItemDim3Id OR pStyleBOMItem.ItemDim3Id IS NULL AND pStyleBOMDimensionItems.ItemDim3Id IS NULL)
								where StyleMaterialID = @StyleMaterialID and pStyleBOMItem.StyleBOMDimensionId = @StyleBOMDimensionId
								AND pStyleBOMDimensionItems.ItemDim1Active = 1 AND pStyleBOMDimensionItems.ItemDim2Active = 1 AND pStyleBOMDimensionItems.ItemDim3Active = 1
								and pStyleBOMItem.ItemDim1Id =@DimRowId and pStyleBOMItem.ItemDim3Id = @DimColumnId
							end	
						end		
				 Else If @DimRow = '2'
					begin 
						If @DimColumn = '3' 
							begin
								SELECT top 1 MaterialQuantity, MaterialDimension FROM pstylebomitem  
								INNER JOIN pStyleBOMDimensionItems ON pStyleBOMItem.StyleBOMDimensionID = pStyleBOMDimensionItems.StyleBOMDimensionID 
								AND (pStyleBOMItem.ItemDim1Id = pStyleBOMDimensionItems.ItemDim1Id OR pStyleBOMItem.ItemDim1Id IS NULL AND pStyleBOMDimensionItems.ItemDim1Id IS NULL)
								AND (pStyleBOMItem.ItemDim2Id = pStyleBOMDimensionItems.ItemDim2Id OR pStyleBOMItem.ItemDim2Id IS NULL AND pStyleBOMDimensionItems.ItemDim2Id IS NULL)
								AND (pStyleBOMItem.ItemDim3Id = pStyleBOMDimensionItems.ItemDim3Id OR pStyleBOMItem.ItemDim3Id IS NULL AND pStyleBOMDimensionItems.ItemDim3Id IS NULL)
								where StyleMaterialID = @StyleMaterialID and pStyleBOMItem.StyleBOMDimensionId = @StyleBOMDimensionId
								AND pStyleBOMDimensionItems.ItemDim1Active = 1 AND pStyleBOMDimensionItems.ItemDim2Active = 1 AND pStyleBOMDimensionItems.ItemDim3Active = 1
								and pStyleBOMItem.ItemDim2Id =@DimRowId and pStyleBOMItem.ItemDim3Id = @DimColumnId
							end
						
					end		
			end
		else
			begin
				If @DimColumn = '1' 
					begin
						SELECT top 1 MaterialQuantity, MaterialDimension FROM pstylebomitem  
						INNER JOIN pStyleBOMDimensionItems ON pStyleBOMItem.StyleBOMDimensionID = pStyleBOMDimensionItems.StyleBOMDimensionID 
						AND (pStyleBOMItem.ItemDim1Id = pStyleBOMDimensionItems.ItemDim1Id OR pStyleBOMItem.ItemDim1Id IS NULL AND pStyleBOMDimensionItems.ItemDim1Id IS NULL)
						AND (pStyleBOMItem.ItemDim2Id = pStyleBOMDimensionItems.ItemDim2Id OR pStyleBOMItem.ItemDim2Id IS NULL AND pStyleBOMDimensionItems.ItemDim2Id IS NULL)
						AND (pStyleBOMItem.ItemDim3Id = pStyleBOMDimensionItems.ItemDim3Id OR pStyleBOMItem.ItemDim3Id IS NULL AND pStyleBOMDimensionItems.ItemDim3Id IS NULL)
						where StyleMaterialID = @StyleMaterialID and pStyleBOMItem.StyleBOMDimensionId = @StyleBOMDimensionId
						AND pStyleBOMDimensionItems.ItemDim1Active = 1 AND pStyleBOMDimensionItems.ItemDim2Active = 1 AND pStyleBOMDimensionItems.ItemDim3Active = 1
						and pStyleBOMItem.ItemDim1Id =@DimColumnId
					end   
				else If @DimColumn = '2' 
					begin
						SELECT top 1 MaterialQuantity, MaterialDimension FROM pstylebomitem  
						INNER JOIN pStyleBOMDimensionItems ON pStyleBOMItem.StyleBOMDimensionID = pStyleBOMDimensionItems.StyleBOMDimensionID 
						AND (pStyleBOMItem.ItemDim1Id = pStyleBOMDimensionItems.ItemDim1Id OR pStyleBOMItem.ItemDim1Id IS NULL AND pStyleBOMDimensionItems.ItemDim1Id IS NULL)
						AND (pStyleBOMItem.ItemDim2Id = pStyleBOMDimensionItems.ItemDim2Id OR pStyleBOMItem.ItemDim2Id IS NULL AND pStyleBOMDimensionItems.ItemDim2Id IS NULL)
						AND (pStyleBOMItem.ItemDim3Id = pStyleBOMDimensionItems.ItemDim3Id OR pStyleBOMItem.ItemDim3Id IS NULL AND pStyleBOMDimensionItems.ItemDim3Id IS NULL)
						where StyleMaterialID = @StyleMaterialID and pStyleBOMItem.StyleBOMDimensionId = @StyleBOMDimensionId
						AND pStyleBOMDimensionItems.ItemDim1Active = 1 AND pStyleBOMDimensionItems.ItemDim2Active = 1 AND pStyleBOMDimensionItems.ItemDim3Active = 1
						and pStyleBOMItem.ItemDim2Id = @DimColumnId
					end 
				else If @DimColumn = '3' 
					begin
						SELECT top 1 MaterialQuantity, MaterialDimension FROM pstylebomitem  
						INNER JOIN pStyleBOMDimensionItems ON pStyleBOMItem.StyleBOMDimensionID = pStyleBOMDimensionItems.StyleBOMDimensionID 
						AND (pStyleBOMItem.ItemDim1Id = pStyleBOMDimensionItems.ItemDim1Id OR pStyleBOMItem.ItemDim1Id IS NULL AND pStyleBOMDimensionItems.ItemDim1Id IS NULL)
						AND (pStyleBOMItem.ItemDim2Id = pStyleBOMDimensionItems.ItemDim2Id OR pStyleBOMItem.ItemDim2Id IS NULL AND pStyleBOMDimensionItems.ItemDim2Id IS NULL)
						AND (pStyleBOMItem.ItemDim3Id = pStyleBOMDimensionItems.ItemDim3Id OR pStyleBOMItem.ItemDim3Id IS NULL AND pStyleBOMDimensionItems.ItemDim3Id IS NULL)
						where StyleMaterialID = @StyleMaterialID and pStyleBOMItem.StyleBOMDimensionId = @StyleBOMDimensionId
						AND pStyleBOMDimensionItems.ItemDim1Active = 1 AND pStyleBOMDimensionItems.ItemDim2Active = 1 AND pStyleBOMDimensionItems.ItemDim3Active = 1
						and pStyleBOMItem.ItemDim3Id =@DimColumnId
					end
			end
   
	end

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08714', GetDate())
GO

