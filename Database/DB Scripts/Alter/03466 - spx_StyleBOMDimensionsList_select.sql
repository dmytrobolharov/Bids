IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMDimensionsList_select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMDimensionsList_select]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



Create PROCEDURE [dbo].[spx_StyleBOMDimensionsList_select](

@StyleID nvarchar(50), 

@StyleSet INT ,

@Dimlevel int,

@WorkflowID nvarchar(50), 

@WorkflowItemID nvarchar(50),
@StyleBOMDimensionId nvarchar(50)
)

AS 


--select @Dimlevel as dimlevel

Declare @TotalCnt int



SELECT @TotalCnt = Count(StyleBOMDimensionItemID) FROM pStyleBOMDimensionItem  where StyleBOMDimensionId = @StyleBOMDimensionId


CREATE TABLE #tmpDimItem (
	Rec_ID INT IDENTITY (1,1),
	DimID NVARCHAR(50),
	DimName 	NVARCHAR(50),	
	Sort int		
	)	

					

if @TotalCnt > 0

	begin

		if @Dimlevel=1

			begin

				insert into #tmpDimItem (DimID,DimName,Sort)
				select Distinct(ItemDim1Id) as StyleBOMDimensionItemID, ItemDim1Name as StyleBOMDimensionDesc, ItemDim1Sort
				from pStyleBOMDimensionItems where StyleBOMDimensionId = @StyleBOMDimensionId and 
				ItemDim1Active=1 and ItemDim1Id is not null order by ItemDim1Sort, ItemDim1Name

			end	

		else if @Dimlevel=2

			begin

			--select @Dimlevel as dimlevel

				insert into #tmpDimItem (DimID,DimName,Sort)

				select Distinct(ItemDim2Id) as StyleBOMDimensionItemID, StyleBOMDimensionDesc=ItemDim2Name , ItemDim2Sort
				from pStyleBOMDimensionItems where StyleBOMDimensionId = @StyleBOMDimensionId and 
				ItemDim2Active=1 and ItemDim2Id is not null order by ItemDim2Sort, ItemDim2Name

			end	

		else if @Dimlevel=3

			begin

				insert into #tmpDimItem (DimID,DimName,Sort)

				select Distinct(ItemDim3Id) as StyleBOMDimensionItemID, StyleBOMDimensionDesc=ItemDim3Name , ItemDim3Sort
				from pStyleBOMDimensionItems where StyleBOMDimensionId = @StyleBOMDimensionId and 
				ItemDim3Active=1 and ItemDim3Id is not null order by ItemDim3Sort, ItemDim3Name

			end	

	end

	

	select DimID, DimName from #tmpDimItem order by sort,DimName

	

	drop table #tmpDimItem


GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03466', GetDate())
GO