IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMMatColorMgmtHdr_select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMMatColorMgmtHdr_select]
GO


CREATE PROCEDURE [dbo].[spx_StyleBOMMatColorMgmtHdr_select]
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
@Dimlevel nvarchar(2),
@MUser nvarchar(200),
@MDate datetime
)

as


	CREATE TABLE #tmpDtlMItem (
	DtlID INT IDENTITY (1,1),			
	DimId NVARCHAR(50),
	DimName 	NVARCHAR(200),
	DimSort int			
	)
		
		
		
declare @Matcnt int	
declare @Rowcnt int	
declare @Skucnt int	
declare @Skuloop int	
declare @smaterailid nvarchar(50)
declare @materialid nvarchar(50)
declare @materialno nvarchar(50)
declare @materialname nvarchar(100)
declare @stylematerialId nvarchar(50)

set @Rowcnt=1
set @Skuloop=1
					
If @Dimlevel = '1'
	begin
		insert into #tmpDtlMItem (DimId, DimName, DimSort)		
		Select distinct(ItemDim1Id) as DimId, ItemDim1Name as DimName, ItemDim1sort as DimSort FROM 
		pStyleBOMDimensionitem where StyleBOMDimensionId=@StyleBOMDimensionId
		and ItemDim1Id is not null  and ItemDim1Active=1 order by ItemDim1sort, ItemDim1Name
    end
 else if  @Dimlevel = '2'  
	begin
		insert into #tmpDtlMItem (DimId, DimName, DimSort)
		Select distinct(ItemDim2Id) as DimId, ItemDim2Name as DimName, ItemDim2sort as DimSort FROM 
		pStyleBOMDimensionitem where StyleBOMDimensionId=@StyleBOMDimensionId
		and ItemDim2Id is not null  and ItemDim2Active=1 order by ItemDim2sort, ItemDim2Name
    end
 else if @Dimlevel = '3'
	begin
		insert into #tmpDtlMItem (DimId, DimName, DimSort)
		Select distinct(ItemDim3Id) as DimId, ItemDim3Name as DimName, ItemDim3sort as DimSort FROM 
		pStyleBOMDimensionitem where StyleBOMDimensionId=@StyleBOMDimensionId
		and ItemDim3Id is not null  and ItemDim3Active=1 order by ItemDim3sort, ItemDim3Name
    end
else if @Dimlevel = ''
	begin
		insert into #tmpDtlMItem (DimId, DimName, DimSort)
		Select top 1 '00000000-0000-0000-0000-000000000000' as DimId, '' as DimName, '0' as DimSort FROM pStyleBOMDimensionitem where StyleBOMDimensionId=@StyleBOMDimensionId
	end
     

select * from #tmpDtlMItem

drop table #tmpDtlMItem



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10270', GetUTCDate())
GO
