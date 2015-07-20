/****** Object:  View [dbo].[vwx_MaterialTradePartnerVendor_SELECT]    Script Date: 06/03/2013 11:18:45 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_MaterialTradePartnerVendor_SELECT]'))
DROP VIEW [dbo].[vwx_MaterialTradePartnerVendor_SELECT]
GO

CREATE VIEW [dbo].[vwx_MaterialTradePartnerVendor_SELECT]
AS
SELECT '00000000-0000-0000-0000-000000000000' AS TradePartnerVendorID, 'Factory Sourced' AS VendorName, NULL AS SeasonYearID, 
	NULL AS MaterialId, NULL AS StyleID, NULL AS StyleMaterialID, 1 AS Active
	
UNION

SELECT b.TradePartnerVendorID, b.VendorName, a.SeasonYearID, 
	a.MaterialId, c.StyleID, c.StyleMaterialID, b.Active
FROM dbo.pMaterialTradePartner a 
INNER JOIN dbo.pStyleMaterials c ON c.MaterialID = a.MaterialId 
INNER JOIN dbo.uTradePartnerVendor b ON a.TradepartnerVendorId = b.TradePartnerVendorID
WHERE (CAST(a.SeasonYearID AS NVARCHAR(50)) + CAST(c.StyleID AS NVARCHAR(50))) IN (
	SELECT CAST(SeasonYearID AS NVARCHAR(50)) + CAST(StyleID AS NVARCHAR(50)) AS Expr1 FROM dbo.pStyleSeasonYear)

UNION 

SELECT tp.TradePartnerID AS TradePartnerVendorID, tp.TradePartnerName AS VendorName, mtp.SeasonYearID, 
	sm.MaterialId, sm.StyleID, sm.StyleMaterialID, tp.Active
FROM pStyleMaterials sm
INNER JOIN pMaterialTradePartner mtp ON sm.MaterialID = mtp.MaterialId
INNER JOIN uTradePartner tp ON mtp.TradepartnerId = tp.TradePartnerID
WHERE EXISTS(SELECT * FROM pStyleSeasonYear ssy WHERE sm.StyleID = ssy.StyleID AND mtp.SeasonYearID = ssy.SeasonYearID) 
	AND mtp.TradepartnerVendorId IS NULL

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0.0000', '05789', GetDate())
GO
