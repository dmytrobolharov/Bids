IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimMaterialColQty_Update]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleBOMDimMaterialColQty_Update]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleBOMDimMaterialColQty_Update]    Script Date: 09/14/2011 14:22:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_StyleBOMDimMaterialColQty_Update] (

@StyleMaterialID nvarchar(50),

@DimRowId nvarchar(4000),

@DimColId nvarchar(4000),

@DimTabId nvarchar(4000),

@DimRowNo nVarchar(1),

@DimColNo nVarchar(1),

@DimTab nvarchar(1),

@DimValue nVarchar(50),

@StyleBOMDimensionId nvarchar(50),

@StyleID nvarchar(50), 

@StyleSet INT ,

@WorkflowID nvarchar(50), 

@WorkflowItemID nvarchar(50),

@ApplyAll int 

)

AS 	





Declare @ItemDim1TypeId nvarchar(50)	
Declare @ItemDim2TypeId nvarchar(50)	
Declare @ItemDim3TypeId nvarchar(50)	
Declare @Matcnt int
Declare @DimCnt int
Declare @Row_Loop int
Declare @Row_Count int

CREATE TABLE #tmpDimItem (
	Rec_ID INT IDENTITY (1,1),
	ItemId NVARCHAR(50),
	Dim1ID NVARCHAR(50),
	Dim1Name 	NVARCHAR(50),
	Dim1Sort int,
	Dim2ID NVARCHAR(50),
	Dim2Name 	NVARCHAR(50),
	Dim2Sort int,
	Dim3ID NVARCHAR(50),
	Dim3Name 	NVARCHAR(50),
	Dim3Sort int			
	)	



select @DimRowId as 	DimRowId

select @DimColId as 	DimColId

select @DimTabId as 	DimTabId

select @DimRowNo as DimRowNo

select @DimColNo as DimColNo

select @DimTab as  DimTab



select @ItemDim1TypeId = ItemDim1TypeId, @ItemDim2TypeId = ItemDim2TypeId, @ItemDim3TypeId=ItemDim3TypeId

from pStyleBOMDimension where StyleBOMDimensionId = @StyleBOMDimensionId 



select @ItemDim1TypeId as ItemDim1TypeId

select @ItemDim2TypeId as ItemDim2TypeId

select @ItemDim3TypeId as ItemDim3TypeId



select @Matcnt = Count(StyleMaterialID) from pstylebomitem where StyleMaterialID = @StyleMaterialID 



select @DimCnt = COUNT(StyleBOMDimensionId) from pStyleBOMDimensionItems where StyleBOMDimensionId = @StyleBOMDimensionId and 
		ItemDim1Active=1 and ItemDim2Active=1 and ItemDim3Active=1


select @DimCnt as DimCnt



if @ApplyAll=0	

