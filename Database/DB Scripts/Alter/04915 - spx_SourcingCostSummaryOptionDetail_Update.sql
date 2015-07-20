/****** Object:  StoredProcedure [dbo].[spx_SourcingCostSummaryOptionDetail_Update]    Script Date: 01/29/2013 18:26:13 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingCostSummaryOptionDetail_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingCostSummaryOptionDetail_Update]
GO

/****** Object:  StoredProcedure [dbo].[spx_SourcingCostSummaryOptionDetail_Update]    Script Date: 01/29/2013 18:26:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- Stored Procedure

CREATE PROCEDURE [dbo].[spx_SourcingCostSummaryOptionDetail_Update]
(@StyleQuoteItemId uniqueidentifier
)
AS 

	

	
BEGIN

UPDATE pSourcingCostOptionDetail SET Active=0 
FROM pSourcingCostOptionDetail scod 
INNER JOIN pSourcingCostOption sco ON sco.SourcingCostOptionID = scod.SourcingCostOptionId
WHERE sco.StyleQuoteItemID = @StyleQuoteItemID

--insert new dimension, that checked in edit
INSERT pSourcingCostOptionDetail(
	SourcingCostOptionDetailID,SourcingCostOptionId,SourcingQuotationBOMDetailsID,MinQuantity,
	MaxQuantity,CostUnit,Active,ItemDim1Id,ItemDim2Id,ItemDim3Id)
SELECT NEWID(), sco.SourcingCostOptionID,SourcingQuotationBOMDetailsID, 0, 
	0, 0.00, 0, ItemDim1Id,ItemDim2Id,ItemDim3Id 
FROM pSourcingQuotationBOMDetails bd 
INNER JOIN pSourcingCostOption sco ON sco.StyleQuoteItemID = bd.StyleQuoteItemID
WHERE bd.StyleQuoteItemID=@StyleQuoteItemId 
AND NOT 
(ISNULL(cast(ItemDim1Id as varchar(40)),'')+ISNULL(cast(ItemDim2Id as varchar(40)),'')+ISNULL(cast(ItemDim3Id as varchar(40)),'') in (
	Select ISNULL(cast(ItemDim1Id as varchar(40)),'')+ISNULL(cast(ItemDim2Id as varchar(40)),'')+ISNULL(cast(ItemDim3Id as varchar(40)),'') 
	from pSourcingCostOptionDetail where SourcingCostOptionId=sco.SourcingCostOptionID))

update pSourcingCostOptionDetail set Active=1 
FROM pSourcingCostOptionDetail scod 
INNER JOIN pSourcingCostOption sco ON sco.SourcingCostOptionID = scod.SourcingCostOptionId
where sco.StyleQuoteItemID=@StyleQuoteItemID and 
(ISNULL(cast(ItemDim1Id as varchar(40)),'')+ISNULL(cast(ItemDim2Id as varchar(40)),'')+ISNULL(cast(ItemDim3Id as varchar(40)),'') in (Select ISNULL(cast(ItemDim1Id as varchar(40)),'')+ISNULL(cast(ItemDim2Id as varchar(40)),'')+ISNULL(cast(ItemDim3Id as varchar(40)),'') from pSourcingQuotationBOMDetails where StyleQuoteItemID=@StyleQuoteItemId)
)


select * from vwx_SourcingCostOptionDetailSummary where SourcingCostOptionId in (select SourcingCostOptionID from pSourcingCostOption where StyleQuoteItemID=@StyleQuoteItemId)
union
select  NEWID(), SourcingCostOptionId, 
NEWID(), MinQuantity, MaxQuantity, 
                     CostUnit,StyleQuoteItemID,NEWID(), 
                     NEWID(),NEWID(),NEWID(), 
                     NEWID(),NEWID(),'Hight Level', 
                     '','',null, 
                     null,null,null, 
                     null,null, OptionName,'1' AS orderbysort,OptionNo

from pSourcingCostOption where StyleQuoteItemID=@StyleQuoteItemId 
                     order by 24,11,12,13,25
 

END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04915', GetDate())
GO