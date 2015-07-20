/****** Object:  View [dbo].[vwx_BOMMaterialTradePartnerVendor_SELECT]    Script Date: 12/03/2012 16:22:47 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_BOMMaterialTradePartnerVendor_SELECT]'))
DROP VIEW [dbo].[vwx_BOMMaterialTradePartnerVendor_SELECT]
GO


/****** Object:  View [dbo].[vwx_BOMMaterialTradePartnerVendor_SELECT]    Script Date: 12/03/2012 16:22:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create VIEW [dbo].[vwx_BOMMaterialTradePartnerVendor_SELECT]
AS
SELECT     '00000000-0000-0000-0000-000000000000' AS TradePartnerVendorID, 'Factory Sourced' AS VendorName, NULL AS SeasonYearID, NULL 
                      AS MaterialId, NULL AS StyleID, NULL AS StyleMaterialID, 1 AS Active
UNION
SELECT     b.TradePartnerVendorID, b.VendorName, a.SeasonYearID, a.MaterialId, c.StyleID, c.StyleMaterialID, b.Active
FROM         dbo.pMaterialTradePartner AS a INNER JOIN
                      dbo.pStyleBOM AS c ON c.MaterialID = a.MaterialId INNER JOIN
                      dbo.uTradePartnerVendor AS b ON a.TradepartnerVendorId = b.TradePartnerVendorID
WHERE     ((CAST(a.SeasonYearID AS NVARCHAR(50)) + CAST(c.StyleID AS NVARCHAR(50))) IN
                          (SELECT     CAST(SeasonYearID AS NVARCHAR(50)) + CAST(StyleID AS NVARCHAR(50)) AS Expr1
                            FROM          dbo.pStyleSeasonYear))


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '5.0.0000', '04521', GetDate())
GO
