IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BOMTempMaterialTradePartnerVendor_SELECT]'))
DROP VIEW [dbo].[vwx_BOMTempMaterialTradePartnerVendor_SELECT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[vwx_BOMTempMaterialTradePartnerVendor_SELECT]
AS
SELECT     '00000000-0000-0000-0000-000000000000' AS TradePartnerID, '00000000-0000-0000-0000-000000000000' AS TradePartnerVendorID, 'Factory Sourced' AS VendorName, NULL AS SeasonYearID, NULL 
                      AS MaterialId, NULL AS StyleID, NULL AS StyleMaterialID, 1 AS Active, NULL AS PartnerName
UNION
SELECT     a.TradepartnerId, b.TradePartnerVendorID, b.VendorName, a.SeasonYearID, a.MaterialId, c.StyleID, c.StyleMaterialID, b.Active, 
		(ISNULL(tpm.AgentName, '') + ISNULL('/' + tpm.VendorName,'') + ISNULL ('/' + tpm.FactoryName, '')) AS PartnerName
FROM         dbo.pMaterialTradePartner AS a INNER JOIN
                      dbo.pStyleBOMTemp AS c ON c.MaterialID = a.MaterialId LEFT JOIN
                      dbo.uTradePartnerVendor AS b ON a.TradepartnerVendorId = b.TradePartnerVendorID LEFT JOIN
                      dbo.vwx_TradePartnerMgmt_SEL AS tpm ON a.TradePartnerRelationshipLevelID = tpm.RelationshipLevelID
WHERE     ((CAST(a.SeasonYearID AS NVARCHAR(50)) + CAST(c.StyleID AS NVARCHAR(50))) IN
                          (SELECT     CAST(SeasonYearID AS NVARCHAR(50)) + CAST(StyleID AS NVARCHAR(50)) AS Expr1
                            FROM          dbo.pStyleSeasonYear))

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04856', GetDate())
GO
