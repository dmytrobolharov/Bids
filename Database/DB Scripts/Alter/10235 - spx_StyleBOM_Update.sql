IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOM_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOM_Update]
GO

-- Stored Procedure

Create PROCEDURE [dbo].[spx_StyleBOM_Update]
(
@StyleBOMDimensionId nvarchar(50),
@StyleID uniqueidentifier,
@Styleset int,
@WorkFlowID uniqueidentifier,
@WorkFlowItemID uniqueidentifier,
@ItemDim1 uniqueidentifier,
@ItemDim1Name nvarchar(200),
@ItemDim2 uniqueidentifier,
@ItemDim2Name nvarchar(200),
@ItemDim3 uniqueidentifier,
@ItemDim3Name nvarchar(200),
@MUser nvarchar(200),
@MDate datetime
)
AS 

Declare @ItemDim1TypeId uniqueidentifier	
Declare @ItemDim2TypeId uniqueidentifier	
Declare @ItemDim3TypeId uniqueidentifier
Declare @DimCnt int

set @DimCnt=0

CREATE TABLE #tmpDim1Item (
	Rec1_ID INT IDENTITY (1,1),
	Dim1ID NVARCHAR(50),
	Dim1Name 	NVARCHAR(200),	
	Dim1Sort NVARCHAR(5),
	Dim1Active int		
	)	
	
CREATE TABLE #tmpDim2Item (
	Rec2_ID INT IDENTITY (1,1),
	Dim2ID NVARCHAR(50),
	Dim2Name 	NVARCHAR(200),	
	Dim2Sort NVARCHAR(5),
	Dim2Active int			
	)	
	
CREATE TABLE #tmpDim3Item (
	Rec3_ID INT IDENTITY (1,1),
	Dim3ID NVARCHAR(50),
	Dim3Name 	NVARCHAR(200),	
	Dim3Sort NVARCHAR(5),
	Dim3Active int			
	)	
	
CREATE TABLE #tmpDimItem (
	Rec_ID INT IDENTITY (1,1),
	Dim1ID NVARCHAR(50),
	Dim2ID NVARCHAR(50),
	Dim3ID NVARCHAR(50),
	Dim1Name 	NVARCHAR(200),
	Dim2Name 	NVARCHAR(200),
	Dim3Name 	NVARCHAR(200),
	Dim1Sort NVARCHAR(5),
	Dim2Sort NVARCHAR(5),	
	Dim3Sort NVARCHAR(5),
	Dim1Active int,
	Dim2Active int,
	Dim3Active int			
	)	
			
BEGIN

select @ItemDim1TypeId = COALESCE(ItemDim1TypeId,'00000000-0000-0000-0000-000000000000') , @ItemDim2TypeId = COALESCE(ItemDim2TypeId,'00000000-0000-0000-0000-000000000000'), 
@ItemDim3TypeId=COALESCE(ItemDim3TypeId,'00000000-0000-0000-0000-000000000000')
from pStyleBOMDimension where StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50))

if @ItemDim1TypeId<>'00000000-0000-0000-0000-000000000000'
begin
	INSERT INTO #tmpDim1Item (Dim1ID, Dim1Name, Dim1Sort, Dim1Active)
	SELECT ItemDim1Id, ItemDim1Name, ItemDim1Sort, ItemDim1Active
	FROM pStyleBOMDimensionitem  where StyleBOMDimensionId=@StyleBOMDimensionId and 
	ItemDim1TypeId=@ItemDim1TypeId and ItemDim1Id is not null and ItemDim1Id not in (
	select ItemDim1Id FROM pStyleBOMDimensionitems  where StyleBOMDimensionId=@StyleBOMDimensionId and 
	ItemDim1TypeId=@ItemDim1TypeId and ItemDim1Id is not null)
	set @DimCnt=1
end

