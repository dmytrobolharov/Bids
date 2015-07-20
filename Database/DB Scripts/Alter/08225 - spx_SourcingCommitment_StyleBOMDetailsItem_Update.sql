IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingCommitment_StyleBOMDetailsItem_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingCommitment_StyleBOMDetailsItem_Update]
GO

CREATE PROCEDURE [dbo].[spx_SourcingCommitment_StyleBOMDetailsItem_Update]
(
@StyleCommitmentItemID uniqueidentifier,
@StyleQuoteItemID uniqueidentifier,
@StyleBOMDimensionId uniqueidentifier,
@StyleSKUItemID uniqueidentifier = NULL,
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
	Dim3Active int,
	Quantity 	decimal(18,4),
	Cost decimal(18,4)
	)		



select top 1 @ItemDim1TypeId=COALESCE(ItemDim1TypeId,'00000000-0000-0000-0000-000000000000') 
, @ItemDim2TypeId=COALESCE(ItemDim2TypeId,'00000000-0000-0000-0000-000000000000') ,
@ItemDim3TypeId=COALESCE(ItemDim3TypeId,'00000000-0000-0000-0000-000000000000'),
@StyleID=StyleID , @styleset=styleset, @WorkFlowID=WorkFlowID, @WorkFlowItemID=WorkFlowItemID
from pSourcingCommitmentBOM where 
SourcingCommitmentItemID=@StyleCommitmentItemID and StyleBOMDimensionId=@StyleBOMDimensionId


if @ItemDim1TypeId<>'00000000-0000-0000-0000-000000000000'
begin
	INSERT INTO #tmpDim1Item (Dim1ID, Dim1Name, Dim1Sort, Dim1Active)
	SELECT ItemDim1Id, ItemDim1Name, ItemDim1Sort, ItemDim1Active
	FROM pSourcingCommitmentBOM  where SourcingCommitmentItemID=@StyleCommitmentItemID and StyleBOMDimensionId=@StyleBOMDimensionId and 
	ItemDim1TypeId=@ItemDim1TypeId and ItemDim1Active=1 and ItemDim1Id is not null 
	select  @Dim1Cnt= COUNT(Dim1ID) from #tmpDim1Item
	--select  @Dim1Cnt as dim1
end

if @ItemDim2TypeId<>'00000000-0000-0000-0000-000000000000'
begin
	INSERT INTO #tmpDim2Item (Dim2ID, Dim2Name, Dim2Sort, Dim2Active)
	SELECT ItemDim2Id, ItemDim2Name, ItemDim2Sort, ItemDim2Active
	FROM pSourcingCommitmentBOM  where StyleBOMDimensionId=@StyleBOMDimensionId and 
	SourcingCommitmentItemID=@StyleCommitmentItemID and ItemDim2TypeId=@ItemDim2TypeId and ItemDim2Active=1 and ItemDim2Id is not null 
	select  @Dim2Cnt= COUNT(Dim2ID) from #tmpDim2Item
	--select  @Dim2Cnt as dim2
end

if @ItemDim3TypeId<>'00000000-0000-0000-0000-000000000000'
begin
	INSERT INTO #tmpDim3Item (Dim3ID, Dim3Name, Dim3Sort, Dim3Active)
	SELECT ItemDim3Id, ItemDim3Name, ItemDim3Sort, ItemDim3Active
	FROM pSourcingCommitmentBOM  where StyleBOMDimensionId=@StyleBOMDimensionId and 
	SourcingCommitmentItemID=@StyleCommitmentItemID and ItemDim3TypeId=@ItemDim3TypeId and ItemDim3Active=1 and ItemDim3Id is not null 
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
Declare @Qty decimal(18,4)
Declare @Cost decimal(18,4)


select * into #tmpBOMDetails from pSourcingCommitmentBOMDetails where SourcingCommitmentItemID=@StyleCommitmentItemID 

