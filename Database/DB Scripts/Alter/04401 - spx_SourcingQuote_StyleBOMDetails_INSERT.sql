
/****** Object:  StoredProcedure [dbo].[spx_SourcingQuote_StyleBOMDetails_INSERT]    Script Date: 11/21/2012 10:59:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingQuote_StyleBOMDetails_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingQuote_StyleBOMDetails_INSERT]
GO


/****** Object:  StoredProcedure [dbo].[spx_SourcingQuote_StyleBOMDetails_INSERT]    Script Date: 11/21/2012 10:59:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Stored Procedure

CREATE PROCEDURE [dbo].[spx_SourcingQuote_StyleBOMDetails_INSERT]
(
@StyleQuoteItemID uniqueidentifier,
@StyleBOMDimensionId uniqueidentifier,
@SourcingHeaderID uniqueidentifier,
@SourcingStyleID uniqueidentifier,
@MUser nvarchar(200),
@MDate datetime
)
AS 


Declare @StyleId uniqueidentifier
Declare @StyleSet int
Declare @WorkFlowItemID uniqueidentifier
Declare @WorkFlowID uniqueidentifier

Declare @StyleBOMDimensionItemID uniqueidentifier


Declare @ItemDim1TypeId uniqueidentifier	
Declare @ItemDim2TypeId uniqueidentifier	
Declare @ItemDim3TypeId uniqueidentifier

BEGIN
-- get actual dim types
select top 1 @ItemDim1TypeId=COALESCE(ItemDim1TypeId,'00000000-0000-0000-0000-000000000000') 
, @ItemDim2TypeId=COALESCE(ItemDim2TypeId,'00000000-0000-0000-0000-000000000000') ,
@ItemDim3TypeId=COALESCE(ItemDim3TypeId,'00000000-0000-0000-0000-000000000000')
from pSourcingQuoteStyleBOM where 
StyleQuoteItemID=@StyleQuoteItemID and StyleBOMDimensionId=@StyleBOMDimensionId


-- get all need data
select distinct /*StyleID,StyleSet,WorkFlowItemID,WorkFlowID,StyleBOMDimensionID,StyleBOMDimensionItemID,*/ItemDim1TypeId,ItemDim1Id,ItemDim1Name,ItemDim1Sort,ItemDim1Active into #temptbl1 from pStyleBOMDimensionItems where StyleBOMDimensionID=@StyleBOMDimensionID
	
select distinct ItemDim2TypeId,ItemDim2Id,ItemDim2Name,ItemDim2Sort,ItemDim2Active into #temptbl2 from pStyleBOMDimensionItems where StyleBOMDimensionID=@StyleBOMDimensionID

select distinct ItemDim3TypeId,ItemDim3Id,ItemDim3Name,ItemDim3Sort,ItemDim3Active into #temptbl3 from pStyleBOMDimensionItems where StyleBOMDimensionID=@StyleBOMDimensionID
		
select top 1 @StyleId = StyleId, @StyleSet = StyleSet, @WorkFlowItemID= WorkFlowItemID, @WorkFlowID = WorkFlowID, @StyleBOMDimensionItemID = StyleBOMDimensionItemID from pStyleBOMDimensionItems where StyleBOMDimensionID=@StyleBOMDimensionID

-- insert null line
insert into #temptbl1(ItemDim1TypeId,ItemDim1Id,ItemDim1Name,ItemDim1Sort,ItemDim1Active)
 values('00000000-0000-0000-0000-000000000000','00000000-0000-0000-0000-000000000000','00000000-0000-0000-0000-000000000000',0,0)



if @ItemDim2TypeId<>'00000000-0000-0000-0000-000000000000'
begin

insert into #temptbl2(ItemDim2TypeId,ItemDim2Id,ItemDim2Name,ItemDim2Sort,ItemDim2Active)
 values('00000000-0000-0000-0000-000000000000','00000000-0000-0000-0000-000000000000','00000000-0000-0000-0000-000000000000',0,0)
 
end
else
begin
insert into #temptbl2(ItemDim2TypeId,ItemDim2Id,ItemDim2Name,ItemDim2Sort,ItemDim2Active)
 values('00000000-0000-0000-0000-000000000000','00000000-0000-0000-0000-000000000000','00000000-0000-0000-0000-000000000000',0,1)
end

