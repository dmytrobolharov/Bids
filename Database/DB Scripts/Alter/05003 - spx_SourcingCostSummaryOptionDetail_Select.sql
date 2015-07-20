
/****** Object:  StoredProcedure [dbo].[spx_SourcingCostSummaryOptionDetail_Select]    Script Date: 02/07/2013 21:06:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingCostSummaryOptionDetail_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingCostSummaryOptionDetail_Select]
GO


/****** Object:  StoredProcedure [dbo].[spx_SourcingCostSummaryOptionDetail_Select]    Script Date: 02/07/2013 21:06:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- Stored Procedure

CREATE PROCEDURE [dbo].[spx_SourcingCostSummaryOptionDetail_Select]
(@StyleQuoteItemId uniqueidentifier
)
AS 
	
BEGIN
SELECT    dbo.pSourcingCostOptionDetail.SourcingCostOptionDetailID, dbo.pSourcingCostOptionDetail.SourcingCostOptionId, 
                      dbo.pSourcingCostOptionDetail.SourcingQuotationBOMDetailsID, dbo.pSourcingCostOptionDetail.MinQuantity, dbo.pSourcingCostOptionDetail.MaxQuantity, 
                      dbo.pSourcingCostOptionDetail.CostUnit, dbo.pSourcingQuotationBOMDetails.StyleQuoteItemID, dbo.pSourcingQuotationBOMDetails.ItemDim1TypeId, 
                      dbo.pSourcingQuotationBOMDetails.ItemDim2TypeId, dbo.pSourcingQuotationBOMDetails.ItemDim3TypeId, dbo.pSourcingQuotationBOMDetails.ItemDim1Id, 
                      dbo.pSourcingQuotationBOMDetails.ItemDim2Id, dbo.pSourcingQuotationBOMDetails.ItemDim3Id, dbo.pSourcingQuotationBOMDetails.ItemDim1Name, 
                      dbo.pSourcingQuotationBOMDetails.ItemDim2Name, dbo.pSourcingQuotationBOMDetails.ItemDim3Name, dbo.pSourcingQuotationBOMDetails.ItemDim1Sort, 
                      dbo.pSourcingQuotationBOMDetails.ItemDim2Sort, dbo.pSourcingQuotationBOMDetails.ItemDim3Sort, dbo.pSourcingQuotationBOMDetails.ItemDim1Active, 
                      dbo.pSourcingQuotationBOMDetails.ItemDim2Active, dbo.pSourcingQuotationBOMDetails.ItemDim3Active, dbo.pSourcingCostOption.OptionName, '2' AS orderbysort, 
                      dbo.pSourcingCostOption.OptionNo
FROM   pSourcingQuotationBOMDetails INNER JOIN
pSourcingCostOptionDetail ON 
pSourcingQuotationBOMDetails.SourcingQuotationBOMDetailsID = pSourcingCostOptionDetail.SourcingQuotationBOMDetailsID INNER JOIN
pSourcingCostOption ON pSourcingCostOptionDetail.SourcingCostOptionId = pSourcingCostOption.SourcingCostOptionID AND 
pSourcingQuotationBOMDetails.StyleQuoteItemID = pSourcingCostOption.StyleQuoteItemID
where pSourcingCostOption.StyleQuoteItemID=@StyleQuoteItemId 
union
select  NEWID(), SourcingCostOptionId, 
NEWID(), MinQuantity, MaxQuantity, 
                     CostUnit,StyleQuoteItemID,NEWID(), 
                     NEWID(),NEWID(),NEWID(), 
                     NEWID(),NEWID(),'High Level', 
                     '','',null, 
                     null,null,null, 
                     null,null, OptionName,'1' AS orderbysort,OptionNo
from pSourcingCostOption where StyleQuoteItemID=@StyleQuoteItemId 
 ORDER BY Itemdim1sort, itemdim1name,Itemdim2sort, itemdim2name,
	Itemdim3sort, itemdim3name, OptionNo desc

 

END



GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '05003', GetDate())
GO