IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMCustom_DimItem_Sel]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleBOMCustom_DimItem_Sel]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleBOMCustom_DimItem_Sel]    Script Date: 09/06/2011 12:30:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spx_StyleBOMCustom_DimItem_Sel] (
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
	CREATE TABLE #tmpDimCustomItem (
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
				INSERT INTO #tmpDimCustomItem (DimID, DimName, Sort)
				SELECT CustomID, Custom, COALESCE(Customsort,'0')
				from xCustom16 where CustomID not in (select ItemDim1Id from pStyleBOMDimensionItem where 
				StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50)) and 	
				ItemDim1TypeId = cast(@ItemDimTypeId as nvarchar(50)) and ItemDim1Id is not null)		
				order by Customsort
				
				INSERT INTO	pStyleBOMDimensionItem(StyleBOMDimensionId,	WorkflowID, WorkflowItemID,
				StyleID, StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1Id, ItemDim1Name
				,ItemDim1Sort)
				Select @StyleBOMDimensionId, @WorkflowID, @WorkflowItemID,
				@StyleID, @StyleSet, @ItemDim1TypeId, @ItemDim2TypeId, @ItemDim3TypeId, DimID, DimName
				,Sort from 	#tmpDimCustomItem														
			end
		if @DimLevel=2
			begin
				INSERT INTO #tmpDimCustomItem (DimID, DimName, Sort)
				SELECT CustomID, Custom, COALESCE(Customsort,'0')
				from xCustom16 where CustomID not in (select ItemDim2Id from pStyleBOMDimensionItem where 
				StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50)) and 	
				ItemDim2TypeId = cast(@ItemDimTypeId as nvarchar(50)) and ItemDim2Id is not null)		
				order by Customsort
				
				INSERT INTO	pStyleBOMDimensionItem(StyleBOMDimensionId,	WorkflowID, WorkflowItemID,
				StyleID, StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim2Id, ItemDim2Name
				,ItemDim2Sort)
				Select @StyleBOMDimensionId, @WorkflowID, @WorkflowItemID,
				@StyleID, @StyleSet, @ItemDim1TypeId, @ItemDim2TypeId, @ItemDim3TypeId, DimID, DimName
				,Sort from 	#tmpDimCustomItem									
			end
			
		if @DimLevel=3
			begin			
				INSERT INTO #tmpDimCustomItem (DimID, DimName, Sort)
				SELECT CustomID, Custom, COALESCE(Customsort,'0')
				from xCustom16 where CustomID not in (select ItemDim3Id from pStyleBOMDimensionItem where 
				StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50)) and 	
				ItemDim3TypeId = cast(@ItemDimTypeId as nvarchar(50)) and ItemDim3Id is not null)		
				order by Customsort
				
				INSERT INTO	pStyleBOMDimensionItem(StyleBOMDimensionId,	WorkflowID, WorkflowItemID,
				StyleID, StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim3Id, ItemDim3Name
				,ItemDim3Sort)
				Select @StyleBOMDimensionId, @WorkflowID, @WorkflowItemID,
				@StyleID, @StyleSet, @ItemDim1TypeId, @ItemDim2TypeId, @ItemDim3TypeId, DimID, DimName
				,Sort from 	#tmpDimCustomItem					
			end							
	end
	
	drop table #tmpDimCustomItem

	GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01881'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01881', GetDate())
END

GO


