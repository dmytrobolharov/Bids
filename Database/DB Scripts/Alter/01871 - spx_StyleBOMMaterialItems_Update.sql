IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMMaterialItems_Update]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleBOMMaterialItems_Update]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleBOMMaterialItems_Update]    Script Date: 09/06/2011 12:13:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Stored Procedure

Create PROCEDURE [dbo].[spx_StyleBOMMaterialItems_Update]
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
@MUser nvarchar(200),
@MDate datetime
)
AS 

Declare @ItemDim1TypeId uniqueidentifier	
Declare @ItemDim2TypeId uniqueidentifier	
Declare @ItemDim3TypeId uniqueidentifier
Declare @DimCnt int
Declare @oldItemDim1TypeId nvarchar(50)
Declare @oldItemDim2TypeId nvarchar(50)
Declare @oldItemDim3TypeId nvarchar(50)
Declare @oldDimCnt int
Declare @tmpCnt int
	


set @DimCnt=0
set @oldDimCnt=0


select @ItemDim1TypeId = COALESCE(ItemDim1TypeId,'00000000-0000-0000-0000-000000000000') , @ItemDim2TypeId = COALESCE(ItemDim2TypeId,'00000000-0000-0000-0000-000000000000'), 
@ItemDim3TypeId=COALESCE(ItemDim3TypeId,'00000000-0000-0000-0000-000000000000')
from pStyleBOMDimension where StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50))

select @tmpCnt = COUNT(StyleBOMDimensionId) from  pStyleBOMDimensionItems where StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50))

select top 1  @oldItemDim1TypeId = COALESCE(ItemDim1TypeId,'00000000-0000-0000-0000-000000000000') ,  
@oldItemDim2TypeId = COALESCE(ItemDim2TypeId,'00000000-0000-0000-0000-000000000000'), 
@oldItemDim3TypeId = COALESCE(ItemDim3TypeId,'00000000-0000-0000-0000-000000000000')
from pStylebomitem where StyleBOMDimensionId=@StyleBOMDimensionId
and StyleID=@StyleID and  StyleSet=@StyleSet and WorkflowID=@WorkflowID and
WorkflowItemID=@WorkflowItemID

Declare @blnChange int
Declare @blnDimAdd int
Declare @blndrop int
set @blnDimAdd=0
set @blnChange=0
set @blndrop=0
if @ItemDim1TypeId<>@oldItemDim1TypeId
begin
	set @blnChange=1
end 

if @ItemDim2TypeId<>@oldItemDim2TypeId
begin
	set @blnChange=1
end 

if @ItemDim3TypeId<>@oldItemDim3TypeId
begin
	set @blnChange=1
end 
	