--select @DimCnt as dimcnt
delete from pSourcingCommitmentBOMDetails where SourcingCommitmentItemID=@StyleCommitmentItemID 
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
							set @Qty=0
							set @Cost=0
							select top 1 @Qty=COALESCE(Quantity,0) , @Cost=COALESCE(Cost,0) from #tmpBOMDetails where   
							ItemDim1TypeId=@ItemDim1TypeId and ItemDim2TypeId=@ItemDim2TypeId and ItemDim3TypeId=@ItemDim3TypeId
							and ItemDim1Id=@Dim1ID and ItemDim2Id=@Dim2ID and ItemDim3Id=@Dim3ID
							and ItemDim1Id is not null and ItemDim2Id is not null and ItemDim3Id is not null 
							
							INSERT INTO #tmpDimItem (Dim1ID, Dim2ID, Dim3ID, Dim1Name, Dim2Name, Dim3Name, 
							Dim1Sort, Dim2Sort, Dim3Sort, Dim1Active, Dim2Active, Dim3Active, Quantity, Cost)
							values (@Dim1ID, @Dim2ID, @Dim3ID, @Dim1Name, @Dim2Name, @Dim3Name, 
							@Dim1Sort, @Dim2Sort, @Dim3Sort, 1, 1, 1, @Qty, @Cost)	
											
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
					set @Qty=0
					set @Cost=0
					select top 1 @Qty=COALESCE(Quantity,0) , @Cost=COALESCE(Cost,0) from #tmpBOMDetails where   
					ItemDim1TypeId=@ItemDim1TypeId and ItemDim2TypeId=@ItemDim2TypeId and ItemDim3TypeId=@ItemDim3TypeId
					and ItemDim1Id=@Dim1ID and ItemDim2Id=@Dim2ID 
					and ItemDim1Id is not null and ItemDim2Id is not null 
										
					INSERT INTO #tmpDimItem (Dim1ID, Dim2ID, Dim3ID, Dim1Name, Dim2Name, Dim3Name, 
					Dim1Sort, Dim2Sort, Dim3Sort, Dim1Active, Dim2Active, Dim3Active, Quantity, Cost)
					values (@Dim1ID, @Dim2ID, null, @Dim1Name, @Dim2Name, null, 
					@Dim1Sort, @Dim2Sort, 0, 1, 1, 1, @Qty, @Cost)	
																												
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
					set @Qty=0
					set @Cost=0
					select top 1 @Qty=COALESCE(Quantity,0) , @Cost=COALESCE(Cost,0) from #tmpBOMDetails where   
					ItemDim1TypeId=@ItemDim1TypeId and ItemDim2TypeId=@ItemDim2TypeId and ItemDim3TypeId=@ItemDim3TypeId
					and ItemDim1Id=@Dim1ID and ItemDim3Id=@Dim3ID 
					and ItemDim1Id is not null and ItemDim3Id is not null 
								
					INSERT INTO #tmpDimItem (Dim1ID, Dim2ID, Dim3ID, Dim1Name, Dim2Name, Dim3Name, 
					Dim1Sort, Dim2Sort, Dim3Sort, Dim1Active, Dim2Active, Dim3Active, Quantity, Cost)
					values (@Dim1ID, null, @Dim3ID, @Dim1Name, null, @Dim3Name, 
					@Dim1Sort, 0, @Dim3Sort, 1, 1, 1, @Qty, @Cost)	
																										
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
					set @Qty=0
					set @Cost=0
					select top 1 @Qty=COALESCE(Quantity,0) , @Cost=COALESCE(Cost,0) from #tmpBOMDetails where   
					ItemDim1TypeId=@ItemDim1TypeId and ItemDim2TypeId=@ItemDim2TypeId and ItemDim3TypeId=@ItemDim3TypeId
					and ItemDim2Id=@Dim2ID and ItemDim3Id=@Dim3ID 
					and ItemDim2Id is not null and ItemDim3Id is not null 
								
					INSERT INTO #tmpDimItem (Dim1ID, Dim2ID, Dim3ID, Dim1Name, Dim2Name, Dim3Name, 
					Dim1Sort, Dim2Sort, Dim3Sort, Dim1Active, Dim2Active, Dim3Active, Quantity, Cost)
					values (null, @Dim2ID, @Dim3ID, null, @Dim2Name, @Dim3Name, 
					0, @Dim2Sort, @Dim3Sort, 1, 1, 1, @Qty, @Cost)	
																													
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
	
	INSERT INTO #tmpDimItem (Dim1ID, Dim2ID, Dim3ID, Dim1Name, Dim2Name, Dim3Name, 
	Dim1Sort, Dim2Sort, Dim3Sort, Dim1Active, Dim2Active, Dim3Active, Quantity, Cost)
	select Dim1ID, null, null, Dim1Name, null, null, 
	Dim1Sort, 0, 0, 1, 1, 1 , @Qty, @Cost from #tmpDim1Item
	
	Update #tmpDimItem set Quantity=COALESCE(t.Quantity,0), Cost=COALESCE(t.Cost,0) from #tmpDimItem b
	inner join #tmpBOMDetails t  on b.Dim1ID=t.ItemDim1Id
	where t.ItemDim1Id is not null
	
	
