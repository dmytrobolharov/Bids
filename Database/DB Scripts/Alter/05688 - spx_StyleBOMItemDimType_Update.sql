/****** Object:  StoredProcedure [dbo].[spx_StyleBOMItemDimType_Update]    Script Date: 05/17/2013 13:45:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMItemDimType_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMItemDimType_Update]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleBOMItemDimType_Update]    Script Date: 05/17/2013 13:45:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedure

CREATE PROCEDURE [dbo].[spx_StyleBOMItemDimType_Update]
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
Declare @Dim1Cnt int
Declare @Dim2Cnt int
Declare @Dim3Cnt int


	
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

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05688', GetDate())
GO
