IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMMaterialItems_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMMaterialItems_Select]
GO


Create PROCEDURE [dbo].[spx_StyleBOMMaterialItems_Select]
(
@StyleBOMDimensionId nvarchar(50),
@StyleID uniqueidentifier,
@Styleset int,
@WorkFlowID uniqueidentifier,
@WorkFlowItemID uniqueidentifier
)

AS 
Declare @ItemDim1TypeId uniqueidentifier	
Declare @ItemDim2TypeId uniqueidentifier	
Declare @ItemDim3TypeId uniqueidentifier
Declare @DimCnt int
Declare @tmpMatItemCnt int

set @DimCnt=0
set @tmpMatItemCnt=0

select @ItemDim1TypeId = COALESCE(ItemDim1TypeId,'00000000-0000-0000-0000-000000000000') , @ItemDim2TypeId = COALESCE(ItemDim2TypeId,'00000000-0000-0000-0000-000000000000'), 
@ItemDim3TypeId=COALESCE(ItemDim3TypeId,'00000000-0000-0000-0000-000000000000')
from pStyleBOMDimension where StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50))

select @tmpMatItemCnt = COUNT(StyleBOMDimensionId) from  pStyleBOM where StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50))

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
		
	
	/*
	select @blnDimAdd as blnDimAdd
	select @blnChange as blnChange1
	select @DimCnt as DimCnt
	select @oldDimCnt as oldDimCnt
	select @ItemDim1TypeId as ItemDim1TypeId	
	select @ItemDim2TypeId as ItemDim2TypeId	
	select @ItemDim3TypeId as ItemDim3TypeId
	select @oldItemDim1TypeId as oldItemDim1TypeId	
	select @oldItemDim2TypeId as oldItemDim2TypeId	
	select @oldItemDim3TypeId as oldItemDim3TypeId		
	*/
		
