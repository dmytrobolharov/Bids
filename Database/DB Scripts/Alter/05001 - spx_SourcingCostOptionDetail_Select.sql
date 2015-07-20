
/****** Object:  StoredProcedure [dbo].[spx_SourcingCostOptionDetail_Select]    Script Date: 02/07/2013 21:00:43 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingCostOptionDetail_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingCostOptionDetail_Select]
GO



/****** Object:  StoredProcedure [dbo].[spx_SourcingCostOptionDetail_Select]    Script Date: 02/07/2013 21:00:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SourcingCostOptionDetail_Select]
(@StyleQuoteItemId uniqueidentifier,
@SourcingCostOptionID uniqueidentifier
)
AS 
	
BEGIN


SELECT   pSourcingCostOptionDetail.SourcingCostOptionDetailID, pSourcingCostOptionDetail.SourcingCostOptionId, 
pSourcingCostOptionDetail.SourcingQuotationBOMDetailsID, pSourcingCostOptionDetail.MinQuantity, pSourcingCostOptionDetail.MaxQuantity, 
pSourcingCostOptionDetail.CostUnit, pSourcingQuotationBOMDetails.StyleQuoteItemID, pSourcingQuotationBOMDetails.ItemDim1TypeId, 
pSourcingQuotationBOMDetails.ItemDim2TypeId, pSourcingQuotationBOMDetails.ItemDim3TypeId, pSourcingQuotationBOMDetails.ItemDim1Id, 
pSourcingQuotationBOMDetails.ItemDim2Id, pSourcingQuotationBOMDetails.ItemDim3Id, pSourcingQuotationBOMDetails.ItemDim1Name, 
pSourcingQuotationBOMDetails.ItemDim2Name, pSourcingQuotationBOMDetails.ItemDim3Name, pSourcingQuotationBOMDetails.ItemDim1Sort, 
pSourcingQuotationBOMDetails.ItemDim2Sort, pSourcingQuotationBOMDetails.ItemDim3Sort, pSourcingQuotationBOMDetails.ItemDim1Active, 
pSourcingQuotationBOMDetails.ItemDim2Active, pSourcingQuotationBOMDetails.ItemDim3Active, pSourcingCostOption.OptionName
FROM   pSourcingQuotationBOMDetails INNER JOIN
pSourcingCostOptionDetail ON 
pSourcingQuotationBOMDetails.SourcingQuotationBOMDetailsID = pSourcingCostOptionDetail.SourcingQuotationBOMDetailsID INNER JOIN
pSourcingCostOption ON pSourcingCostOptionDetail.SourcingCostOptionId = pSourcingCostOption.SourcingCostOptionID AND 
pSourcingQuotationBOMDetails.StyleQuoteItemID = pSourcingCostOption.StyleQuoteItemID
where pSourcingCostOption.StyleQuoteItemID=@StyleQuoteItemId and pSourcingCostOption.SourcingCostOptionID=@SourcingCostOptionID
ORDER BY Itemdim1sort, itemdim1name,Itemdim2sort, itemdim2name,
Itemdim3sort, itemdim3name


END




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '05001', GetDate())
GO