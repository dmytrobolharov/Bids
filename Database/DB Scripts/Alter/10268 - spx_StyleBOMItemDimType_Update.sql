IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMItemDimType_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMItemDimType_Update]
GO


CREATE PROCEDURE [dbo].[spx_StyleBOMItemDimType_Update]
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
@MUser nvarchar(200),
@MDate datetime
)
AS 

Declare @ItemDim1TypeId uniqueidentifier	
Declare @ItemDim2TypeId uniqueidentifier	
Declare @ItemDim3TypeId uniqueidentifier
Declare @Dim1Cnt int
Declare @Dim2Cnt int
Declare @Dim3Cnt int

IF @WorkFlowItemID IS NULL OR @WorkFlowItemID = '00000000-0000-0000-0000-000000000000'
BEGIN
	SELECT @WorkFlowItemID = WorkFlowItemID FROM pStyleBOMDimension WHERE StyleBOMDimensionID = @StyleBOMDimensionId
END
DECLARE @StyleSeasonYearID uniqueidentifier
SELECT @StyleSeasonYearID = StyleSeasonYearID FROM pWorkFlowItem WHERE WorkFlowItemID = @WorkFlowItemID
	
BEGIN

select @ItemDim1TypeId = COALESCE(ItemDim1TypeId,'00000000-0000-0000-0000-000000000000') , @ItemDim2TypeId = COALESCE(ItemDim2TypeId,'00000000-0000-0000-0000-000000000000'), 
@ItemDim3TypeId=COALESCE(ItemDim3TypeId,'00000000-0000-0000-0000-000000000000')
from pStyleBOMDimension where StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50))

SELECT @ItemDim1Name = DimTypeName FROM pStyleBOMDimType WHERE DimTypeID = @ItemDim1
SELECT @ItemDim2Name = DimTypeName FROM pStyleBOMDimType WHERE DimTypeID = @ItemDim2
SELECT @ItemDim3Name = DimTypeName FROM pStyleBOMDimType WHERE DimTypeID = @ItemDim3

select @ItemDim1TypeId as dim1
select @ItemDim2TypeId as dim2
select @ItemDim3TypeId as dim3

if @ItemDim1='00000000-0000-0000-0000-000000000000'
	begin
		set @ItemDim2='00000000-0000-0000-0000-000000000000'
		set @ItemDim3='00000000-0000-0000-0000-000000000000'
	end
else
	if @ItemDim2='00000000-0000-0000-0000-000000000000'
		begin		
			set @ItemDim3='00000000-0000-0000-0000-000000000000'
		end	
	
If @ItemDim1TypeId<>@ItemDim1
begin				
	Update pStyleBOMDimension set ItemDim1TypeId=@ItemDim1, ItemDim1TypeName=@ItemDim1Name
	where StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50))
	if Len(@ItemDim1) > 0
	begin		
		select @Dim1Cnt= COUNT(StyleBOMDimensionId) from pStyleBOMDimensionitem where 
		StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim1TypeId=@ItemDim1TypeId and ItemDim1Id is not null
		select @Dim1Cnt as cnt
		if @Dim1Cnt>0
			begin
			
				/* delete colorways from Seasonal Colorway if we delete colors from DimBOM */
				DELETE FROM pStyleColorwaySeasonYear WHERE 
					StyleColorwayID IN (SELECT ItemDim1Id FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionID = @StyleBOMDimensionId AND ItemDim1Id IS NOT NULL)
					AND StyleColorwayID NOT IN (SELECT COALESCE(ItemDim1Id,ItemDim2Id,ItemDim3Id) FROM pStyleBOMDimensionItem 
						INNER JOIN pWorkFlowItem ON pStyleBOMDimensionItem.WorkFlowItemID = pWorkFlowItem.WorkFlowItemID
						WHERE StyleBOMDimensionID <> @StyleBOMDimensionId AND StyleSeasonYearID = @StyleSeasonYearID
					) AND StyleSeasonYearID = @StyleSeasonYearID
					

				delete from pStyleBOMDimensionitem where StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim1TypeId=@ItemDim1TypeId and ItemDim1Id is not null
				--delete from pStyleBOMDimensionitems where StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim1TypeId=@ItemDim1TypeId and ItemDim1Id is not null							
			end
		delete from pStyleBOMDimensionitems where StyleBOMDimensionId=@StyleBOMDimensionId	
		--delete from pStyleBOMitem where StyleBOMDimensionId=@StyleBOMDimensionId				
		Update pStyleBOMDimensionitem set ItemDim1TypeId=@ItemDim1
		where StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50)) and ItemDim1TypeId=@ItemDim1TypeId
	end
end