begin	

	If @DimTab <> ''

		begin

			exec('

			insert into #tmpDimItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, Dim2ID, Dim2Name, 

			Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)

			select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, ItemDim2ID, ItemDim2Name,

			ItemDim2Sort, ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems where 

			StyleBOMDimensionId = ''' + @StyleBOMDimensionId + ''' and ItemDim1Active=1 and ItemDim2Active=1

			and ItemDim3Active=1 and ItemDim3ID in (' + @DimTabId + ')  and ItemDim2ID in (' + @DimColId + ') 
			order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name')												

			--insert into #tmpDimItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, Dim2ID, Dim2Name, 

			--Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)

			--select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, ItemDim2ID, ItemDim2Name,

			--ItemDim2Sort, ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems where 

			--StyleBOMDimensionId = @StyleBOMDimensionId and ItemDim1Active=1 and ItemDim2Active=1

			--and ItemDim3Active=1 and ItemDim1ID=@DimRowId and ItemDim2ID=@DimColId and ItemDim3ID=@DimTabId
			--order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name

		end

	else

		begin		

			if @DimColNo='1'

				begin

					exec('

					insert into #tmpDimItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, Dim2ID, Dim2Name, 

					Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)

					select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, ItemDim2ID, ItemDim2Name,

					ItemDim2Sort, ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems where 

					StyleBOMDimensionId = ''' + @StyleBOMDimensionId + ''' and ItemDim1Active=1 and ItemDim2Active=1

					and ItemDim3Active=1 and ItemDim1ID in (' + @DimColId + ')
					order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name')	

					--insert into #tmpDimItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, Dim2ID, Dim2Name, 

					--Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)

					--select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, ItemDim2ID, ItemDim2Name,

					--ItemDim2Sort, ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems where 

					--StyleBOMDimensionId = @StyleBOMDimensionId and ItemDim1Active=1 and ItemDim2Active=1

					--and ItemDim3Active=1 and ItemDim1ID in (@DimColId)
					--order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name

				end

			else if @DimColNo='2'

				begin

					exec('

					insert into #tmpDimItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, Dim2ID, Dim2Name, 

					Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)

					select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, ItemDim2ID, ItemDim2Name,

					ItemDim2Sort, ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems where 

					StyleBOMDimensionId = ''' + @StyleBOMDimensionId + ''' and ItemDim1Active=1 and ItemDim2Active=1

					and ItemDim3Active=1 and ItemDim2ID in (' + @DimColId + ')
					order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name')	

					--insert into #tmpDimItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, 

					--Dim2ID, Dim2Name, Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)

					--select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, ItemDim2ID, ItemDim2Name,

					--ItemDim2Sort, ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems where 

					--StyleBOMDimensionId = @StyleBOMDimensionId and ItemDim1Active=1 and ItemDim2Active=1

					--and ItemDim3Active=1 and ItemDim2ID in (@DimColId)
					--order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name

				end

			else if @DimColNo='3'

				begin

					exec('

					insert into #tmpDimItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, Dim2ID, Dim2Name, 

					Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)

					select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, ItemDim2ID, ItemDim2Name,

					ItemDim2Sort, ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems where 

					StyleBOMDimensionId = ''' + @StyleBOMDimensionId + ''' and ItemDim1Active=1 and ItemDim2Active=1

					and ItemDim3Active=1 and ItemDim3ID in (' + @DimColId + ')
					order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name')	

					--insert into #tmpDimItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, Dim2ID, Dim2Name, 

					--Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)

					--select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, ItemDim2ID, ItemDim2Name,

					--ItemDim2Sort, ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems where 

					--StyleBOMDimensionId = @StyleBOMDimensionId and ItemDim1Active=1 and ItemDim2Active=1

					--and ItemDim3Active=1 and ItemDim3ID in (@DimColId)
					--order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name

				end		

			end	

