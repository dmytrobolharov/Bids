IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMSizeRange_Add]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMSizeRange_Add]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_StyleBOMSizeRange_Add] (

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
	
declare @sizecount int
declare @SizeCnt int
Declare @colCnt int
Declare @Maxcount int
Declare @IncrCols nvarchar(2000)
Declare @query nvarchar(4000)
	
select @ItemDim1TypeId = ItemDim1TypeId, @ItemDim2TypeId = ItemDim2TypeId, @ItemDim3TypeId=ItemDim3TypeId
from pStyleBOMDimension where StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50))
		
begin											
	if @DimLevel=1
		begin														
			select top 1 @amlmeashdrid = amlmeashdrid , @ItemDimTypeItemId = sizerangeid   from pStyleBOMDimensionItem where 
			StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50)) and 	
			ItemDim1TypeId = cast(@ItemDimTypeId as nvarchar(50)) and ItemDim1Id is not null 				
			order by ItemDim1Sort, ItemDim1name	
			if @amlmeashdrid<>'00000000-0000-0000-0000-000000000000'
				begin
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
			else
				begin
					set @SizeCnt = 0				
					set @Maxcount=49
					set @IncrCols = ''												
					WHILE @SizeCnt <= @Maxcount
						begin
							set @IncrCols = @IncrCols + 'Size' + convert(nvarchar(3), @SizeCnt) + ','						
							set @SizeCnt = @SizeCnt + 1
						end					
					if right(@IncrCols,1)=',' set @IncrCols=substring(@IncrCols, 1, len(@IncrCols)-1)
					SET @query = N'select Sizerangeid, SizeRange, sizeid, sizename 				 
					from 
						(select CustomId as Sizerangeid ,  SizeRangeCode as SizeRange , ' + @IncrCols + ' from pSizeRange
						 where CustomId = ''' + convert(nvarchar(50),@ItemDimTypeItemId) + ''') p
					unpivot
					(sizename For sizeid in (' + @IncrCols + ')) as unpvt where sizename is not null 
					and sizename <> '''' order by RIGHT(''000000'' + SUBSTRING(sizeid, ISNULL(NULLIF(PATINDEX(''%[0-9]%'',sizeid), 0), LEN(sizeid)+1), LEN(sizeid)), 6);'	
					
					CREATE TABLE #tempSR (
					  sizeRowid int NOT NULL IDENTITY (0, 1)				 
					 ,Sizerangeid UNIQUEIDENTIFIER					 
					 ,SizeRange nvarchar(50)				 				 
					 ,sizeid nvarchar(10)
					 ,sizename nvarchar(10)	
					 )	
					 					
					INSERT #tempSR EXEC (@query)
					
					INSERT INTO	pStyleBOMDimensionItem(StyleBOMDimensionId,	WorkflowID, WorkflowItemID,
					StyleID, StyleSet, Amlmeashdrid, SizeRangeId, ItemDim1TypeId, ItemDim2TypeId, 
					ItemDim3TypeId, ItemDim1Id, ItemDim1Name,ItemDim1Sort)
					Select @StyleBOMDimensionId, @WorkflowID, @WorkflowItemID,
					@StyleID, @StyleSet, @amlmeashdrid, @ItemDimTypeItemId, @ItemDim1TypeId, @ItemDim2TypeId, @ItemDim3TypeId, 
					newid(), sizename, sizeRowid from #tempSR where sizename not in
					(select ItemDim1Name from pStyleBOMDimensionItem where 					
					StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50)) and	
					ItemDim1TypeId = cast(@ItemDimTypeId as nvarchar(50)) and ItemDim1Id is not null) 	
					
					drop table #tempSR
					
				end	
				
		end

	if @DimLevel=2
		begin			
			select top 1 @amlmeashdrid = amlmeashdrid , @ItemDimTypeItemId = sizerangeid   from pStyleBOMDimensionItem where 
			StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50)) and 	
			ItemDim2TypeId = cast(@ItemDimTypeid as nvarchar(50)) and ItemDim2Id is not null 				
			order by ItemDim2Sort, ItemDim2name					
			if @amlmeashdrid<>'00000000-0000-0000-0000-000000000000'
				begin
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
			else
				begin
					set @SizeCnt = 0				
					set @Maxcount=49
					set @IncrCols = ''												
					WHILE @SizeCnt <= @Maxcount
						begin
							set @IncrCols = @IncrCols + 'Size' + convert(nvarchar(3), @SizeCnt) + ','						
							set @SizeCnt = @SizeCnt + 1
						end					
					if right(@IncrCols,1)=',' set @IncrCols=substring(@IncrCols, 1, len(@IncrCols)-1)
					SET @query = N'select Sizerangeid, SizeRange, sizeid, sizename 				 
					from 
						(select CustomId as Sizerangeid ,  SizeRangeCode as SizeRange , ' + @IncrCols + ' from pSizeRange
						 where CustomId = ''' + convert(nvarchar(50),@ItemDimTypeItemId) + ''') p
					unpivot
					(sizename For sizeid in (' + @IncrCols + ')) as unpvt where sizename is not null 
					and sizename <> '''' order by RIGHT(''000000'' + SUBSTRING(sizeid, ISNULL(NULLIF(PATINDEX(''%[0-9]%'',sizeid), 0), LEN(sizeid)+1), LEN(sizeid)), 6);'	
					
					CREATE TABLE #tempSR2 (
					  sizeRowid int NOT NULL IDENTITY (0, 1)				 
					 ,Sizerangeid UNIQUEIDENTIFIER					 
					 ,SizeRange nvarchar(50)				 				 
					 ,sizeid nvarchar(10)
					 ,sizename nvarchar(10)	
					 )	
					 					
					INSERT #tempSR2 EXEC (@query)
					
					INSERT INTO	pStyleBOMDimensionItem(StyleBOMDimensionId,	WorkflowID, WorkflowItemID,
					StyleID, StyleSet, Amlmeashdrid, SizeRangeId, ItemDim1TypeId, ItemDim2TypeId, 
					ItemDim3TypeId, ItemDim2Id, ItemDim2Name,ItemDim2Sort)
					Select @StyleBOMDimensionId, @WorkflowID, @WorkflowItemID,
					@StyleID, @StyleSet, @amlmeashdrid, @ItemDimTypeItemId, @ItemDim1TypeId, @ItemDim2TypeId, @ItemDim3TypeId, 
					newid() , sizename, sizeRowid from #tempSR2 where sizename not in
					(select ItemDim2Name from pStyleBOMDimensionItem where 					
					StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50))  and	
					ItemDim2TypeId = cast(@ItemDimTypeId as nvarchar(50))  and ItemDim2Id is not null) 	
					
					drop table #tempSR2
				end						
		end

	if @DimLevel=3
		begin	
			select top 1 @amlmeashdrid = amlmeashdrid , @ItemDimTypeItemId = sizerangeid   from pStyleBOMDimensionItem where 
			StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50)) and 	
			ItemDim3TypeId = cast(@ItemDimTypeid as nvarchar(50)) and ItemDim3Id is not null 				
			order by ItemDim3Sort, ItemDim3name	
			if @amlmeashdrid<>'00000000-0000-0000-0000-000000000000'
				begin
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
			else
				begin
					set @SizeCnt = 0				
					set @Maxcount=49
					set @IncrCols = ''												
					WHILE @SizeCnt <= @Maxcount
						begin
							set @IncrCols = @IncrCols + 'Size' + convert(nvarchar(3), @SizeCnt) + ','						
							set @SizeCnt = @SizeCnt + 1
						end					
					if right(@IncrCols,1)=',' set @IncrCols=substring(@IncrCols, 1, len(@IncrCols)-1)
					SET @query = N'select Sizerangeid, SizeRange, sizeid, sizename 				 
					from 
						(select CustomId as Sizerangeid ,  SizeRangeCode as SizeRange , ' + @IncrCols + ' from pSizeRange
						 where CustomId = ''' + convert(nvarchar(50),@ItemDimTypeItemId) + ''') p
					unpivot
					(sizename For sizeid in (' + @IncrCols + ')) as unpvt where sizename is not null 
					and sizename <> '''' order by RIGHT(''000000'' + SUBSTRING(sizeid, ISNULL(NULLIF(PATINDEX(''%[0-9]%'',sizeid), 0), LEN(sizeid)+1), LEN(sizeid)), 6);'	
					
					CREATE TABLE #tempSR3 (
					  sizeRowid int NOT NULL IDENTITY (0, 1)				 
					 ,Sizerangeid UNIQUEIDENTIFIER					 
					 ,SizeRange nvarchar(50)				 				 
					 ,sizeid nvarchar(10)
					 ,sizename nvarchar(10)	
					 )	
					 					
					INSERT #tempSR3 EXEC (@query)
					
					INSERT INTO	pStyleBOMDimensionItem(StyleBOMDimensionId,	WorkflowID, WorkflowItemID,
					StyleID, StyleSet, Amlmeashdrid, SizeRangeId, ItemDim1TypeId, ItemDim2TypeId, 
					ItemDim3TypeId, ItemDim3Id, ItemDim3Name,ItemDim3Sort)
					Select @StyleBOMDimensionId, @WorkflowID, @WorkflowItemID,
					@StyleID, @StyleSet, @amlmeashdrid, @ItemDimTypeItemId, @ItemDim1TypeId, @ItemDim2TypeId, @ItemDim3TypeId, 
					newid(), sizename, sizeRowid from #tempSR3 where sizename not in
					(select ItemDim3Name from pStyleBOMDimensionItem where 					
					StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50))  and	
					ItemDim3TypeId = cast(@ItemDimTypeId as nvarchar(50))   and ItemDim3Id is not null) 	
					
					drop table #tempSR3
				end
							
		end							
end

drop table #tmpSizeItem



GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03044'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03044', GetDate())     

END	  
  
GO