IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMSizeRange_Add]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMSizeRange_Add]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[spx_StyleBOMSizeRange_Add] (

@ItemDimTypeId UNIQUEIDENTIFIER,
@StyleBOMDimensionId UNIQUEIDENTIFIER,
@StyleID UNIQUEIDENTIFIER, 
@StyleSet INT ,
@WorkflowID UNIQUEIDENTIFIER, 
@WorkflowItemID UNIQUEIDENTIFIER,
@DimLevel int
)

AS 	

Declare @ItemDim1TypeId nvarchar(50)	
Declare @ItemDim2TypeId nvarchar(50)	
Declare @ItemDim3TypeId nvarchar(50)	
Declare @Amlmeashdrid nvarchar(50)	
Declare @SizeRangeDetailId nvarchar(50)
Declare @ItemDimTypeItemId nvarchar(50)

CREATE TABLE #tmpSizeItem (
	Rec_ID INT IDENTITY (1,1),
	DimID NVARCHAR(50),
	DimName 	NVARCHAR(50),	
	Sort NVARCHAR(5)		
	)
	
select @ItemDim1TypeId = ItemDim1TypeId, @ItemDim2TypeId = ItemDim2TypeId, @ItemDim3TypeId=ItemDim3TypeId
from pStyleBOMDimension where StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50))
		
begin											
	if @DimLevel=1
		begin														
			select top 1 @amlmeashdrid = amlmeashdrid , @ItemDimTypeItemId = sizerangeid   from pStyleBOMDimensionItem where 
			StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50)) and 	
			ItemDim1TypeId = cast(@ItemDimTypeId as nvarchar(50)) and ItemDim1Id is not null 				
			order by ItemDim1Sort, ItemDim1name	

			INSERT INTO #tmpSizeItem (DimID, DimName, Sort)
			select SizeRangeDetailId, MeasLbl, Sizecol from pamlmeaslbl where
			amlmeashdrid = @amlmeashdrid and Isvisible=1 and SizeRangeId = @ItemDimTypeItemId and SizeRangeDetailId not in ( select 
			ItemDim1Id from pStyleBOMDimensionItem where 
			StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50)) and 	
			ItemDim1TypeId = cast(@ItemDimTypeId as nvarchar(50)) and ItemDim1Id is not null) 				
			order by Sizecol							

			INSERT INTO	pStyleBOMDimensionItem(StyleBOMDimensionId,	WorkflowID, WorkflowItemID,
			StyleID, StyleSet, Amlmeashdrid, sizerangeid, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1Id, ItemDim1Name
			,ItemDim1Sort)
			Select @StyleBOMDimensionId, @WorkflowID, @WorkflowItemID,
			@StyleID, @StyleSet, @amlmeashdrid, @ItemDimTypeItemId, @ItemDim1TypeId, @ItemDim2TypeId, @ItemDim3TypeId, DimID, DimName
			,Sort from 	#tmpSizeItem			
		end

	if @DimLevel=2
		begin			
			select top 1 @amlmeashdrid = amlmeashdrid , @ItemDimTypeItemId = sizerangeid   from pStyleBOMDimensionItem where 
			StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50)) and 	
			ItemDim2TypeId = cast(@ItemDimTypeid as nvarchar(50)) and ItemDim2Id is not null 				
			order by ItemDim2Sort, ItemDim2name					

			INSERT INTO #tmpSizeItem (DimID, DimName, Sort)
			select SizeRangeDetailId, MeasLbl, Sizecol from pamlmeaslbl where
			amlmeashdrid = @amlmeashdrid and Isvisible=1 and SizeRangeId = @ItemDimTypeItemId and SizeRangeDetailId not in ( select 
			ItemDim2Id from pStyleBOMDimensionItem where 
			StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50)) and 	
			ItemDim2TypeId = cast(@ItemDimTypeId as nvarchar(50)) and ItemDim2Id is not null) 				
			order by Sizecol									

			INSERT INTO	pStyleBOMDimensionItem(StyleBOMDimensionId,	WorkflowID, WorkflowItemID,
			StyleID, StyleSet, Amlmeashdrid, sizerangeid, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim2Id, ItemDim2Name
			,ItemDim2Sort)
			Select @StyleBOMDimensionId, @WorkflowID, @WorkflowItemID,
			@StyleID, @StyleSet, @amlmeashdrid, @ItemDimTypeItemId, @ItemDim1TypeId, @ItemDim2TypeId, @ItemDim3TypeId, DimID, DimName
			,Sort from 	#tmpSizeItem								
		end

	if @DimLevel=3
		begin	
			select top 1 @amlmeashdrid = amlmeashdrid , @ItemDimTypeItemId = sizerangeid   from pStyleBOMDimensionItem where 
			StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50)) and 	
			ItemDim3TypeId = cast(@ItemDimTypeid as nvarchar(50)) and ItemDim3Id is not null 				
			order by ItemDim3Sort, ItemDim3name	

			INSERT INTO #tmpSizeItem (DimID, DimName, Sort)
			select SizeRangeDetailId, MeasLbl, Sizecol from pamlmeaslbl where
			amlmeashdrid = @amlmeashdrid and Isvisible=1 and SizeRangeId = @ItemDimTypeItemId and SizeRangeDetailId not in ( select 
			ItemDim3Id from pStyleBOMDimensionItem where 
			StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50)) and 	
			ItemDim3TypeId = cast(@ItemDimTypeId as nvarchar(50)) and ItemDim3Id is not null) 				
			order by Sizecol	
			
			INSERT INTO	pStyleBOMDimensionItem(StyleBOMDimensionId,	WorkflowID, WorkflowItemID,
			StyleID, StyleSet, Amlmeashdrid, sizerangeid, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim3Id, ItemDim3Name
			,ItemDim3Sort)
			Select @StyleBOMDimensionId, @WorkflowID, @WorkflowItemID,
			@StyleID, @StyleSet, @amlmeashdrid, @ItemDimTypeItemId, @ItemDim1TypeId, @ItemDim2TypeId, @ItemDim3TypeId, DimID, DimName
			,Sort from 	#tmpSizeItem				
		end							
end

drop table #tmpSizeItem

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02193'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02193', GetDate())
END	
GO