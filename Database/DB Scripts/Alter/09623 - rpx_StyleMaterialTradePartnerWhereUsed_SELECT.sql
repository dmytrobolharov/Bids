IF OBJECT_ID(N'[dbo].[rpx_StyleMaterialTradePartnerWhereUsed_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[rpx_StyleMaterialTradePartnerWhereUsed_SELECT]
GO

CREATE PROCEDURE [dbo].[rpx_StyleMaterialTradePartnerWhereUsed_SELECT] 
	@Season nvarchar(200) = null,
	@Year nvarchar(200) = null
AS

SELECT TOP 1000 pComponentType.ComponentDescription AS MaterialType, pStyleMaterials.MaterialNo, pStyleMaterials.MaterialName, 
      pStyleMaterials.G AS MaterialContent, sh.StyleNo, COALESCE(sc.Custom, sh.SizeClass) AS SizeClass, 
	  sh.CustomField1 AS StyleCategory, sh.CustomField2 AS StyleSeason, sh.CustomField4 AS StyleYear, 
	  pMaterialTradePartnerColor.ColorName, pMaterialTradePartnerColor.ColorCode, uTradePartner.TradePartnerCode, 
	  uTradePartner.TradePartnerName, uTradePartnerVendor.VendorCode, uTradePartnerVendor.VendorName
FROM         uTradePartner INNER JOIN
                      pMaterialTradePartner INNER JOIN
                      pMaterialTradePartnerColor ON pMaterialTradePartner.MaterialTradePartnerId = pMaterialTradePartnerColor.MaterialTradePartnerID ON 
                      uTradePartner.TradePartnerID = pMaterialTradePartner.TradepartnerId INNER JOIN
                      uTradePartnerVendor ON pMaterialTradePartner.TradepartnerVendorId = uTradePartnerVendor.TradePartnerVendorID INNER JOIN
                      pStyleHeader sh INNER JOIN
                      pStyleMaterials ON sh.StyleID = pStyleMaterials.StyleID INNER JOIN
                      pComponentType ON pStyleMaterials.MaterialType = pComponentType.ComponentTypeID ON 
                      pMaterialTradePartner.MaterialId = pStyleMaterials.MaterialID
LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09623', GetDate())
GO
