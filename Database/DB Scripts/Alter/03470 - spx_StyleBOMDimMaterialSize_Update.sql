IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimMaterialSize_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimMaterialSize_Update]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



Create PROCEDURE [dbo].[spx_StyleBOMDimMaterialSize_Update] (

@StyleMaterialID nvarchar(50),

@DimRowId nvarchar(50),

@DimColId nvarchar(50),

@DimTabId nvarchar(50),

@DimRowNo nVarchar(5),

@DimColNo nVarchar(5),

@DimTab nvarchar(5),

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

CREATE TABLE #tmpDimSizeItem (
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



--select @StyleBOMDimensionId as 	StyleBOMDimensionId



select @ItemDim1TypeId = ItemDim1TypeId, @ItemDim2TypeId = ItemDim2TypeId, @ItemDim3TypeId=ItemDim3TypeId

from pStyleBOMDimension where StyleBOMDimensionId = @StyleBOMDimensionId 



select @ItemDim1TypeId as ItemDim1TypeId

select @ItemDim2TypeId as ItemDim2TypeId

select @ItemDim3TypeId as ItemDim3TypeId



select @Matcnt = Count(StyleMaterialID) from pstylebomitem where StyleMaterialID = @StyleMaterialID 



select @DimCnt = COUNT(StyleBOMDimensionId) from pStyleBOMDimensionItems where StyleBOMDimensionId = @StyleBOMDimensionId and 
		ItemDim1Active=1 and ItemDim2Active=1 and ItemDim3Active=1


if @ApplyAll<>1

	begin

		If @DimTab <> ''

			begin

				insert into #tmpDimSizeItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, Dim2ID, Dim2Name, 

				Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)

				select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, ItemDim2ID, ItemDim2Name,

				ItemDim2Sort, ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems where 

				StyleBOMDimensionId = @StyleBOMDimensionId and ItemDim1Active=1 and ItemDim2Active=1

				and ItemDim3Active=1 and ItemDim1ID=@DimRowId and ItemDim2ID=@DimColId and ItemDim3ID=@DimTabId
				order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name

			end

		else

			begin

				if @DimRowId='00000000-0000-0000-0000-000000000000'

				begin

					if @DimColNo='1'

						begin

							insert into #tmpDimSizeItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, Dim2ID, Dim2Name, 

							Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)

							select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, ItemDim2ID, ItemDim2Name,

							ItemDim2Sort, ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems where 

							StyleBOMDimensionId = @StyleBOMDimensionId and ItemDim1Active=1 and ItemDim2Active=1

							and ItemDim3Active=1 and ItemDim1ID=@DimColId
							order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name

						end

					if @DimColNo='2'

						begin

							insert into #tmpDimSizeItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, 

							Dim2ID, Dim2Name, Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)

							select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, ItemDim2ID, ItemDim2Name,

							ItemDim2Sort, ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems where 

							StyleBOMDimensionId = @StyleBOMDimensionId and ItemDim1Active=1 and ItemDim2Active=1

							and ItemDim3Active=1 and ItemDim2ID=@DimColId
							order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name

						end

					if @DimColNo='3'

						begin

							insert into #tmpDimSizeItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, Dim2ID, Dim2Name, 

							Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)

							select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, ItemDim2ID, ItemDim2Name,

							ItemDim2Sort, ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems where 

							StyleBOMDimensionId = @StyleBOMDimensionId and ItemDim1Active=1 and ItemDim2Active=1

							and ItemDim3Active=1 and ItemDim3ID=@DimColId
							order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name

						end	

				end

			else

				begin

					if @DimRowNo='1'

						begin

							select @DimRowNo as DimRowNo

							if @DimColNo='2'					

								begin

									select @DimColNo as DimColNo2

									insert into #tmpDimSizeItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, Dim2ID, Dim2Name, 

									Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)

									select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, ItemDim2ID, ItemDim2Name,

									ItemDim2Sort, ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems where 

									StyleBOMDimensionId = @StyleBOMDimensionId and ItemDim1Active=1 and ItemDim2Active=1

									and ItemDim3Active=1 and ItemDim1ID=@DimRowId and ItemDim2ID=@DimColId
									order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name

								end				

							else if @DimColNo='3'

								begin

									select @DimColNo as DimColNo3

									insert into #tmpDimSizeItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, Dim2ID, Dim2Name, 

									Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)

									select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, ItemDim2ID, ItemDim2Name,

									ItemDim2Sort, ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems where 

									StyleBOMDimensionId = @StyleBOMDimensionId and ItemDim1Active=1 and ItemDim2Active=1

									and ItemDim3Active=1 and ItemDim1ID=@DimRowId and ItemDim3ID=@DimColId
									order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name

								end					

						end

					else if @DimRowNo='2'

							begin

								if @DimColNo='3'

									begin

										insert into #tmpDimSizeItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, Dim2ID, Dim2Name, 

										Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)

										select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, ItemDim2ID, ItemDim2Name,

										ItemDim2Sort, ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems where 

										StyleBOMDimensionId = @StyleBOMDimensionId and ItemDim1Active=1 and ItemDim2Active=1

										and ItemDim3Active=1 and ItemDim2ID=@DimRowId and ItemDim3ID=@DimColId
										order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name

									end	

								end																												

				end

			end



		end

else

	begin

		insert into #tmpDimSizeItem (ItemId, Dim1ID, Dim1Name, Dim1Sort, Dim2ID, Dim2Name, 

		Dim2Sort, Dim3ID, Dim3Name, Dim3Sort)

		select StyleBOMDimensionItemId, ItemDim1ID, ItemDim1Name, ItemDim1Sort, ItemDim2ID, ItemDim2Name,

		ItemDim2Sort, ItemDim3ID, ItemDim3Name, ItemDim3Sort from  pStyleBOMDimensionItems where 

		StyleBOMDimensionId = @StyleBOMDimensionId and ItemDim1Active=1 and ItemDim2Active=1

		and ItemDim3Active=1 				
		order by ItemDim1Sort, ItemDim1Name,ItemDim2Sort, ItemDim2Name,ItemDim3Sort, ItemDim3Name

	end

select @Row_Count = Count(StyleMaterialID) from pstylebomitem where StyleMaterialID=@StyleMaterialID and StyleBOMDimensionItemId in (select ItemId from 
#tmpDimSizeItem) 



--select * from #tmpDimSizeItem



--select @Row_Count as Row_Count



Insert into pstylebomitem (StyleBOMDimensionId, StyleBOMDimensionItemId, StyleMaterialID,

WorkflowID, WorkflowItemID, StyleID, StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1ID, ItemDim1Name, ItemDim2ID, ItemDim2Name,

ItemDim3ID, ItemDim3Name,  MaterialDimension)		

select @StyleBOMDimensionId, ItemId, @StyleMaterialID, @WorkflowID, @WorkflowItemID, @StyleID, @StyleSet,

@ItemDim1TypeId, @ItemDim2TypeId, @ItemDim3TypeId,

Dim1ID, Dim1Name, Dim2ID, Dim2Name, Dim3ID, Dim3Name , 	@DimValue from #tmpDimSizeItem	where ItemId not in (

select StyleBOMDimensionItemId from pstylebomitem where StyleMaterialID=@StyleMaterialID and 

StyleBOMDimensionId=@StyleBOMDimensionId)

				

 Update pstylebomitem set MaterialDimension=@DimValue from pstylebomitem b

 inner join #tmpDimSizeItem t  on b.StyleBOMDimensionItemId=t.ItemId

 where b.StyleMaterialID=@StyleMaterialID   				

				


drop table #tmpDimSizeItem
	


GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03470', GetDate())
GO