if @ItemDim2TypeId<>'00000000-0000-0000-0000-000000000000'
begin
	INSERT INTO #tmpDim2Item (Dim2ID, Dim2Name, Dim2Sort, Dim2Active)
	SELECT ItemDim2Id, ItemDim2Name, ItemDim2Sort, ItemDim2Active
	FROM pStyleBOMDimensionitem  where StyleBOMDimensionId=@StyleBOMDimensionId and 
	ItemDim2TypeId=@ItemDim2TypeId and ItemDim2Id is not null and ItemDim2Id not in (
	select ItemDim2Id FROM pStyleBOMDimensionitems  where StyleBOMDimensionId=@StyleBOMDimensionId and 
	ItemDim2TypeId=@ItemDim2TypeId and ItemDim2Id is not null)
	set @DimCnt=2
end

if @ItemDim3TypeId<>'00000000-0000-0000-0000-000000000000'
begin
	INSERT INTO #tmpDim3Item (Dim3ID, Dim3Name, Dim3Sort, Dim3Active)
	SELECT ItemDim3Id, ItemDim3Name, ItemDim3Sort, ItemDim3Active
	FROM pStyleBOMDimensionitem  where StyleBOMDimensionId=@StyleBOMDimensionId and 
	ItemDim3TypeId=@ItemDim3TypeId and ItemDim3Id is not null and ItemDim3Id not in (
	select ItemDim3Id FROM pStyleBOMDimensionitems  where StyleBOMDimensionId=@StyleBOMDimensionId and 
	ItemDim3TypeId=@ItemDim3TypeId and ItemDim3Id is not null)
	set @DimCnt=3
end

Declare @Dim1ID nvarchar(50)  
Declare @Dim1Name nvarchar(200)  
Declare @Dim1Sort NVARCHAR(5) 
Declare @Dim1Active int
Declare @Dim2ID nvarchar(50)  
Declare @Dim2Name nvarchar(200)  
Declare @Dim2Sort NVARCHAR(5) 
Declare @Dim2Active int
Declare @Dim3ID nvarchar(50)  
Declare @Dim3Name nvarchar(200)  
Declare @Dim3Sort NVARCHAR(5) 
Declare @Dim3Active int
Declare @DimID nvarchar(50)  
Declare @DimName nvarchar(50)  
Declare @DimSort NVARCHAR(5) 
Declare @DimActive int

if @DimCnt=3
begin
	DECLARE cursor_1 CURSOR FOR
	SELECT Dim1ID, Dim1Name, Dim1Sort, Dim1Active FROM #tmpDim1Item	ORDER BY Dim1Sort			 		
	OPEN cursor_1		
	FETCH NEXT from cursor_1 INTO  @Dim1ID, @Dim1Name, @Dim1Sort, @Dim1Active	
	WHILE @@FETCH_STATUS = 0 
		BEGIN
			DECLARE cursor_2 CURSOR FOR
			SELECT Dim2ID, Dim2Name, Dim2Sort, Dim2Active FROM #tmpDim2Item	ORDER BY Dim2Sort
			OPEN cursor_2
			FETCH NEXT from cursor_2 INTO  @Dim2ID, @Dim2Name, @Dim2Sort, @Dim2Active																												
			WHILE @@FETCH_STATUS = 0 
				BEGIN
					DECLARE cursor_3 CURSOR FOR
					SELECT Dim3ID, Dim3Name, Dim3Sort, Dim3Active FROM #tmpDim3Item	ORDER BY Dim3Sort
					OPEN cursor_3
					FETCH NEXT from cursor_3 INTO  @Dim3ID, @Dim3Name, @Dim3Sort, @Dim3Active																												
					WHILE @@FETCH_STATUS = 0 
						BEGIN
							INSERT INTO #tmpDimItem (Dim1ID, Dim2ID, Dim3ID, Dim1Name, Dim2Name, Dim3Name, 
							Dim1Sort, Dim2Sort, Dim3Sort, Dim1Active, Dim2Active, Dim3Active)
							values (@Dim1ID, @Dim2ID, @Dim3ID, @Dim1Name, @Dim2Name, @Dim3Name, 
							@Dim1Sort, @Dim2Sort, @Dim3Sort, @Dim1Active, @Dim2Active, @Dim3Active)																									
							FETCH NEXT from cursor_3 INTO  @Dim3ID, @Dim3Name, @Dim3Sort, @Dim3Active	
						END
						CLOSE cursor_3 
						DEALLOCATE cursor_3 		
					FETCH NEXT from cursor_2 INTO  @Dim2ID, @Dim2Name, @Dim2Sort, @Dim2Active						
				END
				CLOSE cursor_2 
				DEALLOCATE cursor_2 	
			FETCH NEXT from cursor_1 INTO  @Dim1ID, @Dim1Name, @Dim1Sort, @Dim1Active
		END						
		CLOSE cursor_1 
		DEALLOCATE cursor_1 
