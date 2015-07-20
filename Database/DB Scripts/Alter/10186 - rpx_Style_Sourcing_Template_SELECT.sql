IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_Sourcing_Template_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_Sourcing_Template_SELECT]
GO

CREATE    PROCEDURE [dbo].[rpx_Style_Sourcing_Template_SELECT]
(
	@StyleSourcingID nvarchar(255)
)

AS

--Variables.
DECLARE @StyleID uniqueidentifier


--Temp tables.
CREATE TABLE #tempSourcingHeaderInfo
(
	TableRow int identity(1,1),
	SourcingName nvarchar(200),
	Active int,
	Trade_Partner nvarchar(200),
	Vendor nvarchar(200)
)

CREATE TABLE #tempAllSourcingInfo
(
	TableRow int identity(1,1),
	SourcingName nvarchar(200),
	Active int,
	Trade_Partner nvarchar(200),
	Vendor nvarchar(200),
	StyleID uniqueidentifier,
	StyleSet int,
	SetName nvarchar(50),
	Colorway_Name nvarchar(100),
	Material_Image_Path nvarchar(1000),
	Material nvarchar(255),
	Treatment_Size_Guage nvarchar(200),
	Supplier_Mill nvarchar(400),
	Color_Image_Path nvarchar(1000),
	Rating nvarchar(50),
	UOM nvarchar(50),
	Price money
)

--Get StyleID from the pStyleSourcing table.
SELECT	@StyleID = StyleID
FROM	pStyleSourcing
WHERE	StyleSourcingID = @StyleSourcingID


--Get header information for the sourcing template.
INSERT INTO #tempSourcingHeaderInfo(
	SourcingName,
	Active,
	Trade_Partner,
	Vendor)
SELECT	pStyleSourcing.SourcingName,
	pStyleSourcing.Active,
	uTradePartner.TradePartnerName AS Trade_Partner,
	uTradePartnerVendor.VendorName AS Vendor--,
--	pStyleSourcing.*
FROM	pStyleSourcing
	LEFT OUTER JOIN uTradePartner ON	pStyleSourcing.TradePartnerID = uTradePartner.TradePartnerID
	LEFT OUTER JOIN uTradePartnerVendor ON	pStyleSourcing.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID
WHERE	pStyleSourcing.StyleID = @StyleID

--Get individual sourcing material records.
INSERT INTO #tempAllSourcingInfo(
	StyleSet,
	Colorway_Name,
	Material_Image_Path,
	Material,
	Treatment_Size_Guage,
	Supplier_Mill,
	Color_Image_Path,
	Rating,
	UOM,
	Price)
SELECT	pStyleSourcingItem.StyleSet,
	pStyleColorway.MainColor AS Colorway_Name,
	dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version], 2000) AS Material_Image_Path,	--Comment #01
	pStyleMaterials.MaterialNo + ' - ' + pStyleMaterials.MaterialName AS Material,
	pStyleMaterials.MaterialSize AS Treatment_Size_Guage,
	uTradePartner.TradePartnerName + ' - ' + uTradePartnerVendor.VendorName AS Supplier_Mill,
	dbo.fnx_GetStreamingColorImagePath(pMaterialColor.ColorFolderID, pMaterialColor.ColorPaletteID, '100') AS Color_Image_Path,	--Comment #02
	pStyleSourcingItem.Qty AS Rating,
	pStyleSourcingItem.UOM,
	pStyleSourcingItem.MaterialPrice AS Price
FROM	pStyleSourcingItem
	INNER JOIN pStyleColorway ON	pStyleSourcingItem.StyleColorID = pStyleColorway.StyleColorID
	LEFT OUTER JOIN pStyleColorwayItem ON	(pStyleSourcingItem.StyleColorID = pStyleColorwayItem.StyleColorID
											AND pStyleSourcingItem.StyleMaterialID = pStyleColorwayItem.StyleMaterialID)
	LEFT OUTER JOIN pMaterialColor ON	pStyleColorwayItem.MaterialColorID = pMaterialColor.MaterialColorID
	INNER JOIN pStyleMaterials ON	pStyleSourcingItem.StyleMaterialID = pStyleMaterials.StyleMaterialID
	LEFT OUTER JOIN	uTradePartnerVendor ON	pStyleSourcingItem.TradePartnerVendorID = uTradePartnerVendor.TradePartnerVendorID
	LEFT OUTER JOIN uTradePartner ON	uTradePartnerVendor.TradePartnerID = uTradePartner.TradePartnerID
	LEFT OUTER JOIN hImage ON	(pStyleMaterials.MaterialImageID = hImage.ImageID
								AND pStyleMaterials.MaterialImageVersion = hImage.Version)
WHERE	pStyleSourcingItem.StyleSourcingID = @StyleSourcingID
ORDER BY	pStyleSourcingItem.StyleSet,
	pStyleColorway.Sort,
	pStyleColorway.MainColor,
	pStyleMaterials.MainMaterial DESC,
	pStyleMaterials.MaterialType,
	pStyleMaterials.MaterialSort,
	pStyleMaterials.MaterialNo,
	pStyleMaterials.MaterialName

--Add the sourcing template header info to the full temp table.
UPDATE	#tempAllSourcingInfo
SET	#tempAllSourcingInfo.SourcingName = #tempSourcingHeaderInfo.SourcingName,
	#tempAllSourcingInfo.Active = #tempSourcingHeaderInfo.Active,
	#tempAllSourcingInfo.Trade_Partner = #tempSourcingHeaderInfo.Trade_Partner,
	#tempAllSourcingInfo.Vendor = #tempSourcingHeaderInfo.Vendor
FROM	#tempSourcingHeaderInfo

--Add the StyleID to the full temp table to do joins.
UPDATE	#tempAllSourcingInfo
SET	#tempAllSourcingInfo.StyleID = @StyleID

--Add the set names from the pStyleHeader table.
UPDATE	#tempAllSourcingInfo
SET	#tempAllSourcingInfo.SetName =	CASE
										WHEN #tempAllSourcingInfo.StyleSet = 1 THEN	PC1
										WHEN #tempAllSourcingInfo.StyleSet = 2 THEN	PC2
										WHEN #tempAllSourcingInfo.StyleSet = 3 THEN	PC3
										WHEN #tempAllSourcingInfo.StyleSet = 4 THEN	PC4
									END
FROM	#tempAllSourcingInfo
	INNER JOIN pStyleHeader ON	#tempAllSourcingInfo.StyleID = pStyleHeader.StyleID

--Set the default set names if the set names were NULL.
UPDATE	#tempAllSourcingInfo
SET	SetName =	CASE
					WHEN StyleSet = 1 THEN	'1st Set'
					WHEN StyleSet = 2 THEN	'2nd Set'
					WHEN StyleSet = 3 THEN	'3rd Set'
					WHEN StyleSet = 4 THEN	'4th Set'
				END
FROM	#tempAllSourcingInfo
WHERE	(SetName IS NULL
		OR SetName = '')

--Select the information for the report.
SELECT	--SourcingName,
--	Active,
--	Trade_Partner,
--	Vendor,
--	StyleID,
	StyleSet,
	SetName,
	Colorway_Name,
	Material_Image_Path,
	Material,
	Treatment_Size_Guage,
	Supplier_Mill,
	Color_Image_Path,
	Rating,
	UOM,
	Price
FROM	#tempAllSourcingInfo

--Drop temp tables.
DROP TABLE #tempSourcingHeaderInfo
DROP TABLE #tempAllSourcingInfo


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10186', GetUTCDate())
GO