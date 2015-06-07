IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_StyleBOMCommitmentDimItem_select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_StyleBOMCommitmentDimItem_select]
GO



CREATE  PROCEDURE [dbo].[spx_Sourcing_StyleBOMCommitmentDimItem_select](
@CommitmentItemId nvarchar(50),
@StyleBOMDimensionId nvarchar(50),
@DimLevel Int
)
AS 
	Declare  @columns nvarchar(max)   
	Declare  @cols nvarchar(max)
	Declare  @sqlQuery nvarchar(max)  
	Declare @TotalCnt int

	SELECT @TotalCnt = Count(StyleBOMDimensionItemID) FROM pSourcingCommitmentBOM  where StyleBOMDimensionId = @StyleBOMDimensionId
	and SourcingCommitmentItemID=@CommitmentItemId	and NotShow <> 1
		
	--set @styleid='9ffebe02-f186-4521-b352-fc0718711852'
	--set @styleset=1
	CREATE TABLE #tmpDimItem (
	Rec_ID INT IDENTITY (1,1),
	DimID NVARCHAR(50),
	DimName 	NVARCHAR(200),	
	Sort NVARCHAR(5)	
	)	
	
	Declare @Active nvarchar(10)
	set @Active= ' Active:' 
	if @TotalCnt > 0
		begin											
			if @DimLevel=1
				begin
					INSERT INTO #tmpDimItem (DimID, DimName, Sort)
						SELECT cast(a.ItemDim1Id as nvarchar(50)) + @Active + cast(a.ItemDim1Active as nvarchar(5)), a.ItemDim1Name, cast(a.ItemDim1Sort as nvarchar(5)) FROM pSourcingCommitmentBOM a, pStyleBOMDimensionItem b  where a.StyleBOMDimensionId = @StyleBOMDimensionId 
						and b.ItemDim1Active = 1 and a.StyleBOMDimensionItemID = b.StyleBOMDimensionItemID and a.NotShow <> 1 
						and a.SourcingCommitmentItemID=@CommitmentItemId	 and a.ItemDim1Id is not null order by a.ItemDim1Sort, ItemDim1Name
						
					SELECT  @cols = COALESCE(@cols + ',[' +  cast(Rec_ID as nvarchar(5)) + '] as Dim1Name' + cast(Rec_ID as nvarchar(5)) ,
                         ' [' +  cast(Rec_ID as nvarchar(5)) + '] as Dim1Name' + cast(Rec_ID as nvarchar(5)))
					FROM    #tmpDimItem 
					ORDER BY Rec_ID								
				end
			if @DimLevel=2
				begin
					INSERT INTO #tmpDimItem (DimID, DimName, Sort)
					SELECT  cast(a.ItemDim2Id as nvarchar(50)) + @Active + cast(a.ItemDim2Active as nvarchar(5)), a.ItemDim2Name, cast(a.ItemDim2Sort as nvarchar(5)) FROM pSourcingCommitmentBOM a, pStyleBOMDimensionItem b  where a.StyleBOMDimensionId = @StyleBOMDimensionId
					and a.SourcingCommitmentItemID=@CommitmentItemId	and a.NotShow <> 1 
					and b.ItemDim2Active=1  and a.StyleBOMDimensionItemID = b.StyleBOMDimensionItemID
					and a.ItemDim2Id is not null order by a.ItemDim2Sort, ItemDim2Name
					
					SELECT  @cols = COALESCE(@cols + ',[' +  cast(Rec_ID as nvarchar(5)) + '] as Dim2Name' + cast(Rec_ID as nvarchar(5)) ,
                         ' [' +  cast(Rec_ID as nvarchar(5)) + '] as Dim2Name' + cast(Rec_ID as nvarchar(5)))
					FROM    #tmpDimItem 
					ORDER BY Rec_ID							
				end
				
			if @DimLevel=3
				begin
					INSERT INTO #tmpDimItem (DimID, DimName, Sort)
					SELECT  cast(a.ItemDim3Id as nvarchar(50)) + @Active + cast(a.ItemDim3Active as nvarchar(5)) , a.ItemDim3Name, cast(a.ItemDim3Sort as nvarchar(5)) FROM pSourcingCommitmentBOM a, pStyleBOMDimensionItem b  where a.StyleBOMDimensionId = @StyleBOMDimensionId
					and a.SourcingCommitmentItemID=@CommitmentItemId	 and a.NotShow <> 1 
					and b.ItemDim3Active = 1  and a.StyleBOMDimensionItemID = b.StyleBOMDimensionItemID
					and a.ItemDim3Id is not null order by a.ItemDim3Sort, ItemDim3Name
					
					SELECT  @cols = COALESCE(@cols + ',[' +  cast(Rec_ID as nvarchar(5)) + '] as Dim3Name' + cast(Rec_ID as nvarchar(5)) ,
                         ' [' +  cast(Rec_ID as nvarchar(5)) + '] as Dim3Name' + cast(Rec_ID as nvarchar(5)))
					FROM    #tmpDimItem 
					ORDER BY Rec_ID											
				end							
		end
	
	
	SELECT  @columns = COALESCE(@columns + ',[' +  cast(Rec_ID as nvarchar(5)) + ']',
                         '[' +  cast(Rec_ID as nvarchar(5)) + ']')
	FROM    #tmpDimItem
	ORDER BY Rec_ID	
     
     set @sqlQuery = ' SELECT ' +  @cols + '  FROM 
		(SELECT Rec_ID, DimID from #tmpDimItem ) p
		PIVOT
		(
		MAX([DimID])
		FOR Rec_ID IN
		( ' + @columns + ' )
		) AS pvt '	
		
	--select @sqlQuery as sqlquery	
	Execute(@sqlQuery)	
	--select * from  #tmpDimItem
	drop table #tmpDimItem
	




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10228', GetUTCDate())
GO
