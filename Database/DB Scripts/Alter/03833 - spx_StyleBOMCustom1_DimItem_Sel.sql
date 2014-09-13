/****** Object:  StoredProcedure [dbo].[spx_StyleBOMCustom1_DimItem_Sel]    Script Date: 08/14/2012 17:57:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMCustom1_DimItem_Sel]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMCustom1_DimItem_Sel]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBOMCustom1_DimItem_Sel]    Script Date: 08/14/2012 17:57:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[spx_StyleBOMCustom1_DimItem_Sel] (
@ItemDimTypeId nvarchar(50),
@StyleBOMDimensionId nvarchar(50),
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
	
	--set @styleid='9ffebe02-f186-4521-b352-fc0718711852'
	--set @styleset=1
	CREATE TABLE #tmpDimCustom1Item (
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
				INSERT INTO #tmpDimCustom1Item (DimID, DimName, Sort)
				SELECT CustomID, Custom, COALESCE(Customsort,'0')
				from DCustom1 where CustomID not in (select ItemDim1Id from pStyleBOMDimensionItem where 
				StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50)) and 	
				ItemDim1TypeId = cast(@ItemDimTypeId as nvarchar(50)) and ItemDim1Id is not null)		
				order by Customsort
				
				INSERT INTO	pStyleBOMDimensionItem(StyleBOMDimensionId,	WorkflowID, WorkflowItemID,
				StyleID, StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1Id, ItemDim1Name
				,ItemDim1Sort)
				Select @StyleBOMDimensionId, @WorkflowID, @WorkflowItemID,
				@StyleID, @StyleSet, @ItemDim1TypeId, @ItemDim2TypeId, @ItemDim3TypeId, DimID, DimName
				,Sort from 	#tmpDimCustom1Item														
			end
		if @DimLevel=2
			begin
				INSERT INTO #tmpDimCustom1Item (DimID, DimName, Sort)
				SELECT CustomID, Custom, COALESCE(Customsort,'0')
				from DCustom1 where CustomID not in (select ItemDim2Id from pStyleBOMDimensionItem where 
				StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50)) and 	
				ItemDim2TypeId = cast(@ItemDimTypeId as nvarchar(50)) and ItemDim2Id is not null)		
				order by Customsort
				
				INSERT INTO	pStyleBOMDimensionItem(StyleBOMDimensionId,	WorkflowID, WorkflowItemID,
				StyleID, StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim2Id, ItemDim2Name
				,ItemDim2Sort)
				Select @StyleBOMDimensionId, @WorkflowID, @WorkflowItemID,
				@StyleID, @StyleSet, @ItemDim1TypeId, @ItemDim2TypeId, @ItemDim3TypeId, DimID, DimName
				,Sort from 	#tmpDimCustom1Item									
			end
			
		if @DimLevel=3
			begin			
				INSERT INTO #tmpDimCustom1Item (DimID, DimName, Sort)
				SELECT CustomID, Custom, COALESCE(Customsort,'0')
				from DCustom1 where CustomID not in (select ItemDim3Id from pStyleBOMDimensionItem where 
				StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50)) and 	
				ItemDim3TypeId = cast(@ItemDimTypeId as nvarchar(50)) and ItemDim3Id is not null)		
				order by Customsort
				
				INSERT INTO	pStyleBOMDimensionItem(StyleBOMDimensionId,	WorkflowID, WorkflowItemID,
				StyleID, StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim3Id, ItemDim3Name
				,ItemDim3Sort)
				Select @StyleBOMDimensionId, @WorkflowID, @WorkflowItemID,
				@StyleID, @StyleSet, @ItemDim1TypeId, @ItemDim2TypeId, @ItemDim3TypeId, DimID, DimName
				,Sort from 	#tmpDimCustom1Item					
			end							
	end
	
	SELECT * FROM #tmpDimCustom1Item -- used for change management implemented in vb code
	
	drop table #tmpDimCustom1Item

	

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03833', GetDate())
GO