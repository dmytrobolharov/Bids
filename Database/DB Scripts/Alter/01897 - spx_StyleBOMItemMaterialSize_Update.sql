IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMItemMaterialSize_Update]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleBOMItemMaterialSize_Update]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleBOMItemMaterialSize_Update]    Script Date: 09/06/2011 13:39:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create  PROCEDURE [dbo].[spx_StyleBOMItemMaterialSize_Update](
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

Declare @MaterialSizeId nvarchar(50)
Declare  @MaterialId nvarchar(50)

SELECT @MaterialId =  MaterialId FROM pstylebom  WHERE StyleMaterialID = @StyleMaterialID 

If @DimTab <> '' 
	begin
		SELECT top 1 @MaterialSizeId =  MaterialDimension FROM pstylebomitem  WHERE StyleMaterialID = @StyleMaterialID 
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
								SELECT top 1 @MaterialSizeId =  MaterialDimension FROM pstylebomitem  WHERE StyleMaterialID = @StyleMaterialID 
								and  ItemDim1Id =@DimRowId and ItemDim2Id = @DimColumnId
							end
						Else If @DimColumn = '3'
							begin
								SELECT top 1 @MaterialSizeId =  MaterialDimension FROM pstylebomitem  WHERE StyleMaterialID = @StyleMaterialID
								and  ItemDim1Id =@DimRowId and ItemDim3Id = @DimColumnId
							end	
						end		
				 Else If @DimRow = '2'
					begin 
						If @DimColumn = '3' 
							begin
								SELECT top 1 @MaterialSizeId =  MaterialDimension FROM pstylebomitem  WHERE StyleMaterialID = @StyleMaterialID
								and  ItemDim2Id =@DimRowId and ItemDim3Id = @DimColumnId
							end
						
					end		
			end
		else
			begin
				If @DimColumn = '1' 
					begin
						SELECT top 1 @MaterialSizeId =  MaterialDimension FROM pstylebomitem  WHERE StyleMaterialID = @StyleMaterialID
						and  ItemDim1Id =@DimColumnId
					end   
				else If @DimColumn = '2' 
					begin
						SELECT top 1 @MaterialSizeId =  MaterialDimension FROM pstylebomitem  WHERE StyleMaterialID = @StyleMaterialID
						and  ItemDim2Id = @DimColumnId
					end 
				else If @DimColumn = '3' 
					begin
						SELECT top 1 @MaterialSizeId =  MaterialDimension FROM pstylebomitem  WHERE StyleMaterialID = @StyleMaterialID
						and  ItemDim3Id =@DimColumnId
					end
			end
   
	end

   select MaterialSizeID, MaterialSize   from pMaterialSize where 
   MaterialSizeID = @MaterialSizeId and MaterialId = @MaterialId
        
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01897'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01897', GetDate())
END

GO