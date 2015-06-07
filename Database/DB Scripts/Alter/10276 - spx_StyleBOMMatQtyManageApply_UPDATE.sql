IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMMatQtyManageApply_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMMatQtyManageApply_UPDATE]
GO


create PROCEDURE [dbo].[spx_StyleBOMMatQtyManageApply_UPDATE] (
@MaterialQuantity nvarchar(50),
@StyleMaterialID nvarchar(50),
@ItemDimID nvarchar(50),
@StyleID nvarchar(50),
@Styleset int,
@StyleBOMDimensionId nvarchar(50),
@DimSize nvarchar(2),
@ApplyAll int,
@MUser nvarchar(200),
@MDate datetime
)

AS 	

Declare @ItemDim1TypeId nvarchar(50)	
Declare @ItemDim2TypeId nvarchar(50)	
Declare @ItemDim3TypeId nvarchar(50)
Declare @WorkflowID nvarchar(50)
Declare @WorkflowItemID nvarchar(50)
declare @Rowcnt int	

select @ItemDim1TypeId = ItemDim1TypeId, @ItemDim2TypeId = ItemDim2TypeId, @ItemDim3TypeId=ItemDim3TypeId,
@WorkflowID = WorkflowID, @WorkflowItemID = WorkflowItemID
from pStyleBOMDimension where StyleBOMDimensionId = @StyleBOMDimensionId 

CREATE TABLE #tmpDimItems (
	Rec_ID INT IDENTITY (1,1),
	ItemId NVARCHAR(50),
	Dim1ID NVARCHAR(50),
	Dim1Name 	NVARCHAR(200),	
	Dim2ID NVARCHAR(50),
	Dim2Name 	NVARCHAR(200),	
	Dim3ID NVARCHAR(50),
	Dim3Name 	NVARCHAR(200)			
	)	
	
Insert into #tmpDimItems (ItemId, Dim1ID, Dim1Name,
Dim2ID, Dim2Name, Dim3ID, Dim3Name)	
select StyleBOMDimensionItemId, ItemDim1Id, ItemDim1Name,
ItemDim2Id, ItemDim2Name, ItemDim3Id, ItemDim3Name from pStyleBOMDimensionItems
where StyleBOMDimensionId=@StyleBOMDimensionId and StyleBOMDimensionItemId not in (
select StyleBOMDimensionItemId from pstylebomitem where StyleMaterialID=@StyleMaterialID and 
StyleBOMDimensionId=@StyleBOMDimensionId)	

select @Rowcnt = Count(ItemId) from #tmpDimItems 

if @Rowcnt>0
	begin
		Insert into pstylebomitem (StyleBOMDimensionId, StyleBOMDimensionItemId, StyleMaterialID,
		WorkflowID, WorkflowItemID, StyleID, StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1ID, ItemDim1Name, ItemDim2ID, ItemDim2Name,
		ItemDim3ID, ItemDim3Name, CDate, CUser, MDate, MUser)		
		select @StyleBOMDimensionId, ItemId, @StyleMaterialID, @WorkflowID, @WorkflowItemID, @StyleID, @StyleSet,
		@ItemDim1TypeId, @ItemDim2TypeId, @ItemDim3TypeId,
		Dim1ID, Dim1Name, Dim2ID, Dim2Name, Dim3ID, Dim3Name, @MDate, @MUser, @MDate, @MUser from #tmpDimItems	
	end	
	
drop TABLE #tmpDimItems	

if @DimSize='1'
	begin
		update pstylebomitem set MaterialQuantity=@MaterialQuantity where StyleMaterialID=@StyleMaterialID
		and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim1Id=@ItemDimID and ItemDim1Id is not null		
	end
else if @DimSize='2'
	begin
		update pstylebomitem set MaterialQuantity=@MaterialQuantity where StyleMaterialID=@StyleMaterialID
		and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim2Id=@ItemDimID and ItemDim2Id is not null		
	end	
else if @DimSize='3'
	begin
		update pstylebomitem set MaterialQuantity=@MaterialQuantity where StyleMaterialID=@StyleMaterialID
		and StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim3Id=@ItemDimID and ItemDim3Id is not null		
	end	






GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10276', GetUTCDate())
GO