end	

if @DimCnt=2
begin
	DECLARE cursor_1 CURSOR FOR
	SELECT Dim1ID, Dim1Name, Dim1Sort, Dim1Active FROM #tmpDim1Item	ORDER BY Dim1Sort			 		
	OPEN cursor_1		
	FETCH NEXT from cursor_1 INTO  @Dim1ID, @Dim1Name, @Dim1Sort, @Dim1Active	
	WHILE @@FETCH_STATUS = 0 
		BEGIN
			DECLARE cursor_2 CURSOR FOR
			SELECT Dim2ID, Dim2Name, Dim2Sort, Dim2Active FROM #tmpDim2Item	ORDER BY Dim2Sort
			OPEN cursor_2
			FETCH NEXT from cursor_2 INTO  @Dim2ID, @Dim2Name, @Dim2Sort, @Dim2Active																												
			WHILE @@FETCH_STATUS = 0 
				BEGIN					
					INSERT INTO #tmpDimItem (Dim1ID, Dim2ID, Dim3ID, Dim1Name, Dim2Name, Dim3Name, 
					Dim1Sort, Dim2Sort, Dim3Sort, Dim1Active, Dim2Active, Dim3Active)
					values (@Dim1ID, @Dim2ID, null, @Dim1Name, @Dim2Name, null, 
					@Dim1Sort, @Dim2Sort, 0, @Dim1Active, @Dim2Active, 1)																									
					FETCH NEXT from cursor_2 INTO  @Dim2ID, @Dim2Name, @Dim2Sort, @Dim2Active	
				END
				CLOSE cursor_2 
				DEALLOCATE cursor_2 								
			FETCH NEXT from cursor_1 INTO  @Dim1ID, @Dim1Name, @Dim1Sort, @Dim1Active
		END						
		CLOSE cursor_1 
		DEALLOCATE cursor_1 
end	


if @DimCnt=1
begin
	DECLARE cursor_1 CURSOR FOR
	SELECT Dim1ID, Dim1Name, Dim1Sort, Dim1Active FROM #tmpDim1Item	ORDER BY Dim1Sort			 		
	OPEN cursor_1		
	FETCH NEXT from cursor_1 INTO  @Dim1ID, @Dim1Name, @Dim1Sort, @Dim1Active	
	WHILE @@FETCH_STATUS = 0 
		BEGIN			
			INSERT INTO #tmpDimItem (Dim1ID, Dim2ID, Dim3ID, Dim1Name, Dim2Name, Dim3Name, 
			Dim1Sort, Dim2Sort, Dim3Sort, Dim1Active, Dim2Active, Dim3Active)
			values (@Dim1ID, null, null, @Dim1Name, null, null, 
			@Dim1Sort, 0, 0, @Dim1Active, 1, 1)																									
			FETCH NEXT from cursor_1 INTO  @Dim1ID, @Dim1Name, @Dim1Sort, @Dim1Active	
		END
		CLOSE cursor_1 
		DEALLOCATE cursor_1 									
end	
Declare @tmpCnt int

