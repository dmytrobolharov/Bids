IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimManage_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimManage_Select]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



Create PROCEDURE [dbo].[spx_StyleBOMDimManage_Select] (
@StyleBOMDimensionId nvarchar(50),
@StyleID nvarchar(50), 
@StyleSet INT ,
@WorkflowID nvarchar(50), 
@WorkflowItemID nvarchar(50)
)

AS 

Declare @ItemDim1TypeId nvarchar(50)	
Declare @ItemDim2TypeId nvarchar(50)	
Declare @ItemDim3TypeId nvarchar(50)	
Declare @ItemDim1TypeName nvarchar(50)	
Declare @ItemDim2TypeName nvarchar(50)	
Declare @ItemDim3TypeName nvarchar(50)	
Declare @Matcnt int
Declare @DimCnt int
Declare @Row_Loop int
Declare @Row_Count int

CREATE TABLE #tmpDimItem (
	Rec_ID INT IDENTITY (1,1),	
	DimId NVARCHAR(3)	,
	DimName 	NVARCHAR(50),
	DimCnt int		
)

select @ItemDim1TypeId = ItemDim1TypeId, @ItemDim2TypeId = ItemDim2TypeId, @ItemDim3TypeId=ItemDim3TypeId,
@ItemDim1TypeName = ItemDim1TypeName, @ItemDim2TypeName = ItemDim2TypeName, @ItemDim3TypeName=ItemDim3TypeName 
from pStyleBOMDimension where StyleBOMDimensionId = @StyleBOMDimensionId 


--1	
set @DimCnt=0
Select @DimCnt = COUNT(StyleMaterialId) from pStyleBOM where StyleBOMDimensionId=@StyleBOMDimensionId
and  Dim1TypeSel=1 and (Dim2TypeSel=0 or Dim2TypeSel is null) and (Dim3TypeSel=0 or Dim3TypeSel is null)


if @DimCnt>0
	begin
		insert into #tmpDimItem (DimId,DimName,DimCnt) values ('1',@ItemDim1TypeName,@DimCnt)		
	end	
	
--2	
set @DimCnt=0
Select @DimCnt = COUNT(StyleMaterialId) from pStyleBOM where StyleBOMDimensionId=@StyleBOMDimensionId
and  Dim2TypeSel=1 and (Dim1TypeSel=0 or Dim1TypeSel is null) and (Dim3TypeSel=0 or Dim3TypeSel is null)
if @DimCnt>0
	begin
		insert into #tmpDimItem (DimId,DimName,DimCnt) values ('2',@ItemDim2TypeName,@DimCnt)		
	end	
	
--3	
set @DimCnt=0
Select @DimCnt = COUNT(StyleMaterialId) from pStyleBOM where StyleBOMDimensionId=@StyleBOMDimensionId
and  Dim3TypeSel=1 and (Dim2TypeSel=0 or Dim2TypeSel is null) and (Dim1TypeSel=0 or Dim1TypeSel is null)
if @DimCnt>0
	begin
		insert into #tmpDimItem (DimId,DimName,DimCnt) values ('3',@ItemDim3TypeName,@DimCnt)		
	end	
	
--12	
set @DimCnt=0
Select @DimCnt = COUNT(StyleMaterialId) from pStyleBOM where StyleBOMDimensionId=@StyleBOMDimensionId
and Dim1TypeSel=1 and Dim2TypeSel=1 and (Dim3TypeSel=0 or Dim3TypeSel is null) 
if @DimCnt>0
	begin
		insert into #tmpDimItem (DimId,DimName,DimCnt) values ('12',@ItemDim1TypeName + '/' + @ItemDim2TypeName,@DimCnt)		
	end	
	
--13	
set @DimCnt=0
Select @DimCnt = COUNT(StyleMaterialId) from pStyleBOM where StyleBOMDimensionId=@StyleBOMDimensionId
and Dim1TypeSel=1 and Dim3TypeSel=1 and (Dim2TypeSel=0 or Dim2TypeSel is null) 
if @DimCnt>0
	begin
		insert into #tmpDimItem (DimId,DimName,DimCnt) values ('13',@ItemDim1TypeName + '/' + @ItemDim3TypeName,@DimCnt)		
	end	
	
--23	
set @DimCnt=0
Select @DimCnt = COUNT(StyleMaterialId) from pStyleBOM where StyleBOMDimensionId=@StyleBOMDimensionId
and Dim2TypeSel=1 and Dim3TypeSel=1 and (Dim1TypeSel=0 or Dim1TypeSel is null) 
if @DimCnt>0
	begin
		insert into #tmpDimItem (DimId,DimName,DimCnt) values ('23',@ItemDim2TypeName + '/' + @ItemDim3TypeName,@DimCnt)		
	end	
		
--123
set @DimCnt=0
Select @DimCnt = COUNT(StyleMaterialId) from pStyleBOM where StyleBOMDimensionId=@StyleBOMDimensionId
and Dim1TypeSel=1 and Dim2TypeSel=1 and Dim3TypeSel=1 
if @DimCnt>0
	begin
		insert into #tmpDimItem (DimId,DimName,DimCnt) values ('123',@ItemDim1TypeName + '/' + @ItemDim2TypeName + '/' + @ItemDim3TypeName,@DimCnt)		
	end
	
select * from #tmpDimItem

drop table #tmpDimItem

GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03463', GetDate())
GO