/****** Object:  View [dbo].[vwx_SourcingCommitmentCostOptionDetailSummary]    Script Date: 01/30/2013 16:22:05 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SourcingCommitmentCostOptionDetailSummary]'))
DROP VIEW [dbo].[vwx_SourcingCommitmentCostOptionDetailSummary]
GO

/****** Object:  View [dbo].[vwx_SourcingCommitmentCostOptionDetailSummary]    Script Date: 01/30/2013 16:22:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_SourcingCommitmentCostOptionDetailSummary]
AS
SELECT     TOP (100) PERCENT dbo.pSourcingCommitmentCostOptionDetail.SourcingCommitmentCostOptionDetailID, 
                      dbo.pSourcingCommitmentCostOptionDetail.SourcingCommitmentCostOptionId, dbo.pSourcingCommitmentCostOptionDetail.SourcingQuotationBOMDetailsID, 
                      dbo.pSourcingCommitmentCostOptionDetail.MinQuantity, dbo.pSourcingCommitmentCostOptionDetail.MaxQuantity, 
                      dbo.pSourcingCommitmentCostOptionDetail.CostUnit, dbo.pSourcingCommitmentBOMDetails.StyleQuoteItemID, 
                      dbo.pSourcingCommitmentBOMDetails.ItemDim1TypeId, dbo.pSourcingCommitmentBOMDetails.ItemDim2TypeId, 
                      dbo.pSourcingCommitmentBOMDetails.ItemDim3TypeId, dbo.pSourcingCommitmentBOMDetails.ItemDim1Id, dbo.pSourcingCommitmentBOMDetails.ItemDim2Id, 
                      dbo.pSourcingCommitmentBOMDetails.ItemDim3Id, dbo.pSourcingCommitmentBOMDetails.ItemDim1Name, dbo.pSourcingCommitmentBOMDetails.ItemDim2Name, 
                      dbo.pSourcingCommitmentBOMDetails.ItemDim3Name, dbo.pSourcingCommitmentBOMDetails.ItemDim1Sort, dbo.pSourcingCommitmentBOMDetails.ItemDim2Sort, 
                      dbo.pSourcingCommitmentBOMDetails.ItemDim3Sort, dbo.pSourcingCommitmentBOMDetails.ItemDim1Active, dbo.pSourcingCommitmentBOMDetails.ItemDim2Active, 
                      dbo.pSourcingCommitmentBOMDetails.ItemDim3Active, dbo.pSourcingCommitmentCostOption.OptionName, '2' AS orderbysort, 
                      dbo.pSourcingCommitmentCostOption.OptionNo
FROM         dbo.pSourcingCommitmentCostOption INNER JOIN
                      dbo.pSourcingCommitmentCostOptionDetail ON 
                      dbo.pSourcingCommitmentCostOption.SourcingCommitmentCostOptionID = dbo.pSourcingCommitmentCostOptionDetail.SourcingCommitmentCostOptionId CROSS JOIN
                      dbo.pSourcingCommitmentBOMDetails
WHERE     (dbo.pSourcingCommitmentCostOptionDetail.Active = 1) AND ((ISNULL(CAST(dbo.pSourcingCommitmentBOMDetails.ItemDim1Id AS varchar(40)), '') 
                      + ISNULL(CAST(dbo.pSourcingCommitmentBOMDetails.ItemDim2Id AS varchar(40)), '') 
                      + ISNULL(CAST(dbo.pSourcingCommitmentBOMDetails.ItemDim3Id AS varchar(40)), '')) 
                      IN (ISNULL(CAST(dbo.pSourcingCommitmentCostOptionDetail.ItemDim1Id AS varchar(40)), '') 
                      + ISNULL(CAST(dbo.pSourcingCommitmentCostOptionDetail.ItemDim2Id AS varchar(40)), '') 
                      + ISNULL(CAST(dbo.pSourcingCommitmentCostOptionDetail.ItemDim3Id AS varchar(40)), '')))
ORDER BY dbo.pSourcingCommitmentCostOption.OptionNo DESC

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04925', GetDate())
GO