set @DimCnt = 0
Declare @StyleBOMDimensionItemId nvarchar(50)

select @tmpCnt = COUNT(Dim1ID) from #tmpDimItem

if @tmpCnt>0
begin
	INSERT INTO	pStyleBOMDimensionItems (StyleBOMDimensionId, WorkflowID, WorkflowItemID,
	StyleID, StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1Id, ItemDim1Name
	,ItemDim1Sort, ItemDim1Active, ItemDim2Id, ItemDim2Name	,ItemDim2Sort, ItemDim2Active,
	ItemDim3Id, ItemDim3Name, ItemDim3Sort, ItemDim3Active)
	Select @StyleBOMDimensionId, @WorkflowID, @WorkflowItemID,
	@StyleID, @StyleSet, @ItemDim1TypeId, @ItemDim2TypeId, @ItemDim3TypeId, Dim1ID, Dim1Name,
	Dim1Sort,Dim1Active, Dim2ID, Dim2Name,Dim2Sort,Dim2Active, Dim3ID, Dim3Name,
	Dim3Sort,Dim3Active from #tmpDimItem
	
	SELECT top 1 @StyleBOMDimensionItemId=StyleBOMDimensionItemId from pStyleBOMDimensionItems where   
    StyleBOMDimensionId=@StyleBOMDimensionId and ItemDimActive=1
    order by ItemDim1sort, Itemdim1name, ItemDim2sort, Itemdim2name, ItemDim3sort, Itemdim3name 
	
	if @StyleBOMDimensionItemId is null
		begin			
			if @DimCnt=1 
				begin
					SELECT top 1 @StyleBOMDimensionItemId=StyleBOMDimensionItemId from pStyleBOMDimensionItems where   
					StyleBOMDimensionId=@StyleBOMDimensionId and Itemdim1active=1  order by 
					ItemDim1sort, Itemdim1name, ItemDim2sort, Itemdim2name, ItemDim3sort, Itemdim3name 
					
					update pStyleBOMDimensionItems set ItemDimActive=1 
					where StyleBOMDimensionId=@StyleBOMDimensionId and StyleBOMDimensionId=@StyleBOMDimensionId
				end
			else if @DimCnt=2
				begin
					SELECT top 1 @StyleBOMDimensionItemId=StyleBOMDimensionItemId from pStyleBOMDimensionItems where   
					StyleBOMDimensionId=@StyleBOMDimensionId and Itemdim1active=1 and Itemdim2active=1 order by 
					ItemDim1sort, Itemdim1name, ItemDim2sort, Itemdim2name, ItemDim3sort, Itemdim3name 
					
					update pStyleBOMDimensionItems set ItemDimActive=1 
					where StyleBOMDimensionId=@StyleBOMDimensionId and StyleBOMDimensionId=@StyleBOMDimensionId
				end 
			else if @DimCnt=3
				begin
					SELECT top 1 @StyleBOMDimensionItemId=StyleBOMDimensionItemId from pStyleBOMDimensionItems where   
					StyleBOMDimensionId=@StyleBOMDimensionId and Itemdim1active=1 and Itemdim2active=1 and Itemdim3active=1 order by 
					ItemDim1sort, Itemdim1name, ItemDim2sort, Itemdim2name, ItemDim3sort, Itemdim3name 
					
					update pStyleBOMDimensionItems set ItemDimActive=1 
					where StyleBOMDimensionId=@StyleBOMDimensionId and StyleBOMDimensionId=@StyleBOMDimensionId
				end
		end			
	
end

--select * from #tmpDimItem order by Dim1Sort, Dim1Name, Dim2Sort, Dim2Name,  Dim3Sort, Dim3Name
--select * from #tmpDim1Item 
--select * from #tmpDim2Item 
--select * from #tmpDim3Item 
drop table #tmpDimItem
drop table #tmpDim1Item
drop table #tmpDim2Item		
drop table #tmpDim3Item

		
			
end


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10235', GetUTCDate())
GO
