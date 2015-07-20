

/****** Object:  StoredProcedure [dbo].[spx_Sourcing_StyleBOMShowHide_Clean]    Script Date: 11/19/2012 16:11:59 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sourcing_StyleBOMShowHide_Clean]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sourcing_StyleBOMShowHide_Clean]
GO


/****** Object:  StoredProcedure [dbo].[spx_Sourcing_StyleBOMShowHide_Clean]    Script Date: 11/19/2012 16:11:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- Stored Procedure

CREATE PROCEDURE [dbo].[spx_Sourcing_StyleBOMShowHide_Clean]
(@StyleQuoteItemId uniqueidentifier,
@StyleBOMDimensionId nvarchar(50),
@ItemDim1Ids nvarchar(max),
@ItemDim2Ids nvarchar(max),
@ItemDim3Ids nvarchar(max),
@MUser nvarchar(200),
@MDate datetime
)
AS 

Declare @ItemDim1TypeId uniqueidentifier	
Declare @ItemDim2TypeId uniqueidentifier	
Declare @ItemDim3TypeId uniqueidentifier
Declare @DimCnt int
	

	
BEGIN

select top 1 @ItemDim1TypeId=COALESCE(ItemDim1TypeId,'00000000-0000-0000-0000-000000000000') 
,@ItemDim2TypeId=COALESCE(ItemDim2TypeId,'00000000-0000-0000-0000-000000000000') ,
@ItemDim3TypeId=COALESCE(ItemDim3TypeId,'00000000-0000-0000-0000-000000000000')
from pSourcingQuoteStyleBOM where 
StyleQuoteItemID=@StyleQuoteItemID and StyleBOMDimensionId=@StyleBOMDimensionId

--select @ItemDim1TypeId = COALESCE(ItemDim1TypeId,'00000000-0000-0000-0000-000000000000') , @ItemDim2TypeId = COALESCE(ItemDim2TypeId,'00000000-0000-0000-0000-000000000000'), 
--@ItemDim3TypeId=COALESCE(ItemDim3TypeId,'00000000-0000-0000-0000-000000000000')
--from pStyleBOMDimension where StyleBOMDimensionId = @StyleBOMDimensionId
	
Declare @strquery nvarchar(max)

if @ItemDim1TypeId<>'00000000-0000-0000-0000-000000000000' and @ItemDim1Ids is not NULL
begin		
	exec('
      update
        pSourcingQuoteStyleBOM set ItemDim1Active=0
      WHERE        
        StyleBOMDimensionId=''' + @StyleBOMDimensionId + ''' and
        StyleQuoteItemId=''' + @StyleQuoteItemId + ''' and
        ItemDim1TypeId=''' + @ItemDim1TypeId + '''')
	
                                                                     
     exec('
      update
        pSourcingQuotationBOMDetails set ItemDim1Active=0
      WHERE        
        StyleBOMDimensionId=''' + @StyleBOMDimensionId + ''' and
        StyleQuoteItemId=''' + @StyleQuoteItemId + ''' and
        ItemDim1TypeId=''' + @ItemDim1TypeId + '''')
                		
end


if @ItemDim2TypeId<>'00000000-0000-0000-0000-000000000000' and @ItemDim2Ids is not NULL
begin
	exec('
      update
        pSourcingQuoteStyleBOM set ItemDim2Active=0
      WHERE        
        StyleBOMDimensionId=''' + @StyleBOMDimensionId + ''' and
        StyleQuoteItemId=''' + @StyleQuoteItemId + ''' and
        ItemDim2TypeId=''' + @ItemDim2TypeId + '''')
	
                                                                     
     exec('
      update
        pSourcingQuotationBOMDetails set ItemDim2Active=0
      WHERE        
        StyleBOMDimensionId=''' + @StyleBOMDimensionId + ''' and
        StyleQuoteItemId=''' + @StyleQuoteItemId + ''' and
        ItemDim2TypeId=''' + @ItemDim2TypeId + '''')            
	
end

if @ItemDim3TypeId<>'00000000-0000-0000-0000-000000000000' and @ItemDim3Ids is not NULL
begin
	exec('
      update
        pSourcingQuoteStyleBOM set ItemDim3Active=0
      WHERE        
        StyleBOMDimensionId=''' + @StyleBOMDimensionId + ''' and
        StyleQuoteItemId=''' + @StyleQuoteItemId + ''' and
        ItemDim3TypeId=''' + @ItemDim3TypeId + '''')
	
	          
     exec('
      update
        pSourcingQuotationBOMDetails set ItemDim3Active=0
      WHERE        
        StyleBOMDimensionId=''' + @StyleBOMDimensionId + ''' and
        StyleQuoteItemId=''' + @StyleQuoteItemId + ''' and
        ItemDim3TypeId=''' + @ItemDim3TypeId + '''')

end

end
		




GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04378', GetDate())
GO
