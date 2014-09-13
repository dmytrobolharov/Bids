/****** Object:  View [dbo].[vwx_SourcingStyle_CommitmentItem_SELECT]    Script Date: 01/25/2013 15:57:52 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SourcingStyle_CommitmentItem_SELECT]'))
DROP VIEW [dbo].[vwx_SourcingStyle_CommitmentItem_SELECT]
GO


/****** Object:  View [dbo].[vwx_SourcingStyle_CommitmentItem_SELECT]    Script Date: 01/25/2013 15:57:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_SourcingStyle_CommitmentItem_SELECT]
AS
SELECT DISTINCT 
                      '<img src=''../System/Icons/' + dbo.pStyleQuoteItemStatus.CustomIcon + ''' />' AS ImagePath, dbo.pSourcingCommitmentItem.StyleQuoteItemID, 
                      dbo.pSourcingCommitmentItem.StyleID, dbo.pSourcingCommitmentItem.StyleQuoteItemNo, dbo.pSourcingCommitmentItem.StyleQuoteItemShare, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemStatusId, dbo.pSourcingCommitmentItem.StyleQuoteVariationId, dbo.pSourcingCommitmentItem.StyleQuoteID, 
                      dbo.pSourcingCommitmentItem.StyleQuotaDutyID, dbo.pSourcingCommitmentItem.StyleDevelopmentID, dbo.pSourcingCommitmentItem.StyleQuoteTradePartnerID, 
                      dbo.pSourcingCommitmentItem.StyleCostingID, dbo.pSourcingCommitmentItem.StyleCostingType, dbo.pSourcingCommitmentItem.StyleCostingFreightTypeID, 
                      dbo.pSourcingCommitmentItem.TradePartnerID, dbo.pSourcingCommitmentItem.TradePartnerVendorID, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField1, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField2, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField3, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField4, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField5, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField6, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField8, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField9, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField10, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField11, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField12, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField13, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField14, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField15, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField16, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField17, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField18, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField19, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField7, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField20, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField21, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField22, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField23, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField24, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField25, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField26, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField27, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField28, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField29, 
                      dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField30, dbo.pSourcingCommitmentItem.StyleCostingCustomField1, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField2, dbo.pSourcingCommitmentItem.StyleCostingCustomField3, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField4, dbo.pSourcingCommitmentItem.StyleCostingCustomField5, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField6, dbo.pSourcingCommitmentItem.StyleCostingCustomField7, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField8, dbo.pSourcingCommitmentItem.StyleCostingCustomField9, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField10, dbo.pSourcingCommitmentItem.StyleCostingCustomField11, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField12, dbo.pSourcingCommitmentItem.StyleCostingCustomField13, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField14, dbo.pSourcingCommitmentItem.StyleCostingCustomField15, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField16, dbo.pSourcingCommitmentItem.StyleCostingCustomField17, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField18, dbo.pSourcingCommitmentItem.StyleCostingCustomField19, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField20, dbo.pSourcingCommitmentItem.StyleCostingCustomField21, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField22, dbo.pSourcingCommitmentItem.StyleCostingCustomField23, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField24, dbo.pSourcingCommitmentItem.StyleCostingCustomField25, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField26, dbo.pSourcingCommitmentItem.StyleCostingCustomField27, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField28, dbo.pSourcingCommitmentItem.StyleCostingCustomField29, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField30, dbo.pSourcingCommitmentItem.StyleCostingCustomField31, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField32, dbo.pSourcingCommitmentItem.StyleCostingCustomField33, 
                      dbo.pSourcingCommitmentItem.StyleCostingCustomField34, dbo.pSourcingCommitmentItem.StyleCostingCustomField35, dbo.pStyleHeader.StyleNo, 
                      dbo.pStyleHeader.SizeClass, dbo.pStyleCategory.StyleCategory, dbo.pStyleHeader.MaterialNo, dbo.pSourcingCommitmentItem.SourcingCommitmentItemID, 
                      dbo.pSourcingCommitmentItem.StyleCommitmentNo, dbo.pStyleHeader.Description, dbo.pSourcingCommitmentItem.StyleQuoteItemDueDate, 
                      dbo.pSourcingCommitmentItem.MDate, dbo.pSourcingCommitmentItem.StyleColorID, dbo.pWorkFlowItem.WorkFlowItemName, 
                      dbo.pSourcingCommitmentItem.StyleSourcingID, dbo.pSourcingCommitmentItem.SourcingHeaderID, dbo.pSourcingCommitmentItem.StyleQuoteItemCustomField31, 
                      dbo.pSourcingCommitmentItem.StyleSeasonYearID, dbo.pStyleSeasonYear.SeasonYearID, 
                      dbo.pStyleSeasonYear.StyleSeason + ' ' + dbo.pStyleSeasonYear.StyleYear AS StyleSeasonYear, p.AgentID, p.AgentName, p.VendorID, p.VendorName, p.FactoryID, 
                      p.FactoryName, dbo.pSourcingHeader.SourcingName, dbo.pSourcingHeader.SourcingType
FROM         dbo.pSourcingCommitmentItem INNER JOIN
                      dbo.pSourcingHeader ON dbo.pSourcingHeader.SourcingHeaderID = dbo.pSourcingCommitmentItem.SourcingHeaderID INNER JOIN
                      dbo.pSourcingTradePartner AS stp ON stp.SourcingTradePartnerID = dbo.pSourcingCommitmentItem.StyleQuoteTradePartnerID LEFT OUTER JOIN
                      dbo.vwx_TradePartnerRelationshipLevels_SEL AS p ON p.TradePartnerRelationshipLevelID = stp.TradePartnerLevelID INNER JOIN
                      dbo.pSourcingStyle ON dbo.pSourcingCommitmentItem.StyleSourcingID = dbo.pSourcingStyle.SourcingStyleID INNER JOIN
                      dbo.pStyleHeader ON dbo.pSourcingCommitmentItem.StyleID = dbo.pStyleHeader.StyleID LEFT OUTER JOIN
                      dbo.pStyleBOMDimension ON dbo.pSourcingCommitmentItem.StyleColorID = dbo.pStyleBOMDimension.StyleBOMDimensionID LEFT OUTER JOIN
                      dbo.pWorkFlowItem ON dbo.pWorkFlowItem.WorkFlowItemID = dbo.pStyleBOMDimension.WorkFlowItemID LEFT OUTER JOIN
                      dbo.pStyleSeasonYear ON dbo.pStyleSeasonYear.StyleSeasonYearID = dbo.pSourcingCommitmentItem.StyleSeasonYearID LEFT OUTER JOIN
                      dbo.pStyleCategory ON dbo.pStyleHeader.StyleCategory = dbo.pStyleCategory.StyleCategoryId LEFT OUTER JOIN
                      dbo.pStyleQuoteItemStatus ON dbo.pSourcingCommitmentItem.StyleQuoteItemStatusId = dbo.pStyleQuoteItemStatus.CustomKey

GO


GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04898', GetDate())
GO
