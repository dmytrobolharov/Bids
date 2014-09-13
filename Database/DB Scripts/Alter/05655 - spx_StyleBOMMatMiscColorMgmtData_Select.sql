/****** Object:  StoredProcedure [dbo].[spx_StyleBOMMatMiscColorMgmtData_Select]    Script Date: 04/30/2013 17:55:24 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMMatMiscColorMgmtData_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMMatMiscColorMgmtData_Select]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBOMMatMiscColorMgmtData_Select]    Script Date: 04/30/2013 17:55:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleBOMMatMiscColorMgmtData_Select]
(
@StyleBOMDimensionId nvarchar(50),
@StyleID uniqueidentifier,
@Styleset int,
@WorkFlowID uniqueidentifier,
@WorkFlowItemID uniqueidentifier,
@ItemDim1 uniqueidentifier,
@ItemDim1Name nvarchar(50),
@ItemDim2 uniqueidentifier,
@ItemDim2Name nvarchar(50),
@ItemDim3 uniqueidentifier,
@ItemDim3Name nvarchar(50),
@Dimlevel nvarchar(2),
@MUser nvarchar(200),
@MDate datetime
)
as


CREATE TABLE #tmpDimItem (
	Mat_ID INT IDENTITY (1,1),
	stylematerialPKId NVARCHAR(50),
	stylematerialId NVARCHAR(50), 	
	materialId NVARCHAR(50), 
	materialno NVARCHAR(50) ,
	Materialname NVARCHAR(100),
	StyleMaterialMiscID NVARCHAR(50), 
	MiscMaterialno NVARCHAR(50) ,
	MiscMaterialname NVARCHAR(100),
	SubMaterial int,
	Placement NVARCHAR(4000),
	Colorway int,
	AutoColor int,
	StyleBOMDimensionId varchar(50),
	WorkflowId nvarchar(50),
	WorkflowItemId nvarchar(50),
	ComponentOrder nvarchar(5),
	MaterialSort nvarchar(5),
	MainMaterial int
	)


	CREATE TABLE #tmpDtlItem (
	Dtl_ID INT IDENTITY (1,1),			
	DimId NVARCHAR(50),
	DimName 	NVARCHAR(50),
	DimSort int			
	)
		
		
	CREATE TABLE #tmpskuItem (
	SKUID INT IDENTITY (1,1),
	MatID int,
	DtlID INT ,
	stylematerialId NVARCHAR(50), 
	materialId NVARCHAR(50), 
	materialname NVARCHAR(100) ,
	materialno NVARCHAR(50),
	Placement	NVARCHAR(4000) ,	
	DimID NVARCHAR(50),
	DimName 	NVARCHAR(50),
	DimSort int,	
	MaterialQuantity float,	
	MaterialDimension NVARCHAR(50),
	MaterialColorId NVARCHAR(50),		
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
declare @Placement nvarchar(4000)

set @Rowcnt=1
set @Skuloop=1

--'AAA2A0D0-6D50-4D9C-8DC6-15F664D717B4'

insert into #tmpDimItem (styleMaterialPKId, stylematerialId, materialId, materialno, materialname, StyleMaterialMiscID,
MiscMaterialno, MiscMaterialname,  SubMaterial, Placement, Colorway, AutoColor, StyleBOMDimensionId, 
WorkflowId, WorkflowItemId, ComponentOrder,MaterialSort,MainMaterial )
select stylematerialId as styleMaterialPKId, stylematerialId, materialId, materialno, materialname, 
'00000000-0000-0000-0000-000000000000' as StyleMaterialMiscID, 
'' as MiscMaterialno, '' as MiscMaterialname, 0 as SubMaterial, Placement, Colorway, AUTOCOLOR, StyleBOMDimensionId, WorkflowId, 
WorkflowItemId, ComponentOrder, MaterialSort, MainMaterial from pStyleBOM 					
INNER JOIN  pComponentType ON pStyleBOM.MaterialType = pComponentType.ComponentTypeID 
where 	StyleBOMDimensionId = @StyleBOMDimensionId
union
select p.StyleMaterialMiscID as styleMaterialPKId, b.stylematerialId,  b.materialId, b.materialno, b.materialname, p.StyleMaterialMiscID,
p.MaterialNo as MiscMaterialno, p.Materialname as MiscMaterialname ,  1 as SubMaterial, b.Placement, b.Colorway, b.AutoColor, 
b.StyleBOMDimensionId, b.WorkflowId, b.WorkflowItemId, ComponentOrder, MaterialSort, MainMaterial from pStyleBOM b					
INNER JOIN  pStyleBOMMiscItem p ON  b.stylematerialId = p.stylematerialId
and b.StyleBOMDimensionId = p.StyleBOMDimensionId 
INNER JOIN  pComponentType ON b.MaterialType = pComponentType.ComponentTypeID 
where 	b.StyleBOMDimensionId = @StyleBOMDimensionId
ORDER BY pStyleBOM.MainMaterial DESC, pComponentType.ComponentOrder, 
pStyleBOM.MaterialSort, pStyleBOM.MaterialNo, pStyleBOM.MaterialName, SubMaterial, pStyleBOM.StyleMaterialId
	
update #tmpDimItem set 	materialno=MiscMaterialno, Materialname=MiscMaterialname 
from  pStyleBOMMiscItem p inner join #tmpDimItem t on p.stylematerialId=t.stylematerialId and 
p.StyleMaterialMiscID=t.StyleMaterialMiscID and p.StyleBOMDimensionId=@StyleBOMDimensionId

If @Dimlevel = '1'
	begin
		insert into #tmpDtlItem (DimId, DimName, DimSort)		
		Select distinct(ItemDim1Id) as DimId, ItemDim1Name as DimName, ItemDim1sort as DimSort FROM pStyleBOMDimensionitem where StyleBOMDimensionId=@StyleBOMDimensionId
		and ItemDim1Id is not null  and ItemDim1Active=1 order by ItemDim1sort, ItemDim1Name
    end
 else if  @Dimlevel = '2'  
	begin
		insert into #tmpDtlItem (DimId, DimName, DimSort)
		Select distinct(ItemDim2Id) as DimId, ItemDim2Name as DimName, ItemDim2sort as DimSort FROM pStyleBOMDimensionitem where StyleBOMDimensionId=@StyleBOMDimensionId
		and ItemDim2Id is not null  and ItemDim2Active=1 order by ItemDim2sort, ItemDim2Name
    end
 else if @Dimlevel = '3'
	begin
		insert into #tmpDtlItem (DimId, DimName, DimSort)
		Select distinct(ItemDim3Id) as DimId, ItemDim3Name as DimName, ItemDim3sort as DimSort FROM pStyleBOMDimensionitem where StyleBOMDimensionId=@StyleBOMDimensionId
		and ItemDim3Id is not null  and ItemDim3Active=1 order by ItemDim3sort, ItemDim3Name
    end
else if @Dimlevel = ''
	begin
		insert into #tmpDtlItem (DimId, DimName, DimSort)
		Select top 1 '00000000-0000-0000-0000-000000000000' as DimId, '' as DimName, '0' as DimSort FROM pStyleBOMDimensionitem where StyleBOMDimensionId=@StyleBOMDimensionId
	end	


select @Matcnt=COUNT(*) from #tmpDimItem

select @Skucnt=COUNT(*) from #tmpDtlItem 

--where StyleBOMDimensionId='7CA1620C-F506-455F-8E05-F1EA8FBF7913'



WHILE @Rowcnt <= @Matcnt 


	begin


		select @stylematerialId = stylematerialId, @materialId = materialId,


		@materialno = materialno, @materialname = materialname , @Placement = Placement


		from #tmpDimItem where Mat_ID=@Rowcnt


		If  @Skucnt>0     


			begin


				insert into #tmpskuItem (MatID, DtlID , stylematerialId, materialId, materialno, materialname,


				Placement, DimID, DimName, DimSort)


				select @Rowcnt, Dtl_ID, @stylematerialId, @materialId, @materialno, @materialname,


				@Placement, DimID, DimName, DimSort from #tmpdtlItem 


				 --where StyleBOMDimensionId='7CA1620C-F506-455F-8E05-F1EA8FBF7913'			    			


			end


		set @Rowcnt=@Rowcnt +1


	end		


	


	If @Dimlevel = '1'


		begin


			update #tmpskuItem set MaterialQuantity=p.MaterialQuantity, MaterialDimension=p.MaterialDimension, MaterialColorId=p.MaterialColorId


			from  pstylebomitem p inner join #tmpskuItem t on p.Itemdim1Id=t.dimId and 


			p.stylematerialId=t.stylematerialId and p.StyleBOMDimensionId=@StyleBOMDimensionId


		end


	else If @Dimlevel = '2'


		begin


			update #tmpskuItem set MaterialQuantity=p.MaterialQuantity, MaterialDimension=p.MaterialDimension, MaterialColorId=p.MaterialColorId


			from  pstylebomitem p inner join #tmpskuItem t on p.Itemdim2Id=t.dimId and 


			p.stylematerialId=t.stylematerialId and p.StyleBOMDimensionId=@StyleBOMDimensionId


		end


	else If @Dimlevel = '3'


		begin


			update #tmpskuItem set MaterialQuantity=p.MaterialQuantity, MaterialDimension=p.MaterialDimension, MaterialColorId=p.MaterialColorId


			from  pStyleBOMItem p inner join #tmpskuItem t on p.Itemdim3Id=t.dimId and 


			p.StyleMaterialID=t.stylematerialId and p.StyleBOMDimensionId=@StyleBOMDimensionId


		end

	


	DECLARE @query NVARCHAR(max)


	


	DECLARE @cols NVARCHAR(2000)

declare @AmlMeasHdrID nvarchar(50)
Declare @IncrCol nvarchar(200)
Declare @IncrCols nvarchar(2000)
Declare @IncrNullCols nvarchar(2000)
set @IncrCols = ''

if @Skuloop >= @Skucnt 
set @Skucnt = @Skuloop + 1

WHILE @Skuloop <= @Skucnt
	begin
		set @IncrCols = @IncrCols + '[' + convert(nvarchar(3), @Skuloop) + ']' + ','			
		set @Skuloop = @Skuloop + 1		
		--set @IncrCols = @IncrCols + 'Size' + convert(nvarchar(3), @Skuloop) + ','				
		--set @Skuloop = @Skuloop + 1
	end	
	if right(@IncrCols,1)=',' set @IncrCols=substring(@IncrCols, 1, len(@IncrCols)-1)
	


	SET @query = N'SELECT mat_id, styleMaterialPKId, stylematerialId, materialId, materialno, materialname, 
	StyleMaterialMiscID, SubMaterial, Placement, AutoColor, 
	StyleBOMDimensionId, WorkflowId, WorkflowItemId, ' + @IncrCols + '
	FROM
		(SELECT  t2.mat_id, t2.styleMaterialPKId, t2.stylematerialId, t2.materialId, t2.materialno, t2.materialname, 
		t2.StyleMaterialMiscID,  t2.SubMaterial,
		t2.Placement, t2.AutoColor,	t2.StyleBOMDimensionId, t2.WorkflowId, t2.WorkflowItemId,  
		t1.dtl_id, t3.MaterialColorId			  
		FROM    #tmpDtlItem AS t1
		inner join #tmpskuItem as t3 on t3.dtlid=t1.dtl_id and t3.dimid=t1.dimid
				INNER JOIN #tmpdimItem AS t2 ON t2.stylematerialId = t3.stylematerialId and
				t2.materialId = t3.materialId and t2.mat_id=t3.matid and t2.colorway=1 ) p
				 PIVOT(MAX([MaterialColorId])
		FOR dtl_id IN  ('+@IncrCols +') ) AS pvt ORDER BY mat_id ;'


EXEC (@query) 


 drop table #tmpDimItem
 drop table #tmpDtlItem
 drop table #tmpskuItem





GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05655', GetDate())
GO
