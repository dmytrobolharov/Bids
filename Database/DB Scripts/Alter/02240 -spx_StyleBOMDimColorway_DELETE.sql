IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimColorway_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimColorway_DELETE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spx_StyleBOMDimColorway_DELETE] (
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


if @DimColor='1'
	begin
		update pstylebomitem set MaterialColorId = NULL where StyleMaterialID=@StyleMaterialID
		and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim1Id=@StyleColorID and ItemDim1Id is not null		
	end
else if @DimColor='2'
	begin
		update pstylebomitem set MaterialColorId = NULL where StyleMaterialID=@StyleMaterialID
		and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim2Id=@StyleColorID and ItemDim2Id is not null		
	end	
else if @DimColor='3'
	begin
		update pstylebomitem set MaterialColorId = NULL where StyleMaterialID=@StyleMaterialID
		and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim3Id=@StyleColorID and ItemDim3Id is not null		
	end	
	
if @AllColor=1
	begin	    
		if @DimColor='1'
			begin
				update pstylebomitem set MaterialColorId = NULL where StyleMaterialID=@StyleMaterialID
				and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim1Id in ( select
				distinct(ItemDim1Id) from pStyleBOMDimensionItems where StyleBOMDimensionId=@StyleBOMDimensionId
				and ItemDim1Id is not null) and ItemDim1Id is not null				
			end
		else if @DimColor='2'
			begin
				update pstylebomitem set MaterialColorId = NULL where StyleMaterialID=@StyleMaterialID
				and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim2Id in ( select
				distinct(ItemDim2Id) from pStyleBOMDimensionItems where StyleBOMDimensionId=@StyleBOMDimensionId
				and ItemDim2Id is not null) and ItemDim2Id is not null
			end	
		else if @DimColor='3'
			begin
				update pstylebomitem set MaterialColorId = NULL where StyleMaterialID=@StyleMaterialID
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
			end
		else if @DimSize='2'
			begin
				update pstylebomitem set MaterialColorId = NULL where StyleMaterialID=@StyleMaterialID
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
			end	
	end
	

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02240'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02240', GetDate())
END	
GO

