/****** Object:  View [dbo].[vwx_SourcingCostOptionDetailSummary]    Script Date: 01/25/2013 14:36:32 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SourcingCostOptionDetailSummary]'))
DROP VIEW [dbo].[vwx_SourcingCostOptionDetailSummary]
GO

/****** Object:  View [dbo].[vwx_SourcingCostOptionDetailSummary]    Script Date: 01/25/2013 14:36:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_SourcingCostOptionDetailSummary]
AS
SELECT     TOP (100) PERCENT dbo.pSourcingCostOptionDetail.SourcingCostOptionDetailID, dbo.pSourcingCostOptionDetail.SourcingCostOptionId, 
                      dbo.pSourcingCostOptionDetail.SourcingQuotationBOMDetailsID, dbo.pSourcingCostOptionDetail.MinQuantity, dbo.pSourcingCostOptionDetail.MaxQuantity, 
                      dbo.pSourcingCostOptionDetail.CostUnit, dbo.pSourcingQuotationBOMDetails.StyleQuoteItemID, dbo.pSourcingQuotationBOMDetails.ItemDim1TypeId, 
                      dbo.pSourcingQuotationBOMDetails.ItemDim2TypeId, dbo.pSourcingQuotationBOMDetails.ItemDim3TypeId, dbo.pSourcingQuotationBOMDetails.ItemDim1Id, 
                      dbo.pSourcingQuotationBOMDetails.ItemDim2Id, dbo.pSourcingQuotationBOMDetails.ItemDim3Id, dbo.pSourcingQuotationBOMDetails.ItemDim1Name, 
                      dbo.pSourcingQuotationBOMDetails.ItemDim2Name, dbo.pSourcingQuotationBOMDetails.ItemDim3Name, dbo.pSourcingQuotationBOMDetails.ItemDim1Sort, 
                      dbo.pSourcingQuotationBOMDetails.ItemDim2Sort, dbo.pSourcingQuotationBOMDetails.ItemDim3Sort, dbo.pSourcingQuotationBOMDetails.ItemDim1Active, 
                      dbo.pSourcingQuotationBOMDetails.ItemDim2Active, dbo.pSourcingQuotationBOMDetails.ItemDim3Active, dbo.pSourcingCostOption.OptionName, '2' AS orderbysort, 
                      dbo.pSourcingCostOption.OptionNo
FROM         dbo.pSourcingCostOption INNER JOIN
                      dbo.pSourcingCostOptionDetail ON dbo.pSourcingCostOption.SourcingCostOptionID = dbo.pSourcingCostOptionDetail.SourcingCostOptionId CROSS JOIN
                      dbo.pSourcingQuotationBOMDetails
WHERE     (dbo.pSourcingCostOptionDetail.Active = 1) AND ((ISNULL(CAST(dbo.pSourcingQuotationBOMDetails.ItemDim1Id AS varchar(40)), '') 
                      + ISNULL(CAST(dbo.pSourcingQuotationBOMDetails.ItemDim2Id AS varchar(40)), '') + ISNULL(CAST(dbo.pSourcingQuotationBOMDetails.ItemDim3Id AS varchar(40)), '')) 
                      IN (ISNULL(CAST(dbo.pSourcingCostOptionDetail.ItemDim1Id AS varchar(40)), '') + ISNULL(CAST(dbo.pSourcingCostOptionDetail.ItemDim2Id AS varchar(40)), '') 
                      + ISNULL(CAST(dbo.pSourcingCostOptionDetail.ItemDim3Id AS varchar(40)), '')))
ORDER BY dbo.pSourcingCostOption.OptionNo DESC

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04896', GetDate())
GO