CREATE TABLE #tmpMaterialDimItem (
	Rec_ID INT IDENTITY (1,1),	
	StyleBOMItemID NVARCHAR(50),
	StyleBOMDimensionItemID NVARCHAR(50),	
	StyleMaterialId NVARCHAR(50),
	ItemDim1Id NVARCHAR(50),
	ItemDim2Id NVARCHAR(50),
	ItemDim3Id NVARCHAR(50),
	ItemDim1Name NVARCHAR(200),
	ItemDim2Name NVARCHAR(200),
	ItemDim3Name NVARCHAR(200),			
	MaterialQuantity nvarchar(20),
	MaterialColorId nvarchar(50),
	MaterialDimension nvarchar(50),
	MaterialPrice nvarchar(20),
	MaterialNo nvarchar(50), 
	MaterialName nvarchar(200), 
	UOM nvarchar(50), 
	MainMaterial int, 
	MaterialType int, 
	ComponentOrder nvarchar(5),	
	Dim1TypeSel int, 
	Dim2TypeSel int, 
	Dim3TypeSel int,
	Materialsort nvarchar(5)	
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
	Declare @StyleMaterialBOMQty nvarchar(20) 
	Declare @StyleMaterialBOMSizeID nvarchar(50) 
	Declare @StyleMaterialBOMColorId nvarchar(50)
	Declare @StyleMaterialBOMPrice nvarchar(20)
	Declare @MaterialNo nvarchar(50)
	Declare @MaterialName nvarchar(200)
	Declare @UOM nvarchar(50)
	Declare @MainMaterial nvarchar(50)
	Declare @MaterialType int
	Declare @ComponentOrder nvarchar(5)
	Declare @Dim1TypeSel int
	Declare @Dim2TypeSel int
	Declare @Dim3TypeSel int
	Declare @MaterialColorID nvarchar(50)
	Declare @MaterialSizeID nvarchar(50)
	Declare @MaterialQty nvarchar(20)
	Declare @Materialsort nvarchar(5)		
	Declare @MaterialPrice nvarchar(20)
	
	if @tmpMatItemCnt>0	
		begin
			DECLARE cursor_1 CURSOR FOR
			SELECT StyleMaterialId, MaterialNo, MaterialName, UOM, MainMaterial, MaterialType, MaterialSort, ComponentOrder=pComponentType.ComponentOrder,
			Dim1TypeSel, Dim2TypeSel, Dim3TypeSel, MaterialColorID = COALESCE(MaterialColorID,'00000000-0000-0000-0000-000000000000') ,  
			MaterialSizeID = COALESCE(MaterialSizeID,'00000000-0000-0000-0000-000000000000'), MaterialQty = COALESCE(Qty,'0'), MaterialPrice							           
			FROM pstylebom INNER JOIN pComponentType ON pStyleBOM.MaterialType = pComponentType.ComponentTypeID
			where styleBOMDimensionId=@StyleBOMDimensionId and StyleID=@StyleID and StyleSet=@Styleset and WorkflowID=@WorkflowID and
			WorkflowItemID=@WorkflowItemID	ORDER BY MainMaterial DESC, pComponentType.ComponentOrder, 
			MaterialSort, MaterialNo, MaterialName	
				
			OPEN cursor_1	
				
			FETCH NEXT from cursor_1 INTO  @StyleMaterialId, @MaterialNo, @MaterialName, @UOM, @MainMaterial, @MaterialType, @MaterialSort, 
			@ComponentOrder, @Dim1TypeSel, @Dim2TypeSel, @Dim3TypeSel, @MaterialColorID, @MaterialSizeID, @MaterialQty, @MaterialPrice
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
							select @Matcnt=COUNT(StyleMaterialId) from pStyleBOMItem where StyleMaterialId=@StyleMaterialId and StyleBOMDimensionItemID=@StyleBOMDimensionItemID							
							if @Matcnt > 0
								begin
									SELECT top 1 @Qty=COALESCE(MaterialQuantity,'0'), @Dimension=COALESCE(MaterialDimension,'00000000-0000-0000-0000-000000000000'),   
									@Price=COALESCE(MaterialPrice,'0'), @ColorId=COALESCE(MaterialColorId,'00000000-0000-0000-0000-000000000000') from
									pStyleBOMItem where StyleMaterialId=@StyleMaterialId and StyleBOMDimensionItemID=@StyleBOMDimensionItemID																			
									Insert into #tmpMaterialDimItem (StyleBOMDimensionItemID, StyleMaterialId, 
									ItemDim1Id, ItemDim2Id, ItemDim3Id, ItemDim1Name, ItemDim2Name, ItemDim3Name, MaterialQuantity, 
									MaterialColorId, MaterialDimension, MaterialPrice,	MaterialNo, MaterialName, UOM, MainMaterial, MaterialType, ComponentOrder,	
									Dim1TypeSel, Dim2TypeSel,Dim3TypeSel,Materialsort)	values	
									(@StyleBOMDimensionItemID, @StyleMaterialId,@ItemDim1ID , @ItemDim2ID ,@ItemDim3ID, @ItemDim1N, @ItemDim2N, @ItemDim3N,										
									@Qty, @ColorId, @Dimension, @Price, @MaterialNo, @MaterialName, @UOM, @MainMaterial, @MaterialType, @ComponentOrder,	
									@Dim1TypeSel, @Dim2TypeSel, @Dim3TypeSel, @Materialsort)												
								end	
							else
								begin
									Insert into #tmpMaterialDimItem (StyleBOMDimensionItemID, StyleMaterialId, 
									ItemDim1Id, ItemDim2Id, ItemDim3Id, ItemDim1Name, ItemDim2Name, ItemDim3Name, MaterialQuantity, 
									MaterialColorId, MaterialDimension, MaterialPrice, MaterialNo, MaterialName, UOM, MainMaterial, MaterialType, ComponentOrder,	
									Dim1TypeSel, Dim2TypeSel,Dim3TypeSel,Materialsort)	values	
									(@StyleBOMDimensionItemID, @StyleMaterialId,
									@ItemDim1ID , @ItemDim2ID ,@ItemDim3ID, @ItemDim1N, @ItemDim2N, @ItemDim3N,	
									@MaterialQty, @MaterialColorId, @MaterialSizeID, @MaterialPrice, @MaterialNo, @MaterialName, @UOM, @MainMaterial, @MaterialType, @ComponentOrder,	
									@Dim1TypeSel, @Dim2TypeSel, @Dim3TypeSel, @Materialsort)		
								end																			   									
						FETCH NEXT from cursor_2 INTO   @StyleBOMDimensionItemID, @ItemDim1ID, @ItemDim2ID, @ItemDim3ID, 
						@ItemDim1N, @ItemDim2N, @ItemDim3N	
					END
					CLOSE cursor_2 
					DEALLOCATE cursor_2 	
				FETCH NEXT from cursor_1 INTO  @StyleMaterialId, @MaterialNo, @MaterialName, @UOM, @MainMaterial, @MaterialType, @MaterialSort, 
			@ComponentOrder, @Dim1TypeSel, @Dim2TypeSel, @Dim3TypeSel, @MaterialColorID, @MaterialSizeID, @MaterialQty, @MaterialPrice 
			END						
			CLOSE cursor_1 
			DEALLOCATE cursor_1 
	end										
	
	--select * from pStylebomitem	

	Insert into pstylebomitem (StyleBOMDimensionId, StyleBOMDimensionItemID, StyleMaterialID, WorkflowID, WorkflowItemID, 
	StyleID, StyleSet, ItemDim1TypeId, ItemDim2TypeId, ItemDim3TypeId, ItemDim1ID,ItemDim2ID,
	ItemDim3ID, ItemDim1Name, ItemDim2Name, ItemDim3Name, MaterialQuantity, MaterialColorId, MaterialDimension, MaterialPrice)		
	select @StyleBOMDimensionId, StyleBOMDimensionItemID, StyleMaterialId, @WorkflowID, @WorkflowItemID, @StyleID, @StyleSet,
	@ItemDim1TypeId, @ItemDim2TypeId, @ItemDim3TypeId, ItemDim1Id , ItemDim2Id , ItemDim3Id,
	ItemDim1Name, ItemDim2Name, ItemDim3Name, MaterialQuantity, MaterialColorId, MaterialDimension, MaterialPrice
	from #tmpMaterialDimItem where StyleBOMDimensionItemID not in (select StyleBOMDimensionItemID from 
	pstylebomitem where StyleBOMDimensionID=@StyleBOMDimensionID)
	
	update pstylebomitem set MaterialQuantity=t.MaterialQuantity, MaterialColorId=t.MaterialColorId, 
	MaterialDimension=t.MaterialDimension, MaterialPrice=t.MaterialPrice from pstylebomitem b
	inner join #tmpMaterialDimItem t  on b.StyleBOMDimensionItemId=t.StyleBOMDimensionItemID and b.StyleMaterialID=t.StyleMaterialId
	where b.StyleBOMDimensionID=@StyleBOMDimensionId				  
	
	--select * from #tmpMaterialDimItem	
	
	update #tmpMaterialDimItem set StyleBOMItemID=b.StyleBOMItemID from #tmpMaterialDimItem t
	inner join pstylebomitem b  on b.StyleBOMDimensionItemId=t.StyleBOMDimensionItemID and b.StyleMaterialID=t.StyleMaterialId
	where b.StyleBOMDimensionID=@StyleBOMDimensionId
	
	select * from #tmpMaterialDimItem ORDER BY MainMaterial DESC, ComponentOrder, MaterialSort, MaterialNo, MaterialName	
	
	select COUNT(*) as cnt from #tmpMaterialDimItem where StyleBOMItemID not in (select StyleBOMItemID from 
	pstylebomitem where StyleBOMDimensionID=@StyleBOMDimensionID)
	
			
	drop table #tmpMaterialDimItem		
	
				



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10272', GetUTCDate())
GO
