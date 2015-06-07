IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimMaterialQty3D_Delete]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimMaterialQty3D_Delete]
GO


CREATE PROCEDURE [dbo].[spx_StyleBOMDimMaterialQty3D_Delete] (
@StyleMaterialID nvarchar(50),
@DimRowId nvarchar(50),
@DimColId nvarchar(50),
@DimValue nVarchar(50),
@StyleBOMDimensionId nvarchar(50),
@StyleID nvarchar(50), 
@StyleSet INT ,
@WorkflowID nvarchar(50), 
@WorkflowItemID nvarchar(50),
@ApplyAll int
)
AS 	


Declare @ItemDim1TypeId nvarchar(50)	
Declare @ItemDim2TypeId nvarchar(50)	
Declare @ItemDim3TypeId nvarchar(50)	
Declare @Matcnt int
Declare @DimCnt int
Declare @Row_Loop int
Declare @Row_Count int

CREATE TABLE #tmpDimSizeItem (
	Rec_ID INT IDENTITY (1,1),
	ItemId NVARCHAR(50),
	Dim1ID NVARCHAR(50),
	Dim1Name 	NVARCHAR(200),
	Dim1Sort int,
	Dim2ID NVARCHAR(50),
	Dim2Name 	NVARCHAR(200),
	Dim2Sort int,
	Dim3ID NVARCHAR(50),
	Dim3Name 	NVARCHAR(200),
	Dim3Sort int			
	)	

--select @StyleBOMDimensionId as 	StyleBOMDimensionId

select @ItemDim1TypeId = ItemDim1TypeId, @ItemDim2TypeId = ItemDim2TypeId, @ItemDim3TypeId=ItemDim3TypeId
from pStyleBOMDimension where StyleBOMDimensionId = @StyleBOMDimensionId 

select @ItemDim1TypeId as ItemDim1TypeId
select @ItemDim2TypeId as ItemDim2TypeId
select @ItemDim3TypeId as ItemDim3TypeId

select @Matcnt = Count(StyleMaterialID) from pstylebomitem where StyleMaterialID = @StyleMaterialID 

select @DimCnt = COUNT(StyleBOMDimensionId) from pStyleBOMDimensionItems where StyleBOMDimensionId = @StyleBOMDimensionId and 
		ItemDim1Active=1 and ItemDim2Active=1 and ItemDim3Active=1

if @ApplyAll<>1
	begin
		select 2 as DimColNo2
		insert into #tmpDimSizeItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, Dim2ID, Dim2Name, 
		Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)
		select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, psi.ItemDim2Id, ItemDim2Name,
		ItemDim2Sort, psi.ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems psi
		inner join pStyleBOMDimensionComboItems psci on psi.ItemDim2Id = psci.ItemDim2Id And psi.ItemDim3Id = psci.ItemDim3Id
		where psci.StyleBOMDimensionId = @StyleBOMDimensionId and ItemDim1Active=1 and ItemDim2Active=1
		and ItemDim3Active=1 and ItemDim1ID=@DimRowId and psci.StyleBOMDimensionComboItemID=@DimColId
		order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name
	end
else
	begin
		insert into #tmpDimSizeItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, Dim2ID, Dim2Name, 
		Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)
		select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, ItemDim2ID, ItemDim2Name,
		ItemDim2Sort, ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems where 
		StyleBOMDimensionId = @StyleBOMDimensionId and ItemDim1Active=1 and ItemDim2Active=1
		and ItemDim3Active=1 				
		order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name
	end
select @Row_Count = Count(StyleMaterialID) from pstylebomitem where StyleMaterialID=@StyleMaterialID and StyleBOMDimensionItemId in (select ItemId from 
#tmpDimSizeItem) 

--select * from #tmpDimSizeItem

--select @Row_Count as Row_Count

if @Row_Count>0
	begin					
	 Update pstylebomitem set MaterialQuantity=@DimValue from pstylebomitem b
	 inner join #tmpDimSizeItem t  on b.StyleBOMDimensionItemId=t.ItemId
	 where b.StyleMaterialID=@StyleMaterialID   									
	end

drop table #tmpDimSizeItem


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10260', GetUTCDate())
GO