end
else if @ApplyAll=1
	begin
		If @DimTab <> ''

			begin

				exec('

				insert into #tmpDimItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, Dim2ID, Dim2Name, 

				Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)

				select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, ItemDim2ID, ItemDim2Name,

				ItemDim2Sort, ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems where 

				StyleBOMDimensionId = ''' + @StyleBOMDimensionId + ''' and ItemDim1Active=1 and ItemDim2Active=1

				and ItemDim3Active=1 and ItemDim3ID in (' + @DimTabId + ') and ItemDim1ID in (' + @DimRowId + ') 
				order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name')												

				--insert into #tmpDimItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, Dim2ID, Dim2Name, 

				--Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)

				--select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, ItemDim2ID, ItemDim2Name,

				--ItemDim2Sort, ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems where 

				--StyleBOMDimensionId = @StyleBOMDimensionId and ItemDim1Active=1 and ItemDim2Active=1

				--and ItemDim3Active=1 and ItemDim1ID=@DimRowId and ItemDim2ID=@DimColId and ItemDim3ID=@DimTabId
				--order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name

		end

	else

		begin		

			if @DimRowNo='1'

				begin

					exec('

					insert into #tmpDimItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, Dim2ID, Dim2Name, 

					Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)

					select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, ItemDim2ID, ItemDim2Name,

					ItemDim2Sort, ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems where 

					StyleBOMDimensionId = ''' + @StyleBOMDimensionId + ''' and ItemDim1Active=1 and ItemDim2Active=1

					and ItemDim3Active=1 and ItemDim1ID in (' + @DimRowId + ')
					order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name')	

					--insert into #tmpDimItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, Dim2ID, Dim2Name, 

					--Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)

					--select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, ItemDim2ID, ItemDim2Name,

					--ItemDim2Sort, ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems where 

					--StyleBOMDimensionId = @StyleBOMDimensionId and ItemDim1Active=1 and ItemDim2Active=1

					--and ItemDim3Active=1 and ItemDim1ID in (@DimColId)
					--order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name

				end

			else if @DimRowNo='2'

				begin

					exec('

					insert into #tmpDimItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, Dim2ID, Dim2Name, 

					Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)

					select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, ItemDim2ID, ItemDim2Name,

					ItemDim2Sort, ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems where 

					StyleBOMDimensionId = ''' + @StyleBOMDimensionId + ''' and ItemDim1Active=1 and ItemDim2Active=1

					and ItemDim3Active=1 and ItemDim2ID in (' + @DimRowId + ')
					order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name')	

					--insert into #tmpDimItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, 

					--Dim2ID, Dim2Name, Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)

					--select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, ItemDim2ID, ItemDim2Name,

					--ItemDim2Sort, ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems where 

					--StyleBOMDimensionId = @StyleBOMDimensionId and ItemDim1Active=1 and ItemDim2Active=1

					--and ItemDim3Active=1 and ItemDim2ID in (@DimColId)
					--order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name

				end

			end

			
	end
else if @ApplyAll=2
	begin
		If @DimTab <> ''

			begin

				exec('

				insert into #tmpDimItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, Dim2ID, Dim2Name, 

				Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)

				select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, ItemDim2ID, ItemDim2Name,

				ItemDim2Sort, ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems where 

				StyleBOMDimensionId = ''' + @StyleBOMDimensionId + ''' and ItemDim1Active=1 and ItemDim2Active=1

				and ItemDim3Active=1 and ItemDim3ID in (' + @DimTabId + ')  
				order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name')												

				--insert into #tmpDimItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, Dim2ID, Dim2Name, 

				--Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)

				--select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, ItemDim2ID, ItemDim2Name,

				--ItemDim2Sort, ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems where 

				--StyleBOMDimensionId = @StyleBOMDimensionId and ItemDim1Active=1 and ItemDim2Active=1

				--and ItemDim3Active=1 and ItemDim1ID=@DimRowId and ItemDim2ID=@DimColId and ItemDim3ID=@DimTabId
				--order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name

		end
	end

select * from #tmpDimItem

select @Row_Count = Count(StyleMaterialID) from pstylebomitem where StyleMaterialID=@StyleMaterialID and StyleBOMDimensionItemId in (select ItemId from 
#tmpDimItem) 



Insert into pstylebomitem (StyleBOMDimensionId, StyleBOMDimensionItemId, StyleMaterialID,

WorkflowID, WorkflowItemID, StyleID, StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1ID, ItemDim1Name, ItemDim2ID, ItemDim2Name,

ItemDim3ID, ItemDim3Name,  MaterialQuantity)		

select @StyleBOMDimensionId, ItemId, @StyleMaterialID, @WorkflowID, @WorkflowItemID, @StyleID, @StyleSet,

@ItemDim1TypeId, @ItemDim2TypeId, @ItemDim3TypeId,

Dim1ID, Dim1Name, Dim2ID, Dim2Name, Dim3ID, Dim3Name , 	@DimValue from #tmpDimItem	where ItemId not in (

select StyleBOMDimensionItemId from pstylebomitem where StyleMaterialID=@StyleMaterialID and 

StyleBOMDimensionId=@StyleBOMDimensionId)



Update pstylebomitem set MaterialQuantity=@DimValue from pstylebomitem b

inner join #tmpDimItem t  on b.StyleBOMDimensionItemId=t.ItemId

where b.StyleMaterialID=@StyleMaterialID  		


drop table #tmpDimItem
	
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01949'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01949', GetDate())
END

GO