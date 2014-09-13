IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMShowHide_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleBOMShowHide_Update]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedure

CREATE PROCEDURE [dbo].[spx_StyleBOMShowHide_Update]
(
@StyleBOMDimensionId nvarchar(50),
@StyleID uniqueidentifier,
@Styleset int,
@WorkFlowID uniqueidentifier,
@WorkFlowItemID uniqueidentifier,
@ItemDim1 nvarchar(50),
@ItemDim1Ids nvarchar(4000),
@ItemDim2 uniqueidentifier,
@ItemDim2Ids nvarchar(4000),
@ItemDim3 uniqueidentifier,
@ItemDim3Ids nvarchar(4000),
@MUser nvarchar(200),
@MDate datetime
)
AS 

Declare @ItemDim1TypeId uniqueidentifier	
Declare @ItemDim2TypeId uniqueidentifier	
Declare @ItemDim3TypeId uniqueidentifier
Declare @DimCnt int
	
--select @ItemDim1Ids	 as dim1s
	
BEGIN

select @ItemDim1TypeId = COALESCE(ItemDim1TypeId,'00000000-0000-0000-0000-000000000000') , @ItemDim2TypeId = COALESCE(ItemDim2TypeId,'00000000-0000-0000-0000-000000000000'), 
@ItemDim3TypeId=COALESCE(ItemDim3TypeId,'00000000-0000-0000-0000-000000000000')
from pStyleBOMDimension where StyleBOMDimensionId = cast(@StyleBOMDimensionId as nvarchar(50))

Declare @strquery nvarchar(max)

if @ItemDim1TypeId<>'00000000-0000-0000-0000-000000000000' and @ItemDim1Ids <> ''
begin		
	exec('
      update
        pStyleBOMDimensionitem set ItemDim1Active=1
      WHERE        
        ItemDim1Id IN (' + @ItemDim1Ids + ') and
        StyleBOMDimensionId=''' + @StyleBOMDimensionId + ''' and
        ItemDim1TypeId=''' + @ItemDim1TypeId + '''')
                                                                     
     exec('
      update
        pStyleBOMDimensionitems set ItemDim1Active=1
      WHERE        
        ItemDim1Id IN (' + @ItemDim1Ids + ') and
        StyleBOMDimensionId=''' + @StyleBOMDimensionId + ''' and
        ItemDim1TypeId=''' + @ItemDim1TypeId + '''')

end

if @ItemDim2TypeId<>'00000000-0000-0000-0000-000000000000' and @ItemDim2Ids <> ''
begin
	exec('
      update
        pStyleBOMDimensionitem set ItemDim2Active=1
      WHERE        
        ItemDim2Id IN (' + @ItemDim2Ids + ') and
        StyleBOMDimensionId=''' + @StyleBOMDimensionId + ''' and
        ItemDim2TypeId=''' + @ItemDim2TypeId + '''')
                                                                     
     exec('
      update
        pStyleBOMDimensionitems set ItemDim2Active=1
      WHERE        
        ItemDim2Id IN (' + @ItemDim2Ids + ') and
        StyleBOMDimensionId=''' + @StyleBOMDimensionId + ''' and
        ItemDim2TypeId=''' + @ItemDim2TypeId + '''')
	        
	
end

if @ItemDim3TypeId<>'00000000-0000-0000-0000-000000000000' and @ItemDim3Ids <> ''
begin
	exec('
      update
        pStyleBOMDimensionitem set ItemDim3Active=1
      WHERE        
        ItemDim3Id IN (' + @ItemDim3Ids + ') and
        StyleBOMDimensionId=''' + @StyleBOMDimensionId + ''' and
        ItemDim3TypeId=''' + @ItemDim3TypeId + '''')
	          
     exec('
      update
        pStyleBOMDimensionitems set ItemDim3Active=1
      WHERE        
        ItemDim3Id IN (' + @ItemDim3Ids + ') and
        StyleBOMDimensionId=''' + @StyleBOMDimensionId + ''' and
        ItemDim3TypeId=''' + @ItemDim3TypeId + '''')
	
end
		
end

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03746', GetDate())
GO