if 	@blnChange=1 
begin
	if (@ItemDim1TypeId<>'00000000-0000-0000-0000-000000000000') and  (@ItemDim2TypeId<>'00000000-0000-0000-0000-000000000000') 
	and (@ItemDim3TypeId<>'00000000-0000-0000-0000-000000000000')
		begin
			set @DimCnt=3
		end
	else
		begin
			if (@ItemDim1TypeId<>'00000000-0000-0000-0000-000000000000') and (@ItemDim2TypeId<>'00000000-0000-0000-0000-000000000000')
				begin
					set @DimCnt=2
				end
			else
				begin
					set @DimCnt=1
				end
		end 

	if (@oldItemDim1TypeId<>'00000000-0000-0000-0000-000000000000') and  (@oldItemDim2TypeId<>'00000000-0000-0000-0000-000000000000') 
	and (@oldItemDim3TypeId<>'00000000-0000-0000-0000-000000000000')
		begin
			set @oldDimCnt=3
		end
	else
		begin
			if (@oldItemDim1TypeId<>'00000000-0000-0000-0000-000000000000') and (@oldItemDim2TypeId<>'00000000-0000-0000-0000-000000000000')
				begin
					set @oldDimCnt=2
				end
			else
				begin
					set @oldDimCnt=1
				end
		end

	

	if 	@DimCnt>@oldDimCnt
		begin
			if (@DimCnt=3) and (@oldDimCnt=2)
				begin
					if (@ItemDim1TypeId=@oldItemDim1TypeId) and (@ItemDim2TypeId=@oldItemDim2TypeId)
						begin
							set @blnDimAdd=2
						end
				end
			else if (@DimCnt=2) and (@oldDimCnt=1)
				begin
					if (@ItemDim1TypeId=@oldItemDim1TypeId)
						begin
							set @blnDimAdd=1
						end
				end
		end
	else if @DimCnt<@oldDimCnt
		begin
			if (@ItemDim1TypeId=@oldItemDim1TypeId)
				begin
					set @blnDimAdd=1
				end
		end
		
	select @blnDimAdd as blnDimAdd
	select @blnChange as blnChange
	select @DimCnt as DimCnt
	select @oldDimCnt as oldDimCnt
	select @ItemDim1TypeId as ItemDim1TypeId	
	select @ItemDim2TypeId as ItemDim2TypeId	
	select @ItemDim3TypeId as ItemDim3TypeId
	select @oldItemDim1TypeId as oldItemDim1TypeId	
	select @oldItemDim2TypeId as oldItemDim2TypeId	
	select @oldItemDim3TypeId as oldItemDim3TypeId
	CREATE TABLE #tmpMaterialDimItem (
		Rec_ID INT IDENTITY (1,1),	
		StyleBOMDimensionItemID NVARCHAR(50),	
		MaterialId NVARCHAR(50),
		Dim1ID NVARCHAR(50),
		Dim2ID NVARCHAR(50),
		Dim3ID NVARCHAR(50),
		Dim1Name NVARCHAR(50),
		Dim2Name NVARCHAR(50),
		Dim3Name NVARCHAR(50),			
		Qty nvarchar(20),
		ColorId nvarchar(50),
		SizeId nvarchar(50),
		Price nvarchar(20)				
		)	
		
	Declare @StyleMaterialId nvarchar(50)	
	Declare @StyleBOMDimensionItemID nvarchar(50)
	Declare @ItemDim1ID nvarchar(50)	
	Declare @ItemDim2ID nvarchar(50)
	Declare @ItemDim3ID nvarchar(50)	
	Declare @ItemDim1N nvarchar(50)
	Declare @ItemDim2N nvarchar(50)	
	Declare @ItemDim3N nvarchar(50)
	Declare @Matcnt int		
	Declare @Qty nvarchar(20)
	Declare @Dimension nvarchar(50)
	Declare @Price nvarchar(20)
	Declare @ColorId nvarchar(50)
	
	if @tmpCnt>0
		begin
			DECLARE cursor_1 CURSOR FOR
			SELECT distinct(StyleMaterialId) FROM pstylebom where styleBOMDimensionId=@StyleBOMDimensionId
			and StyleID=@StyleID and StyleSet=@Styleset and WorkflowID=@WorkflowID and
			WorkflowItemID=@WorkflowItemID			 		
			OPEN cursor_1		
			FETCH NEXT from cursor_1 INTO  @StyleMaterialId	
			WHILE @@FETCH_STATUS = 0 
				BEGIN
					DECLARE cursor_2 CURSOR FOR
					SELECT  StyleBOMDimensionItemID, ItemDim1ID, ItemDim2ID,  ItemDim3ID, ItemDim1Name, ItemDim2Name,  ItemDim3Name					
					FROM pStyleBOMDimensionItems where styleBOMDimensionId=@StyleBOMDimensionId
					and StyleID=@StyleID and StyleSet=@Styleset and WorkflowID=@WorkflowID and
					WorkflowItemID=@WorkflowItemID			 	
					ORDER BY ItemDim1Sort, ItemDim1Name,  ItemDim2Sort, ItemDim2Name, ItemDim3Sort,ItemDim3Name
					OPEN cursor_2
					FETCH NEXT from cursor_2 INTO  @StyleBOMDimensionItemID, @ItemDim1ID, @ItemDim2ID, @ItemDim3ID, 
					@ItemDim1N, @ItemDim2N, @ItemDim3N																									
					WHILE @@FETCH_STATUS = 0 
						BEGIN
						    if @blnDimAdd=1
								begin
									select @Matcnt=COUNT(StyleMaterialId) from pStyleBOMItem where 
									StyleMaterialId=@StyleMaterialId and ItemDim1Id=@ItemDim1ID
									if @Matcnt > 0
										begin
											SELECT top 1 @Qty=COALESCE(MaterialQuantity,'0'), @Dimension=COALESCE(MaterialDimension,'00000000-0000-0000-0000-000000000000'),   
											@Price=COALESCE(MaterialPrice,'0'), @ColorId=COALESCE(MaterialColorId,'00000000-0000-0000-0000-000000000000') from
											pStyleBOMItem where StyleMaterialId=@StyleMaterialId
											and ItemDim1Id=@ItemDim1ID
																				
											Insert into #tmpMaterialDimItem (StyleBOMDimensionItemID, MaterialId, 
											Dim1ID, Dim2ID, Dim3ID, Dim1Name, Dim2Name, Dim3Name, Qty, 
											ColorId, SizeId, Price)	values	
											(@StyleBOMDimensionItemID, @StyleMaterialId,
											@ItemDim1ID , @ItemDim2ID ,@ItemDim3ID, @ItemDim1N, @ItemDim2N, @ItemDim3N	,	
											@Qty, @ColorId, @Dimension, @Price)
																												
											
										end	
								end	
							if @blnDimAdd=2
								begin
									select @Matcnt=COUNT(StyleMaterialId) from pStyleBOMItem where 
									StyleMaterialId=@StyleMaterialId and ItemDim1Id=@ItemDim1ID
									and ItemDim2Id=@ItemDim2ID
									if @Matcnt > 0
										begin
											SELECT top 1 @Qty=COALESCE(MaterialQuantity,'0'), @Dimension=COALESCE(MaterialDimension,'00000000-0000-0000-0000-000000000000'),   
											@Price=COALESCE(MaterialPrice,'0'), @ColorId=COALESCE(MaterialColorId,'00000000-0000-0000-0000-000000000000') from
											pStyleBOMItem where StyleMaterialId=@StyleMaterialId
											and ItemDim1Id=@ItemDim1ID and ItemDim2Id=@ItemDim2ID
																				
											Insert into #tmpMaterialDimItem (StyleBOMDimensionItemID, MaterialId, 
											Dim1ID, Dim2ID, Dim3ID, Dim1Name, Dim2Name, Dim3Name, Qty, 
											ColorId, SizeId, Price)	values	
											(@StyleBOMDimensionItemID, @StyleMaterialId,
											@ItemDim1ID , @ItemDim2ID ,@ItemDim3ID, @ItemDim1N, @ItemDim2N, @ItemDim3N	,	
											@Qty, @ColorId, @Dimension, @Price)
																												
											
										end	
								end												   									
							FETCH NEXT from cursor_2 INTO   @StyleBOMDimensionItemID, @ItemDim1ID, @ItemDim2ID, @ItemDim3ID, 
							@ItemDim1N, @ItemDim2N, @ItemDim3N	
						END
						CLOSE cursor_2 
						DEALLOCATE cursor_2 	
					FETCH NEXT from cursor_1 INTO  @StyleMaterialId
				END						
				CLOSE cursor_1 
				DEALLOCATE cursor_1 
		end								
		
	delete from pStylebomitem where StyleBOMDimensionId=@StyleBOMDimensionId
	and StyleID=@StyleID and  StyleSet=@Styleset and WorkflowID=@WorkflowID and
	WorkflowItemID=@WorkflowItemID 
	
	select * from pStylebomitem
	
	Insert into pstylebomitem (StyleBOMDimensionId, StyleBOMDimensionItemID, StyleMaterialID, WorkflowID, WorkflowItemID, 
	StyleID, StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1ID,ItemDim2ID,
	ItemDim3ID, ItemDim1Name, ItemDim2Name, ItemDim3Name, MaterialQuantity, MaterialColorId, MaterialDimension, MaterialPrice)		
	select @StyleBOMDimensionId, StyleBOMDimensionItemID, MaterialID, @WorkflowID, @WorkflowItemID, @StyleID, @StyleSet,
	@ItemDim1TypeId, @ItemDim2TypeId, @ItemDim3TypeId, Dim1ID , Dim2ID , Dim3ID,
	Dim1Name, Dim2Name, Dim3Name, Qty, ColorId, SizeId, Price
	from #tmpMaterialDimItem	
	
	select * from #tmpMaterialDimItem
	
	drop table #tmpMaterialDimItem
	
	select * from pStylebomitem 
	
	If @DimCnt=1
		begin
			update pStyleBOM set Dim2TypeSel=0 ,  Dim3TypeSel=0 where StyleBOMDimensionId=@StyleBOMDimensionId
			and StyleID=@StyleID and  StyleSet=@Styleset and WorkflowID=@WorkflowID and
			WorkflowItemID=@WorkflowItemID 				
		end	
	else if @DimCnt=2
		begin
			update pStyleBOM set Dim3TypeSel=0 where StyleBOMDimensionId=@StyleBOMDimensionId
			and StyleID=@StyleID and  StyleSet=@Styleset and WorkflowID=@WorkflowID and
			WorkflowItemID=@WorkflowItemID 				
		end	
end
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01871'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01871', GetDate())
END

GO	