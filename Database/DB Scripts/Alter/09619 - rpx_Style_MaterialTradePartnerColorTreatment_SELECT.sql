IF OBJECT_ID(N'[dbo].[rpx_Style_MaterialTradePartnerColorTreatment_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[rpx_Style_MaterialTradePartnerColorTreatment_SELECT]
GO

--STORED PROCEDURE

CREATE    PROCEDURE [dbo].[rpx_Style_MaterialTradePartnerColorTreatment_SELECT]
(
	@Season nvarchar(100),
	@Year   nvarchar(100)
)
AS 
SELECT
	pMaterial.B 		 AS Season,
	pMaterial.D 		 AS [Year],
	pMaterial.MaterialNo AS MaterialsCode,	
	pMaterial.MaterialName,
 	pMaterial.Q 		 AS VendorMill,
	pMaterial.R 		 AS VendorMillRefNO, 
	pMaterial.G 		 AS Content,
	pMaterial.H 		 AS Construction,
	pMaterial.I 		 AS YarnSizeCount,
	pMaterial.J 		 AS Guage,
	pMaterial.K 		 AS Weight,
	CAST (pStyleMaterials.QTY AS Decimal(18,4)) 	AS Quantity,	
	pStyleMaterials.Placement,
	pStyleMaterials.MaterialSize 					AS Treatment,
	pMaterialColor.ColorCode,
	pMaterialColor.ColorName,
	pMaterialTradePartnerColor.MaterialTradeColor2  AS SupplierColorCode,
	pMaterialTradePartnerColor.MaterialTradeColor3  AS SupplierColorName,
	pMaterialTradePartnerColor.MaterialTradeColor4  AS FabricDuty,
	pMaterialTradePartnerColor.MaterialTradeColor5  AS LeadTime,
	pMaterialTradePartnerColor.MaterialTradeColor6  AS Minimum,
	pMaterialTradePartnerColor.MaterialTradeColor7  AS SupplierPrice,
	pMaterialTradePartnerColor.MaterialTradeColor8  AS NegotPrice,
	pMaterialTradePartnerColor.MaterialTradeColor16 AS COO,
	pMaterialTradePartnerColor.MaterialTradeColor17 AS CuttableWidth,
	pMaterialTradePartnerColor.MaterialTradeColor18 AS FabricFreight,
	
	pComponentType.ComponentDescription 			AS [MaterialType],
--	sh.[Description],
	sh.STYLENO 							AS StylesWhereUsed,
	COALESCE(sc.Custom, sh.SizeClass) AS SizeClass,
	sh.CustomField9 						AS Status
FROM  pMaterial 
	INNER  JOIN pMaterialTradePartnerColor ON  pMaterial.MaterialID =pMaterialTradePartnerColor.MaterialID 
	INNER  JOIN pMaterialColor 			   ON  pMaterialTradePartnerColor.MaterialColorID = pMaterialColor.MaterialColorID
	INNER  JOIN	pStyleMaterials            ON  pMaterial.MaterialID     = pStyleMaterials.MaterialID
	INNER  JOIN pComponentType	           ON  pMaterial.MaterialType 	 = pComponentType.ComponentTypeID	
	INNER  JOIN pStyleHeader sh	           ON  pStyleMaterials.StyleID  = sh.StyleID
	LEFT JOIN pSizeClass sc ON sc.CustomID = sh.SizeClassId
WHERE pMaterial.B = @Season and pMaterial.D = @Year 
ORDER BY pMaterial.MaterialNo, pMaterial.MaterialName --, sh.StyleNo 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09619', GetDate())
GO
