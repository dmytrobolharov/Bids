/****** Object:  StoredProcedure [dbo].[spx_StyleBOMMatColorMgmtHdr_Sort_SELECT]    Script Date: 05/14/2013 17:13:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMMatColorMgmtHdr_Sort_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMMatColorMgmtHdr_Sort_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBOMMatColorMgmtHdr_Sort_SELECT]    Script Date: 05/14/2013 17:13:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_StyleBOMMatColorMgmtHdr_Sort_SELECT]
(
@StyleBOMDimensionId nvarchar(50),
@Dimlevel nvarchar(2)
)

as


	CREATE TABLE #tmpDtlMItem (
	DtlID INT IDENTITY (1,1),			
	DimId NVARCHAR(50),
	DimName 	NVARCHAR(50),
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
     

SELECT * FROM #tmpDtlMItem dims INNER JOIN pColorPalette colors ON dims.DimId = colors.ColorPaletteID
ORDER BY DimSort, DimName

DROP TABLE #tmpDtlMItem



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05676', GetDate())
GO