if @ItemDim3TypeId<>'00000000-0000-0000-0000-000000000000'
begin
insert into #temptbl3(ItemDim3TypeId,ItemDim3Id,ItemDim3Name,ItemDim3Sort,ItemDim3Active)
 values('00000000-0000-0000-0000-000000000000','00000000-0000-0000-0000-000000000000','00000000-0000-0000-0000-000000000000',0,0)
end
else
begin
insert into #temptbl3(ItemDim3TypeId,ItemDim3Id,ItemDim3Name,ItemDim3Sort,ItemDim3Active)
 values('00000000-0000-0000-0000-000000000000','00000000-0000-0000-0000-000000000000','00000000-0000-0000-0000-000000000000',0,1)
end

 
   -- delete lines without any data      
delete from #temptbl1 where ItemDim1Id is null
delete from #temptbl2 where ItemDim2Id is null
delete from #temptbl3 where ItemDim3Id is null


	INSERT INTO [dbo].[pSourcingQuotationBOMDetails]
           ([SourcingQuotationBOMDetailsID]
           ,[StyleQuoteItemID]
           ,[SourcingHeaderId]
           ,[SourcingStyleID]
           ,[StyleID]
           ,[styleset]
           ,[WorkFlowID]
           ,[WorkFlowItemID]
           ,[StyleBOMDimensionId]
           ,[StyleBOMDimensionItemId]
           ,[ItemDim1TypeId]
           ,[ItemDim2TypeId]
           ,[ItemDim3TypeId]
           ,[ItemDim1Id]
           ,[ItemDim2Id]
           ,[ItemDim3Id]
           ,[ItemDim1Name]
           ,[ItemDim2Name]
           ,[ItemDim3Name]
           ,[ItemDim1Sort]
           ,[ItemDim2Sort]
           ,[ItemDim3Sort]
           ,[ItemDim1Active]
           ,[ItemDim2Active]
           ,[ItemDim3Active]
           ,[Quantity]
           ,[Cost]
           ,[TotalCost]
           ,[PartnerCost]
           ,[PartnerTotal]
           ,[CUser]
           ,[MUser]
           ,[CDate]
           ,[MDate])
     select
           NEWID()
           ,@StyleQuoteItemID
           ,@SourcingHeaderId
           ,@SourcingStyleID
           ,@StyleID
           ,@styleset
           ,@WorkFlowID
           ,@WorkFlowItemID
           ,@StyleBOMDimensionId
           ,@StyleBOMDimensionItemId
           ,a.ItemDim1TypeId
           ,b.ItemDim2TypeId
           ,c.ItemDim3TypeId
           ,a.ItemDim1Id
           ,b.ItemDim2Id
           ,c.ItemDim3Id
           ,a.ItemDim1Name
           ,b.ItemDim2Name
           ,c.ItemDim3Name
           ,a.ItemDim1Sort
           ,b.ItemDim2Sort
           ,c.ItemDim3Sort
           ,a.ItemDim1Active
           ,b.ItemDim2Active
           ,c.ItemDim3Active
           ,0
           ,0
           ,0
           ,0
           ,0
           ,@MUser
           ,@MUser
           ,@MDate
           ,@MDate from #temptbl1 a 
           cross join #temptbl2 b
            cross join #temptbl3 c
            
            
            
      


     -- set update dimId and dimName       
 update pSourcingQuotationBOMDetails set ItemDim1Id=NULL, ItemDim1Name=''  where ItemDim1Id='00000000-0000-0000-0000-000000000000'   
 update pSourcingQuotationBOMDetails set ItemDim2Id=NULL, ItemDim2Name='' where ItemDim2Id='00000000-0000-0000-0000-000000000000'  
 update pSourcingQuotationBOMDetails set ItemDim3Id=NULL, ItemDim3Name='' where ItemDim3Id='00000000-0000-0000-0000-000000000000'   
 
 --delete null line
   update pSourcingQuotationBOMDetails set  ItemDim1Active=0,  ItemDim2Active=0, ItemDim3Active=0 where StyleBOMDimensionId=@StyleBOMDimensionId and
        StyleQuoteItemId=@StyleQuoteItemId and
        ItemDim1TypeId= '00000000-0000-0000-0000-000000000000'	and ItemDim2TypeId= '00000000-0000-0000-0000-000000000000' and ItemDim3TypeId= '00000000-0000-0000-0000-000000000000'
        
            drop table #temptbl1
            drop table #temptbl2
            drop table #temptbl3
   
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04401', GetDate())
GO


