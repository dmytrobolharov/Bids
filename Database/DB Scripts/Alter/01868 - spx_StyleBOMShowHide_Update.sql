IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleBOMShowHide_Update]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleBOMShowHide_Update]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleBOMShowHide_Update]    Script Date: 09/06/2011 12:09:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Stored Procedure

Create PROCEDURE [dbo].[spx_StyleBOMShowHide_Update]
(
@StyleBOMDimensionId nvarchar(50),
@StyleID uniqueidentifier,
@Styleset int,
@WorkFlowID uniqueidentifier,
@WorkFlowItemID uniqueidentifier,
@ItemDim1 nvarchar(50),
@ItemDim1Ids nvarchar(2000),
@ItemDim2 uniqueidentifier,
@ItemDim2Ids nvarchar(2000),
@ItemDim3 uniqueidentifier,
@ItemDim3Ids nvarchar(2000),
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

if @ItemDim1TypeId<>'00000000-0000-0000-0000-000000000000'
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
        pStyleBOMDimensionitem set ItemDim1Active=0
      WHERE        
        ItemDim1Id NOT IN (' + @ItemDim1Ids + ') and
        StyleBOMDimensionId=''' + @StyleBOMDimensionId + ''' and
        ItemDim1TypeId=''' + @ItemDim1TypeId + '''')   
                                                                     
     exec('
      update
        pStyleBOMDimensionitems set ItemDim1Active=1
      WHERE        
        ItemDim1Id IN (' + @ItemDim1Ids + ') and
        StyleBOMDimensionId=''' + @StyleBOMDimensionId + ''' and
        ItemDim1TypeId=''' + @ItemDim1TypeId + '''')
           
     exec('
      update
        pStyleBOMDimensionitems set ItemDim1Active=0
      WHERE        
        ItemDim1Id NOT IN (' + @ItemDim1Ids + ') and
        StyleBOMDimensionId=''' + @StyleBOMDimensionId + ''' and
        ItemDim1TypeId=''' + @ItemDim1TypeId + '''')                   		
end


if @ItemDim2TypeId<>'00000000-0000-0000-0000-000000000000'
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
        pStyleBOMDimensionitem set ItemDim2Active=0
      WHERE        
        ItemDim2Id NOT IN (' + @ItemDim2Ids + ') and
        StyleBOMDimensionId=''' + @StyleBOMDimensionId + ''' and
        ItemDim2TypeId=''' + @ItemDim2TypeId + '''') 
                                                                     
     exec('
      update
        pStyleBOMDimensionitems set ItemDim2Active=1
      WHERE        
        ItemDim2Id IN (' + @ItemDim2Ids + ') and
        StyleBOMDimensionId=''' + @StyleBOMDimensionId + ''' and
        ItemDim2TypeId=''' + @ItemDim2TypeId + '''')
	
	exec('
      update
        pStyleBOMDimensionitems set ItemDim2Active=0
      WHERE        
        ItemDim2Id NOT IN (' + @ItemDim2Ids + ') and
        StyleBOMDimensionId=''' + @StyleBOMDimensionId + ''' and
        ItemDim2TypeId=''' + @ItemDim2TypeId + '''')             
	
end

if @ItemDim3TypeId<>'00000000-0000-0000-0000-000000000000'
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
        pStyleBOMDimensionitem set ItemDim3Active=0
      WHERE        
        ItemDim3Id NOT IN (' + @ItemDim3Ids + ') and
        StyleBOMDimensionId=''' + @StyleBOMDimensionId + ''' and
        ItemDim3TypeId=''' + @ItemDim3TypeId + '''')
	          
     exec('
      update
        pStyleBOMDimensionitems set ItemDim3Active=1
      WHERE        
        ItemDim3Id IN (' + @ItemDim3Ids + ') and
        StyleBOMDimensionId=''' + @StyleBOMDimensionId + ''' and
        ItemDim3TypeId=''' + @ItemDim3TypeId + '''')
	
	exec('
      update
        pStyleBOMDimensionitems set ItemDim3Active=0
      WHERE        
        ItemDim3Id NOT IN (' + @ItemDim3Ids + ') and
        StyleBOMDimensionId=''' + @StyleBOMDimensionId + ''' and
        ItemDim3TypeId=''' + @ItemDim3TypeId + '''')
end

end
		
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01868'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01868', GetDate())
END

GO			
