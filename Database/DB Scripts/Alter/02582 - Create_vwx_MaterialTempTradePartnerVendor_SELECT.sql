
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_MaterialTempTradePartnerVendor_SELECT]'))
DROP VIEW [dbo].[vwx_MaterialTempTradePartnerVendor_SELECT]
GO

CREATE  VIEW [dbo].[vwx_MaterialTempTradePartnerVendor_SELECT]
AS
SELECT     '00000000-0000-0000-0000-000000000000' AS TradePartnerVendorID, 'Factory Sourced' AS VendorName, NULL AS SeasonYearID, NULL 
                      AS MaterialId, NULL AS StyleID, NULL AS StyleMaterialID, 1 AS Active
UNION
SELECT     b.TradePartnerVendorID, b.VendorName, a.SeasonYearID, a.MaterialId, c.StyleID, c.StyleMaterialID, b.Active
FROM         dbo.pMaterialTradePartner AS a INNER JOIN
                      dbo.pStyleMaterialTemp AS c ON c.MaterialID = a.MaterialId INNER JOIN
                      dbo.uTradePartnerVendor AS b ON a.TradepartnerVendorId = b.TradePartnerVendorID
WHERE     ((CAST(a.SeasonYearID AS NVARCHAR(50)) + CAST(c.StyleID AS NVARCHAR(50))) IN
                          (SELECT     CAST(SeasonYearID AS NVARCHAR(50)) + CAST(StyleID AS NVARCHAR(50)) AS Expr1
                            FROM          dbo.pStyleSeasonYear))

Go

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02582'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '02582', GetDate())
END
GO