If @ItemDim2TypeId<>@ItemDim2
begin	
	Update pStyleBOMDimension set ItemDim2TypeId=@ItemDim2, ItemDim2TypeName=@ItemDim2Name
	where StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50))	
	if Len(@ItemDim2) > 0
		begin		
			select @Dim2Cnt= COUNT(StyleBOMDimensionId) from pStyleBOMDimensionitem where 
			StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim2TypeId=@ItemDim2TypeId and ItemDim2Id is not null
			
			if @Dim2Cnt>0
				begin
				
					/* delete colorways from Seasonal Colorway if we delete colors from DimBOM */
					DELETE FROM pStyleColorwaySeasonYear WHERE 
						StyleColorwayID IN (SELECT ItemDim2Id FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionID = @StyleBOMDimensionId AND ItemDim2Id IS NOT NULL)
						AND StyleColorwayID NOT IN (SELECT COALESCE(ItemDim1Id,ItemDim2Id,ItemDim3Id) FROM pStyleBOMDimensionItem 
							INNER JOIN pWorkFlowItem ON pStyleBOMDimensionItem.WorkFlowItemID = pWorkFlowItem.WorkFlowItemID
							WHERE StyleBOMDimensionID <> @StyleBOMDimensionId AND StyleSeasonYearID = @StyleSeasonYearID
						) AND StyleSeasonYearID = @StyleSeasonYearID
				
				
					delete from pStyleBOMDimensionitem where StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim2TypeId=@ItemDim2TypeId and ItemDim2Id is not null
					--delete from pStyleBOMDimensionitems where StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim2TypeId=@ItemDim2TypeId and ItemDim2Id is not null								
				end
			delete from pStyleBOMDimensionitems where StyleBOMDimensionId=@StyleBOMDimensionId	
			--delete from pStyleBOMitem where StyleBOMDimensionId=@StyleBOMDimensionId				
			Update pStyleBOMDimensionitem set ItemDim2TypeId=@ItemDim2
			where StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50)) and ItemDim2TypeId=@ItemDim2TypeId
		end
end

If @ItemDim3TypeId<>@ItemDim3
begin	
	Update pStyleBOMDimension set ItemDim3TypeId=@ItemDim3, ItemDim3TypeName=@ItemDim3Name
	where StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50))
	if Len(@ItemDim3) > 0
	begin		
		select @Dim3Cnt= COUNT(StyleBOMDimensionId) from pStyleBOMDimensionitem where 
		StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim3TypeId=@ItemDim3TypeId and ItemDim3Id is not null
		select @Dim3Cnt as cnt
		if @Dim3Cnt>0
			begin
			
				/* delete colorways from Seasonal Colorway if we delete colors from DimBOM */
				DELETE FROM pStyleColorwaySeasonYear WHERE 
					StyleColorwayID IN (SELECT ItemDim3Id FROM pStyleBOMDimensionItem WHERE StyleBOMDimensionID = @StyleBOMDimensionId AND ItemDim3Id IS NOT NULL)
					AND StyleColorwayID NOT IN (SELECT COALESCE(ItemDim1Id,ItemDim2Id,ItemDim3Id) FROM pStyleBOMDimensionItem 
						INNER JOIN pWorkFlowItem ON pStyleBOMDimensionItem.WorkFlowItemID = pWorkFlowItem.WorkFlowItemID
						WHERE StyleBOMDimensionID <> @StyleBOMDimensionId AND StyleSeasonYearID = @StyleSeasonYearID
					) AND StyleSeasonYearID = @StyleSeasonYearID
					
			
				delete from pStyleBOMDimensionitem where StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim3TypeId=@ItemDim3TypeId and ItemDim3Id is not null
				--delete from pStyleBOMDimensionitems where StyleBOMDimensionId=@StyleBOMDimensionId and ItemDim3TypeId=@ItemDim3TypeId and ItemDim3Id is not null							
			end
		delete from pStyleBOMDimensionitems where StyleBOMDimensionId=@StyleBOMDimensionId		
		--delete from pStyleBOMitem where StyleBOMDimensionId=@StyleBOMDimensionId		
		Update pStyleBOMDimensionitem set ItemDim3TypeId=@ItemDim3
		where StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50)) and ItemDim3TypeId=@ItemDim3TypeId
	end
end

end

UPDATE wfi SET wfi.WorkStatus = 6 
FROM pStyleSKUItem sku
INNER JOIN pWorkFlowItem wfi ON sku.WorkflowItemID = wfi.WorkFlowItemID
INNER JOIN pStyleBOMDimension sbd ON sku.StyleBOMDimensionID = sbd.StyleBOMDimensionID
WHERE sbd.StyleBOMDimensionID = @StyleBOMDimensionID
	AND (sku.ItemDim1TypeID <> '00000000-0000-0000-0000-000000000000' 
		AND sku.ItemDim1TypeID NOT IN (sbd.ItemDim1TypeId, sbd.ItemDim2TypeId, sbd.ItemDim3TypeId))
	OR (sku.ItemDim2TypeID <> '00000000-0000-0000-0000-000000000000' 
		AND sku.ItemDim2TypeID NOT IN (sbd.ItemDim1TypeId, sbd.ItemDim2TypeId, sbd.ItemDim3TypeId))
	OR (sku.ItemDim3TypeID <> '00000000-0000-0000-0000-000000000000' 
		AND sku.ItemDim3TypeID NOT IN (sbd.ItemDim1TypeId, sbd.ItemDim2TypeId, sbd.ItemDim3TypeId))
	AND wfi.WorkStatus IN (100, 102)




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10268', GetUTCDate())
GO
