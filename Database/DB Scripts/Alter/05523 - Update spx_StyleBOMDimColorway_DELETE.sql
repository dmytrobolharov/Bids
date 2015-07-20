IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimColorway_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimColorway_DELETE]
GO


CREATE PROCEDURE [dbo].[spx_StyleBOMDimColorway_DELETE](
@StyleMaterialID nvarchar(50),
@StyleColorID nvarchar(50),
@StyleID nvarchar(50),
@Styleset int,
@StyleBOMDimensionId nvarchar(50),
@AllColor int,
@AllSize int,
@DimColor nVarchar(2),
@DimSize nVarchar(2),
@MUser nvarchar(200),
@MDate datetime
)
AS 	

Declare @ItemDim1TypeId nvarchar(50)	
Declare @ItemDim2TypeId nvarchar(50)	
Declare @ItemDim3TypeId nvarchar(50)
Declare @WorkflowID nvarchar(50)
Declare @WorkflowItemID nvarchar(50)

if @DimColor<>''
	begin
		if @DimColor='1'
			begin
				update pStyleBOMItem set MaterialColorId = NULL where StyleMaterialID=@StyleMaterialID
				and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim1Id=@StyleColorID and ItemDim1Id is not null		
				
				select StyleBOMItemID
				  from pStyleBOMItem
				 where StyleMaterialID=@StyleMaterialID
				   and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim1Id=@StyleColorID and ItemDim1Id is not null		
			end
		else if @DimColor='2'
			begin
				update pStyleBOMItem set MaterialColorId = NULL where StyleMaterialID=@StyleMaterialID
				and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim2Id=@StyleColorID and ItemDim2Id is not null		
				
				select StyleBOMItemID
				  from pStyleBOMItem
				 where StyleMaterialID=@StyleMaterialID
				   and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim2Id=@StyleColorID and ItemDim2Id is not null		
			end	
		else if @DimColor='3'
			begin
				update pStyleBOMItem set MaterialColorId = NULL where StyleMaterialID=@StyleMaterialID
				and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim3Id=@StyleColorID and ItemDim3Id is not null		
				
				select StyleBOMItemID
				  from pStyleBOMItem
				 where StyleMaterialID=@StyleMaterialID
				   and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim3Id=@StyleColorID and ItemDim3Id is not null		
			end	
	end
else
	begin
		update pStyleBOM set MaterialColorId=NULL where StyleMaterialID=@StyleMaterialID
		and StyleBOMDimensionId=@StyleBOMDimensionId
		
		select StyleMaterialID
		  from pStyleBOM
		 where StyleMaterialID=@StyleMaterialID
		   and StyleBOMDimensionId=@StyleBOMDimensionId
	end
	
		
if @AllColor=1
	begin	    
		if @DimColor='1'
			begin
				update pStyleBOMItem set MaterialColorId = NULL where StyleMaterialID=@StyleMaterialID
				and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim1Id in ( select
				distinct(ItemDim1Id) from pStyleBOMDimensionItems where StyleBOMDimensionId=@StyleBOMDimensionId
				and ItemDim1Id is not null) and ItemDim1Id is not null				
				
				select StyleBOMItemID
				  from pStyleBOMItem
				 where StyleMaterialID=@StyleMaterialID
				   and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim1Id in ( select
				       distinct(ItemDim1Id) from pStyleBOMDimensionItems where StyleBOMDimensionId=@StyleBOMDimensionId
				   and ItemDim1Id is not null) and ItemDim1Id is not null				
				  
			end
		else if @DimColor='2'
			begin
				update pStyleBOMItem set MaterialColorId = NULL where StyleMaterialID=@StyleMaterialID
				and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim2Id in ( select
				distinct(ItemDim2Id) from pStyleBOMDimensionItems where StyleBOMDimensionId=@StyleBOMDimensionId
				and ItemDim2Id is not null) and ItemDim2Id is not null
				
				select StyleBOMItemID
				  from pStyleBOMItem
				 where StyleMaterialID=@StyleMaterialID
				   and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim2Id in ( select
				       distinct(ItemDim2Id) from pStyleBOMDimensionItems where StyleBOMDimensionId=@StyleBOMDimensionId
				       and ItemDim2Id is not null) and ItemDim2Id is not null
				
			end	
		else if @DimColor='3'
			begin
				update pStyleBOMItem set MaterialColorId = NULL where StyleMaterialID=@StyleMaterialID
				and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim3Id in ( select
				distinct(ItemDim3Id) from pStyleBOMDimensionItems where StyleBOMDimensionId=@StyleBOMDimensionId
				and ItemDim3Id is not null) and ItemDim3Id is not null
				
				select StyleBOMItemID
				  from pStyleBOMItem
				 where StyleMaterialID=@StyleMaterialID
				   and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim3Id in ( select
				       distinct(ItemDim3Id) from pStyleBOMDimensionItems where StyleBOMDimensionId=@StyleBOMDimensionId
				       and ItemDim3Id is not null) and ItemDim3Id is not null
				  
			end	
	end
		
			
if @AllSize=1
	begin
		if @DimSize='1'
			begin
				update pstylebomitem set MaterialColorId = NULL where StyleMaterialID=@StyleMaterialID
				and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim1Id in ( select
				distinct(ItemDim1Id) from pStyleBOMDimensionItems where StyleBOMDimensionId=@StyleBOMDimensionId
				and ItemDim1Id is not null) and ItemDim1Id is not null
				
				select StyleBOMItemID
				  from pStyleBOMItem
				 where StyleMaterialID=@StyleMaterialID
				   and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim1Id in ( select
				       distinct(ItemDim1Id) from pStyleBOMDimensionItems where StyleBOMDimensionId=@StyleBOMDimensionId
				       and ItemDim1Id is not null) and ItemDim1Id is not null
				
			end
		else if @DimSize='2'
			begin
				update pstylebomitem set MaterialColorId = NULL where StyleMaterialID=@StyleMaterialID
				and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim2Id in ( select
				distinct(ItemDim2Id) from pStyleBOMDimensionItems where StyleBOMDimensionId=@StyleBOMDimensionId
				and ItemDim2Id is not null) and ItemDim2Id is not null
				
				select StyleBOMItemID
				  from pStyleBOMItem
				 where StyleMaterialID=@StyleMaterialID
				       and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim2Id in ( select
				       distinct(ItemDim2Id) from pStyleBOMDimensionItems where StyleBOMDimensionId=@StyleBOMDimensionId
				       and ItemDim2Id is not null) and ItemDim2Id is not null
				
			end	
		else if @DimSize='3'
			begin
				update pstylebomitem set MaterialColorId = NULL where StyleMaterialID=@StyleMaterialID
				and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim3Id in ( select
				distinct(ItemDim3Id) from pStyleBOMDimensionItems where StyleBOMDimensionId=@StyleBOMDimensionId
				and ItemDim3Id is not null) and ItemDim3Id is not null
				
				select StyleBOMItemID
				  from pStyleBOMItem
				 where StyleMaterialID=@StyleMaterialID
				       and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim3Id in ( select
				       distinct(ItemDim3Id) from pStyleBOMDimensionItems where StyleBOMDimensionId=@StyleBOMDimensionId
				       and ItemDim3Id is not null) and ItemDim3Id is not null
				 
			end	
	end
	
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05523', GetDate())
GO


