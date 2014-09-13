IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BOMTempMaterialTradePartnerVendor_SELECT]'))
DROP VIEW [dbo].[vwx_BOMTempMaterialTradePartnerVendor_SELECT]
GO

CREATE VIEW [dbo].[vwx_BOMTempMaterialTradePartnerVendor_SELECT]
AS
SELECT     '00000000-0000-0000-0000-000000000000' AS TradePartnerRelationshipLevelID, '00000000-0000-0000-0000-000000000000' AS TradePartnerVendorID, 'Factory Sourced' AS VendorName, NULL AS SeasonYearID, NULL 
                      AS MaterialId, NULL AS StyleID, NULL AS StyleMaterialID, 1 AS Active, NULL AS PartnerName
UNION
SELECT     a.TradePartnerRelationshipLevelID, b.TradePartnerVendorID, b.VendorName, a.SeasonYearID, a.MaterialId, c.StyleID, c.StyleMaterialID, b.Active, 
		SUBSTRING(ISNULL('/' + tpm.AgentName, '') + ISNULL('/' + tpm.VendorName,'') + ISNULL ('/' + tpm.FactoryName, ''), 2,1000) AS PartnerName
FROM         dbo.pMaterialTradePartner AS a INNER JOIN
                      dbo.pStyleBOMTemp AS c ON c.MaterialID = a.MaterialId INNER JOIN
                      dbo.pWorkFlowItem AS wi ON c.WorkFlowItemID = wi.WorkFlowItemID LEFT JOIN
                      dbo.pStyleSeasonYear AS ssy ON wi.StyleSeasonYearID = ssy.StyleSeasonYearID LEFT JOIN
                      dbo.uTradePartnerVendor AS b ON a.TradepartnerVendorId = b.TradePartnerVendorID LEFT JOIN
                      dbo.vwx_TradePartnerRelationshipLevels_SEL AS tpm ON a.TradePartnerRelationshipLevelID = tpm.TradePartnerRelationshipLevelID
WHERE a.SeasonYearID = ssy.SeasonYearID

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06646', GetDate())
GO
