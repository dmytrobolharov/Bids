
/****** Object:  StoredProcedure [dbo].[spx_Sourcing_StyleBOMDimItem_select]    Script Date: 10/15/2012 11:29:23 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_StyleBOMDimItem_select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_StyleBOMDimItem_select]
GO


GO

/****** Object:  StoredProcedure [dbo].[spx_Sourcing_StyleBOMDimItem_select]    Script Date: 10/15/2012 11:29:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE  PROCEDURE [dbo].[spx_Sourcing_StyleBOMDimItem_select](
@StyleQuoteItemId nvarchar(50),
@StyleBOMDimensionId nvarchar(50),
@DimLevel Int
)
AS 
	Declare  @columns nvarchar(max)   
	Declare  @cols nvarchar(max)
	Declare  @sqlQuery nvarchar(max)  
	Declare @TotalCnt int

	SELECT @TotalCnt = Count(StyleBOMDimensionItemID) FROM pSourcingQuoteStyleBOM  where StyleBOMDimensionId = @StyleBOMDimensionId
	and StyleQuoteItemId=@StyleQuoteItemId	
		
	--set @styleid='9ffebe02-f186-4521-b352-fc0718711852'
	--set @styleset=1
	CREATE TABLE #tmpDimItem (
	Rec_ID INT IDENTITY (1,1),
	DimID NVARCHAR(50),
	DimName 	NVARCHAR(50),	
	Sort NVARCHAR(5)	
	)	
	
	Declare @Active nvarchar(10)
	set @Active= ' Active:' 
	if @TotalCnt > 0
		begin											
			if @DimLevel=1
				begin
					INSERT INTO #tmpDimItem (DimID, DimName, Sort)
						SELECT cast(ItemDim1Id as nvarchar(50)) + @Active + cast(ItemDim1Active as nvarchar(5)), ItemDim1Name, cast(ItemDim1Sort as nvarchar(5)) FROM pSourcingQuoteStyleBOM  where StyleBOMDimensionId = @StyleBOMDimensionId
						and ItemDim1Id is not null order by ItemDim1Sort, ItemDim1Name
						
					SELECT  @cols = COALESCE(@cols + ',[' +  cast(Rec_ID as nvarchar(5)) + '] as Dim1Name' + cast(Rec_ID as nvarchar(5)) ,
                         ' [' +  cast(Rec_ID as nvarchar(5)) + '] as Dim1Name' + cast(Rec_ID as nvarchar(5)))
					FROM    #tmpDimItem 
					ORDER BY Rec_ID								
				end
			if @DimLevel=2
				begin
					INSERT INTO #tmpDimItem (DimID, DimName, Sort)
					SELECT  cast(ItemDim2Id as nvarchar(50)) + @Active + cast(ItemDim2Active as nvarchar(5)), ItemDim2Name, cast(ItemDim2Sort as nvarchar(5)) FROM pSourcingQuoteStyleBOM  where StyleBOMDimensionId = @StyleBOMDimensionId
					and ItemDim2Id is not null order by ItemDim2Sort, ItemDim2Name
					
					SELECT  @cols = COALESCE(@cols + ',[' +  cast(Rec_ID as nvarchar(5)) + '] as Dim2Name' + cast(Rec_ID as nvarchar(5)) ,
                         ' [' +  cast(Rec_ID as nvarchar(5)) + '] as Dim2Name' + cast(Rec_ID as nvarchar(5)))
					FROM    #tmpDimItem 
					ORDER BY Rec_ID							
				end
				
			if @DimLevel=3
				begin
					INSERT INTO #tmpDimItem (DimID, DimName, Sort)
					SELECT  cast(ItemDim3Id as nvarchar(50)) + @Active + cast(ItemDim3Active as nvarchar(5)) , ItemDim3Name, cast(ItemDim3Sort as nvarchar(5)) FROM pSourcingQuoteStyleBOM  where StyleBOMDimensionId = @StyleBOMDimensionId
					and ItemDim3Id is not null order by ItemDim3Sort, ItemDim3Name
					
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
VALUES     ('DB_Version', '5.0.0000', '04186', GetDate())
GO