IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_Style_Sourcing_MaterialColorway_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_Style_Sourcing_MaterialColorway_SELECT]
GO

CREATE      PROCEDURE [dbo].[rpx_Style_Sourcing_MaterialColorway_SELECT]
(
	@StyleMaterialID nvarchar(255)
)

AS

-- --Test values
-- DECLARE @StyleMaterialID nvarchar(255)
-- SET @StyleMaterialID = '3b810db7-ed87-4a09-bc04-23e6bfc06bf8'


--Temp tables
CREATE TABLE #tempMaterials(
	ParentMaterialName nvarchar(100)
	,ParentMaterialColorChipName nvarchar(100)
	,ParentMaterialColorChipFilePath nvarchar(255)
	,SubMaterialName nvarchar(100)
	,SubMaterialColorChipName nvarchar(100)
	,SubMaterialColorChipFilePath nvarchar(255)
	,MaterialLinkID nvarchar(50)
	,ParentMaterialColorImageID nvarchar(50)
	,ParentMaterialColorImageVersion int
	,SubMaterialColorImageID nvarchar(50)
	,SubMaterialColorImageVersion int
)


--Get all materials for the style
INSERT INTO #tempMaterials(
	ParentMaterialName
	,ParentMaterialColorChipName
	,ParentMaterialColorChipFilePath
	,SubMaterialName
	,SubMaterialColorChipName
	,SubMaterialColorChipFilePath
	,MaterialLinkID
	,ParentMaterialColorImageID
	,ParentMaterialColorImageVersion
	,SubMaterialColorImageID
	,SubMaterialColorImageVersion
)
SELECT	pStyleMaterials.MaterialNo + ' - ' + pStyleMaterials.MaterialName AS ParentMaterialName,
	'(' + pMaterialColor.ColorCode + ') ' + pMaterialColor.ColorName AS ParentMaterialColorChipName,
	dbo.fnx_GetStreamingColorImagePath(pMaterialColor.ColorFolderID, pMaterialColor.ColorPaletteID, '100') AS ParentMaterialColorChipFilePath,	--Comment #02
	pMaterial_Subs.MaterialNo + ' - ' + pMaterial_Subs.MaterialName AS SubMaterialName,
	'(' + pMaterialColor_Subs.ColorCode + ') ' + pMaterialColor_Subs.ColorName AS SubMaterialColorChipName,
	dbo.fnx_GetStreamingColorImagePath(pMaterialColor_Subs.ColorFolderID, pMaterialColor_Subs.ColorPaletteID, '100') AS SubMaterialColorChipFilePath,	--Comment #02
	CAST(pMaterialLink.MaterialLinkID AS nvarchar(50)) AS MaterialLinkID,
	pMaterialColor.MaterialColorImageID AS ParentMaterialColorImageID,
	pMaterialColor.MaterialColorImageVersion AS ParentMaterialColorImageVersion,
	pMaterialColor_Subs.MaterialColorImageID AS SubMaterialColorImageID,
	pMaterialColor_Subs.MaterialColorImageVersion AS SubMaterialColorImageVersion
FROM	pStyleMaterials
	INNER JOIN pMaterial ON	pStyleMaterials.MaterialID = pMaterial.MaterialID
	INNER JOIN pStyleColorwayItem ON	pStyleMaterials.StyleMaterialID = pStyleColorwayItem.StyleMaterialID
	INNER JOIN pMaterialColor ON	pStyleColorwayItem.MaterialColorID = pMaterialColor.MaterialColorID
	INNER JOIN pStyleColorway ON	pStyleColorwayItem.StyleColorID = pStyleColorway.StyleColorID
	INNER JOIN pMaterialLink ON	pStyleMaterials.MaterialID = pMaterialLink.MaterialGroupID
	INNER JOIN pMaterial AS pMaterial_Subs ON	pMaterialLink.MaterialID = pMaterial_Subs.MaterialID
	INNER JOIN pMaterialLinkColorway ON	(pStyleColorwayItem.MaterialID = pMaterialLinkColorway.MaterialGroupID
										AND	pStyleColorwayItem.MaterialColorID = pMaterialLinkColorway.MaterialColorID)
	INNER JOIN pMaterialLinkColorwayItem ON	(pMaterialLinkColorway.MaterialLinkColorwayID = pMaterialLinkColorwayItem.MaterialLinkColorwayID
											AND	pMaterial_Subs.MaterialID = pMaterialLinkColorwayItem.MaterialID
											AND pMaterialLink.MaterialLinkID = pMaterialLinkColorwayItem.MaterialLinkID)
	LEFT OUTER JOIN pMaterialColor AS pMaterialColor_Subs ON	pMaterialLinkColorwayItem.MaterialColorID = pMaterialColor_Subs.MaterialColorID
WHERE	(pStyleMaterials.StyleMaterialID = @StyleMaterialID)
	AND	(pStyleMaterials.Colorway = 1 )
	AND	(pMaterial.MultiDimension = 1)
ORDER BY	pStyleColorway.Sort,
	pStyleColorway.MainColor,
	pMaterial_Subs.MaterialType,
	pMaterial_Subs.MaterialNo,
	pMaterial_Subs.MaterialName

--Update the temp table for the Parent Material chips that are images from the Image folder.
UPDATE #tempMaterials
SET ParentMaterialColorChipFilePath = dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version])	--Comment #01
FROM #tempMaterials
	INNER JOIN hImage ON	(#tempMaterials.ParentMaterialColorImageID = hImage.ImageID
							AND #tempMaterials.ParentMaterialColorImageVersion = hImage.Version)

--Update the temp table for the Sub Material chips that are images from the Image folder.
UPDATE #tempMaterials
SET SubMaterialColorChipFilePath = dbo.fnx_GetStreamingImagePath(hImage.ImageID, hImage.[Version])	--Comment #01
FROM #tempMaterials
	INNER JOIN hImage ON	(#tempMaterials.SubMaterialColorImageID = hImage.ImageID
							AND #tempMaterials.SubMaterialColorImageVersion = hImage.Version)

--SELECT the records
SELECT
	ParentMaterialName
	,ParentMaterialColorChipName
	,ParentMaterialColorChipFilePath
	,SubMaterialName
	,SubMaterialColorChipName
	,SubMaterialColorChipFilePath
	,MaterialLinkID
	,*
FROM #tempMaterials

--Drop temp tables
DROP TABLE #tempMaterials


GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10185', GetUTCDate())
GO