end	

if @Dimsel='2' 
begin
	INSERT INTO #tmpDimItem (Dim1ID, Dim2ID, Dim3ID, Dim1Name, Dim2Name, Dim3Name, 
	Dim1Sort, Dim2Sort, Dim3Sort, Dim1Active, Dim2Active, Dim3Active, Quantity, Cost)
	select null, Dim2ID, null, null, Dim2Name, null, 
	0, Dim2Sort, 0, 1, 1, 1, @Qty, @Cost from #tmpDim2Item
	
	Update #tmpDimItem set Quantity=COALESCE(t.Quantity,0), Cost=COALESCE(t.Cost,0) from #tmpDimItem b
	inner join #tmpBOMDetails t  on b.Dim2ID=t.ItemDim2Id
	where t.ItemDim2Id is not null
	
end
	
if @Dimsel='3' 
begin
				
	INSERT INTO #tmpDimItem (Dim1ID, Dim2ID, Dim3ID, Dim1Name, Dim2Name, Dim3Name, 
	Dim1Sort, Dim2Sort, Dim3Sort, Dim1Active, Dim2Active, Dim3Active, Quantity, Cost)
	select null, null, Dim3ID, null, null, Dim3Name, 
	0, 0, Dim3Sort, 1, 1, 1, @Qty, @Cost from #tmpDim3Item
	
	Update #tmpDimItem set Quantity=COALESCE(t.Quantity,0), Cost=COALESCE(t.Cost,0) from #tmpDimItem b
	inner join #tmpBOMDetails t  on b.Dim3ID=t.ItemDim3Id
	where t.ItemDim3Id is not null
end	

--select * from #tmpDim1Item
Declare @tmpCnt int
select @tmpCnt = COUNT(*) from #tmpDimItem

--select @tmpCnt as tmpCnt

if @tmpCnt>0
begin
	INSERT INTO [dbo].[pSourcingCommitmentBOMDetails]
           ([SourcingCommitmentBOMDetailsID]
           ,[SourcingCommitmentItemID]
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
           ,@StyleCommitmentItemID
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
           ,COALESCE(skui.TotalUnits, Quantity,0)
           ,COALESCE(Cost,0)
           ,COALESCE(skui.TotalUnits, Quantity,0) * COALESCE(Cost,0)
           ,0
           ,0
           ,@MUser
           ,@MUser
           ,@MDate
           ,@MDate from #tmpDimItem di
           LEFT JOIN pStyleSKUItems skui ON skui.StyleSKUItemID = @StyleSKUItemID
			AND (skui.ItemDim1ID IN (di.Dim1ID, di.Dim2ID, di.Dim3ID) OR skui.ItemDim1ID IS NULL)
			AND (skui.ItemDim2ID IN (di.Dim1ID, di.Dim2ID, di.Dim3ID) OR skui.ItemDim2ID IS NULL)
			AND (skui.ItemDim3ID IN (di.Dim1ID, di.Dim2ID, di.Dim3ID) OR skui.ItemDim3ID IS NULL)
           
           --select * from [pSourcingQuotationBOMDetails]
	
end

-- set (Total Units = Wholesale Unit + Retail Unit) if BOM dimensions were not set
IF (SELECT COUNT(*) FROM pSourcingCommitmentBOMDetails WHERE SourcingCommitmentItemID = @StyleCommitmentItemID) = 0
BEGIN
	UPDATE pSourcingCommitmentItem
	SET StyleQuoteItemCustomField16 = ISNULL(StyleQuoteItemCustomField2,'0') + ISNULL(StyleQuoteItemCustomField6,'0')
	WHERE SourcingCommitmentItemID = @StyleCommitmentItemID
END

-- recalculation
exec spx_SourcingCommitmentCostCalculations_Update
		@SourcingHeaderID = @SourcingHeaderID,
		@SourcingCommitmentItemID = @StyleCommitmentItemID,
		@Cuser = @MUser,
		@Cdate = @MDate


drop table #tmpDimItem
drop table #tmpDim1Item
drop table #tmpDim2Item		
drop table #tmpDim3Item
drop table #tmpBOMDetails


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08225', GetDate())
GO
