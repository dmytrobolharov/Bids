IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMItemMaterialPrice_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMItemMaterialPrice_Update]
GO


CREATE  PROCEDURE [dbo].[spx_StyleBOMItemMaterialPrice_Update](
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
		SELECT top 1 CAST(MaterialPrice AS FLOAT) FROM pstylebomitem  WHERE StyleMaterialID = @StyleMaterialID 
		and  ItemDim1Id =@DimRowId and ItemDim2Id = @DimColumnId and ItemDim3Id = @DimTabId
	end
else
	begin
		If @DimRow <> '' 
			begin
				If @DimRow = '1' 
					begin
						If @DimColumn = '2' 
							begin
								SELECT top 1 CAST(MaterialPrice AS FLOAT) FROM pstylebomitem  WHERE StyleMaterialID = @StyleMaterialID 
								and  ItemDim1Id =@DimRowId and ItemDim2Id = @DimColumnId
							end
						Else If @DimColumn = '3'
							begin
								SELECT top 1 CAST(MaterialPrice AS FLOAT) FROM pstylebomitem  WHERE StyleMaterialID = @StyleMaterialID
								and  ItemDim1Id =@DimRowId and ItemDim3Id = @DimColumnId
							end	
						end		
				 Else If @DimRow = '2'
					begin 
						If @DimColumn = '3' 
							begin
								SELECT top 1 CAST(MaterialPrice AS FLOAT) FROM pstylebomitem  WHERE StyleMaterialID = @StyleMaterialID
								and  ItemDim2Id =@DimRowId and ItemDim3Id = @DimColumnId
							end
						
					end		
			end
		else
			begin
				If @DimColumn = '1' 
					begin
						SELECT top 1 CAST(MaterialPrice AS FLOAT) FROM pstylebomitem  WHERE StyleMaterialID = @StyleMaterialID
						and  ItemDim1Id =@DimColumnId
					end   
				else If @DimColumn = '2' 
					begin
						SELECT top 1 CAST(MaterialPrice AS FLOAT) FROM pstylebomitem  WHERE StyleMaterialID = @StyleMaterialID
						and  ItemDim2Id = @DimColumnId
					end 
				else If @DimColumn = '3' 
					begin
						SELECT top 1 CAST(MaterialPrice AS FLOAT) FROM pstylebomitem  WHERE StyleMaterialID = @StyleMaterialID
						and  ItemDim3Id =@DimColumnId
					end
			end
   
	end


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06771', GetDate())
GO
