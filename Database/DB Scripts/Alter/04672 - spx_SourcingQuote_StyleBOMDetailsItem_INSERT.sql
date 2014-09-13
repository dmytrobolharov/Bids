/****** Object:  StoredProcedure [dbo].[spx_SourcingQuote_StyleBOMDetailsItem_INSERT]    Script Date: 12/21/2012 12:55:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingQuote_StyleBOMDetailsItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingQuote_StyleBOMDetailsItem_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingQuote_StyleBOMDetailsItem_INSERT]    Script Date: 12/21/2012 12:55:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_SourcingQuote_StyleBOMDetailsItem_INSERT]
(
@StyleQuoteItemID uniqueidentifier,
@StyleBOMDimensionId uniqueidentifier,
@SourcingHeaderID uniqueidentifier,
@SourcingStyleID uniqueidentifier,
@MUser nvarchar(200),
@MDate datetime
)
AS 

Declare @ItemDim1TypeId uniqueidentifier	
Declare @ItemDim2TypeId uniqueidentifier	
Declare @ItemDim3TypeId uniqueidentifier
Declare @StyleID uniqueidentifier	
Declare @WorkFlowItemID uniqueidentifier	
Declare @WorkFlowID uniqueidentifier
Declare @styleset int
Declare @DimCnt int
declare @Dim1Cnt int
declare @Dim2Cnt int
declare @Dim3Cnt int
set @Dim1Cnt=0
set @Dim2Cnt=0
set @Dim3Cnt=0


set @DimCnt=0

CREATE TABLE #tmpDim1Item (
	Rec1_ID INT IDENTITY (1,1),
	Dim1ID NVARCHAR(50),
	Dim1Name 	NVARCHAR(50),	 
	Dim1Sort NVARCHAR(5),
	Dim1Active int		
	)

CREATE TABLE #tmpDim2Item (
	Rec2_ID INT IDENTITY (1,1),
	Dim2ID NVARCHAR(50),
	Dim2Name 	NVARCHAR(50),	
	Dim2Sort NVARCHAR(5),
	Dim2Active int			
	)

CREATE TABLE #tmpDim3Item (
	Rec3_ID INT IDENTITY (1,1),
	Dim3ID NVARCHAR(50),
	Dim3Name 	NVARCHAR(50),	
	Dim3Sort NVARCHAR(5),
	Dim3Active int			
	)

CREATE TABLE #tmpDimItem (
	Rec_ID INT IDENTITY (1,1),
	Dim1ID NVARCHAR(50),
	Dim2ID NVARCHAR(50),
	Dim3ID NVARCHAR(50),
	Dim1Name 	NVARCHAR(50),
	Dim2Name 	NVARCHAR(50),
	Dim3Name 	NVARCHAR(50),
	Dim1Sort NVARCHAR(5),
	Dim2Sort NVARCHAR(5),	
	Dim3Sort NVARCHAR(5),
	Dim1Active int,
	Dim2Active int,
	Dim3Active int			
	)		



select top 1 @ItemDim1TypeId=COALESCE(ItemDim1TypeId,'00000000-0000-0000-0000-000000000000') 
, @ItemDim2TypeId=COALESCE(ItemDim2TypeId,'00000000-0000-0000-0000-000000000000') ,
@ItemDim3TypeId=COALESCE(ItemDim3TypeId,'00000000-0000-0000-0000-000000000000'),
@StyleID=StyleID , @styleset=styleset, @WorkFlowID=WorkFlowID, @WorkFlowItemID=WorkFlowItemID
from pSourcingQuoteStyleBOM where 
StyleQuoteItemID=@StyleQuoteItemID and StyleBOMDimensionId=@StyleBOMDimensionId


if @ItemDim1TypeId<>'00000000-0000-0000-0000-000000000000'
begin
	INSERT INTO #tmpDim1Item (Dim1ID, Dim1Name, Dim1Sort, Dim1Active)
	SELECT ItemDim1Id, ItemDim1Name, ItemDim1Sort, ItemDim1Active
	FROM pSourcingQuoteStyleBOM  where StyleQuoteItemID=@StyleQuoteItemID and StyleBOMDimensionId=@StyleBOMDimensionId and 
	ItemDim1TypeId=@ItemDim1TypeId and ItemDim1Active=1 and ItemDim1Id is not null 
	select  @Dim1Cnt= COUNT(Dim1ID) from #tmpDim1Item
	--select  @Dim1Cnt as dim1
end

if @ItemDim2TypeId<>'00000000-0000-0000-0000-000000000000'
begin
	INSERT INTO #tmpDim2Item (Dim2ID, Dim2Name, Dim2Sort, Dim2Active)
	SELECT ItemDim2Id, ItemDim2Name, ItemDim2Sort, ItemDim2Active
	FROM pSourcingQuoteStyleBOM  where StyleBOMDimensionId=@StyleBOMDimensionId and 
	StyleQuoteItemID=@StyleQuoteItemID and ItemDim2TypeId=@ItemDim2TypeId and ItemDim2Active=1 and ItemDim2Id is not null 
	select  @Dim2Cnt= COUNT(Dim2ID) from #tmpDim2Item
	--select  @Dim2Cnt as dim2
end

if @ItemDim3TypeId<>'00000000-0000-0000-0000-000000000000'
begin
	INSERT INTO #tmpDim3Item (Dim3ID, Dim3Name, Dim3Sort, Dim3Active)
	SELECT ItemDim3Id, ItemDim3Name, ItemDim3Sort, ItemDim3Active
	FROM pSourcingQuoteStyleBOM  where StyleBOMDimensionId=@StyleBOMDimensionId and 
	StyleQuoteItemID=@StyleQuoteItemID and ItemDim3TypeId=@ItemDim3TypeId and ItemDim3Active=1 and ItemDim3Id is not null 
	select  @Dim3Cnt= COUNT(Dim3ID) from #tmpDim3Item
	--select  @Dim3Cnt as dim3
end

Declare @Dim1ID nvarchar(50)  
Declare @Dim1Name nvarchar(50)  
Declare @Dim1Sort NVARCHAR(5) 
Declare @Dim1Active int

Declare @Dim2ID nvarchar(50)  
Declare @Dim2Name nvarchar(50)  
Declare @Dim2Sort NVARCHAR(5) 
Declare @Dim2Active int

Declare @Dim3ID nvarchar(50)  
Declare @Dim3Name nvarchar(50)  
Declare @Dim3Sort NVARCHAR(5) 
Declare @Dim3Active int

Declare @DimID nvarchar(50)  
Declare @DimName nvarchar(50)  
Declare @DimSort NVARCHAR(5) 
Declare @DimActive int
Declare @intBOMcnt int
Declare @Dimsel nvarchar(5) 

--select @DimCnt as dimcnt
delete from pSourcingQuotationBOMDetails where StyleQuoteItemID=@StyleQuoteItemID 
--and StyleBOMDimensionId=@StyleBOMDimensionId

set @Dimsel=''
if @Dim1Cnt>0 and @Dim2Cnt>0 and @Dim3Cnt>0
	begin
		set @Dimsel='123'
	end
else if @Dim1Cnt>0 and @Dim2Cnt>0
	begin
		set @Dimsel='12'
	end
else if  @Dim1Cnt>0 and @Dim3Cnt>0
	begin
		set @Dimsel='13'
	end
else if  @Dim2Cnt>0 and @Dim3Cnt>0
	begin
		set @Dimsel='23'
	end
else if @Dim1Cnt>0
	begin
		set @Dimsel='1'
	end
else if @Dim2Cnt>0
	begin
		set @Dimsel='2'
	end
else if @Dim3Cnt>0
	begin
		set @Dimsel='3'
	end

--select  @Dimsel as Dimsel

if @Dimsel='123'
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
					SELECT Dim3ID, Dim3Name, Dim3Sort, Dim3Active FROM #tmpDim3Item 
					ORDER BY Dim3Sort
					OPEN cursor_3
					FETCH NEXT from cursor_3 INTO  @Dim3ID, @Dim3Name, @Dim3Sort, @Dim3Active																												
					WHILE @@FETCH_STATUS = 0 
						BEGIN
							INSERT INTO #tmpDimItem (Dim1ID, Dim2ID, Dim3ID, Dim1Name, Dim2Name, Dim3Name, 
							Dim1Sort, Dim2Sort, Dim3Sort, Dim1Active, Dim2Active, Dim3Active)
							values (@Dim1ID, @Dim2ID, @Dim3ID, @Dim1Name, @Dim2Name, @Dim3Name, 
							@Dim1Sort, @Dim2Sort, @Dim3Sort, 1, 1, 1)					
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

if @Dimsel='12' 
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
					@Dim1Sort, @Dim2Sort, 0, 1, 1, 1)	
																												
					FETCH NEXT from cursor_2 INTO  @Dim2ID, @Dim2Name, @Dim2Sort, @Dim2Active	
				END
				CLOSE cursor_2 
				DEALLOCATE cursor_2 								
			FETCH NEXT from cursor_1 INTO  @Dim1ID, @Dim1Name, @Dim1Sort, @Dim1Active
		END						
		CLOSE cursor_1 
		DEALLOCATE cursor_1 
end	

if @Dimsel='13' 
begin
	DECLARE cursor_1 CURSOR FOR
	SELECT Dim1ID, Dim1Name, Dim1Sort, Dim1Active FROM #tmpDim1Item	ORDER BY Dim1Sort			 		
	OPEN cursor_1		
	FETCH NEXT from cursor_1 INTO  @Dim1ID, @Dim1Name, @Dim1Sort, @Dim1Active	
	WHILE @@FETCH_STATUS = 0 
		BEGIN
			DECLARE cursor_2 CURSOR FOR
			SELECT Dim3ID, Dim3Name, Dim3Sort, Dim3Active FROM #tmpDim3Item	ORDER BY Dim3Sort
			OPEN cursor_2
			FETCH NEXT from cursor_2 INTO  @Dim3ID, @Dim3Name, @Dim3Sort, @Dim3Active																												
			WHILE @@FETCH_STATUS = 0 
				BEGIN				
					INSERT INTO #tmpDimItem (Dim1ID, Dim2ID, Dim3ID, Dim1Name, Dim2Name, Dim3Name, 
					Dim1Sort, Dim2Sort, Dim3Sort, Dim1Active, Dim2Active, Dim3Active)
					values (@Dim1ID, null, @Dim3ID, @Dim1Name, null, @Dim3Name, 
					@Dim1Sort, 0, @Dim3Sort, 1, 1, 1)	
																										
					FETCH NEXT from cursor_2 INTO @Dim3ID, @Dim3Name, @Dim3Sort, @Dim3Active
				END
				CLOSE cursor_2 
				DEALLOCATE cursor_2 								
			FETCH NEXT from cursor_1 INTO  @Dim1ID, @Dim1Name, @Dim1Sort, @Dim1Active
		END						
		CLOSE cursor_1 
		DEALLOCATE cursor_1 
end	

if @Dimsel='23' 
begin
	DECLARE cursor_1 CURSOR FOR
	SELECT Dim2ID, Dim2Name, Dim2Sort, Dim2Active FROM #tmpDim2Item	ORDER BY Dim2Sort			 		
	OPEN cursor_1		
	FETCH NEXT from cursor_1 INTO  @Dim2ID, @Dim2Name, @Dim2Sort, @Dim2Active	
	WHILE @@FETCH_STATUS = 0 
		BEGIN
			DECLARE cursor_2 CURSOR FOR
			SELECT Dim3ID, Dim3Name, Dim3Sort, Dim3Active FROM #tmpDim3Item	ORDER BY Dim3Sort
			OPEN cursor_2
			FETCH NEXT from cursor_2 INTO  @Dim3ID, @Dim3Name, @Dim3Sort, @Dim3Active																												
			WHILE @@FETCH_STATUS = 0 
				BEGIN				
					INSERT INTO #tmpDimItem (Dim1ID, Dim2ID, Dim3ID, Dim1Name, Dim2Name, Dim3Name, 
					Dim1Sort, Dim2Sort, Dim3Sort, Dim1Active, Dim2Active, Dim3Active)
					values (null, @Dim2ID, @Dim3ID, null, @Dim2Name, @Dim3Name, 
					0, @Dim2Sort, @Dim3Sort, 1, 1, 1)	
																													
					FETCH NEXT from cursor_2 INTO   @Dim3ID, @Dim3Name, @Dim3Sort, @Dim3Active	
				END
				CLOSE cursor_2 
				DEALLOCATE cursor_2 								
			FETCH NEXT from cursor_1 INTO  @Dim2ID, @Dim2Name, @Dim2Sort, @Dim2Active	
		END						
		CLOSE cursor_1 
		DEALLOCATE cursor_1 
end	


if @Dimsel='1' 
begin		
	select 	@Dimsel as sel
	INSERT INTO #tmpDimItem (Dim1ID, Dim2ID, Dim3ID, Dim1Name, Dim2Name, Dim3Name, 
	Dim1Sort, Dim2Sort, Dim3Sort, Dim1Active, Dim2Active, Dim3Active)
	select Dim1ID, null, null, Dim1Name, null, null, 
	Dim1Sort, 0, 0, 1, 1, 1 from #tmpDim1Item
	select * from #tmpDimItem
end	

if @Dimsel='2' 
begin			
	INSERT INTO #tmpDimItem (Dim1ID, Dim2ID, Dim3ID, Dim1Name, Dim2Name, Dim3Name, 
	Dim1Sort, Dim2Sort, Dim3Sort, Dim1Active, Dim2Active, Dim3Active)
	select null, Dim2ID, null, null, Dim2Name, null, 
	0, Dim2Sort, 0, 1, 1, 1 from #tmpDim2Item
end
	
if @Dimsel='3' 
begin			
	INSERT INTO #tmpDimItem (Dim1ID, Dim2ID, Dim3ID, Dim1Name, Dim2Name, Dim3Name, 
	Dim1Sort, Dim2Sort, Dim3Sort, Dim1Active, Dim2Active, Dim3Active)
	select null, null, Dim3ID, null, null, Dim3Name, 
	0, 0, Dim3Sort, 1, 1, 1 from #tmpDim3Item
end	

--select * from #tmpDim1Item
Declare @tmpCnt int
select @tmpCnt = COUNT(*) from #tmpDimItem

--select @tmpCnt as tmpCnt

if @tmpCnt>0
begin
	INSERT INTO [dbo].[pSourcingQuotationBOMDetails]
           ([SourcingQuotationBOMDetailsID]
           ,[StyleQuoteItemID]
           ,[SourcingHeaderId]
           ,[SourcingStyleID]
           ,[StyleID]
           ,[styleset]
           ,[WorkFlowID]
           ,[WorkFlowItemID]
           ,[StyleBOMDimensionId]
           ,[ItemDim1TypeId]
           ,[ItemDim2TypeId]
           ,[ItemDim3TypeId]
           ,[ItemDim1Id]
           ,[ItemDim2Id]
           ,[ItemDim3Id]
           ,[ItemDim1Name]
           ,[ItemDim2Name]
           ,[ItemDim3Name]
           ,[ItemDim1Sort]
           ,[ItemDim2Sort]
           ,[ItemDim3Sort]
           ,[ItemDim1Active]
           ,[ItemDim2Active]
           ,[ItemDim3Active]
           ,[Quantity]
           ,[Cost]
           ,[TotalCost]
           ,[PartnerCost]
           ,[PartnerTotal]
           ,[CUser]
           ,[MUser]
           ,[CDate]
           ,[MDate])
     select
           NEWID()
           ,@StyleQuoteItemID
           ,@SourcingHeaderId
           ,@SourcingStyleID
           ,@StyleID
           ,@styleset
           ,@WorkFlowID
           ,@WorkFlowItemID
           ,@StyleBOMDimensionId
           ,@ItemDim1TypeId
           ,@ItemDim2TypeId
           ,@ItemDim3TypeId
           ,Dim1ID, Dim2ID, Dim3ID, Dim1Name, Dim2Name, Dim3Name
	    	,Dim1Sort, Dim2Sort, Dim3Sort, Dim1Active,  Dim2Active 
			,Dim3Active 
           ,0
           ,0
           ,0
           ,0
           ,0
           ,@MUser
           ,@MUser
           ,@MDate
           ,@MDate from #tmpDimItem
           
           --select * from [pSourcingQuotationBOMDetails]
	
end

drop table #tmpDimItem
drop table #tmpDim1Item
drop table #tmpDim2Item		
drop table #tmpDim3Item


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04672', GetDate())
GO

